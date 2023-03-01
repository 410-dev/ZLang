#!/bin/zsh

export ROOT="$HOME/.local/zlang"

# Actual localizing
export GIT_LATEST_URL="https://raw.githubusercontent.com/410-dev/ZLang/main/latest";
export GIT_RELEASE_URL="https://codeload.github.com/410-dev/ZLang/zip/refs/tags";

echo "Preparing zlang environment..."

if [[ -z "$1" ]]; then
	export runtimeVersionRequest="latest"
else
	export runtimeVersionRequest="$1"
fi

MERGEDARGS="$(echo "$@")"

echo "ZLang Installer Mar2023B"
echo "Requested Runtime: $runtimeVersionRequest"

if [[ -z "$(which curl)" ]]; then
	echo "Error: curl is not installed."
	if [[ ! -z "$(which apt-get)" ]]; then
		echo "Trying to install curl using apt-get..."
		sudo apt-get install curl -y
	elif [[ ! -z "$(which pacman)" ]]; then
		echo "Trying to install curl using pacman..."
		sudo pacman -S curl
	elif [[ ! -z "$(which dnf)" ]]; then
		echo "Trying to install curl using dnf..."
		sudo dnf install curl
	elif [[ ! -z "$(which yum)" ]]; then
		echo "Trying to install curl using yum..."
		sudo yum install curl
	else
		echo "Error: Failed to install curl. Please install curl manually."
		exit 1
	fi
	exit 1
fi

if [[ "$runtimeVersionRequest" == "latest" ]]; then
	echo "Downloading latest version data..."
	export runtimeVersionRequest=$(curl -Ls "$GIT_LATEST_URL")
fi

echo "Downloading runtime: $runtimeVersionRequest"
curl -L --progress-bar "${GIT_RELEASE_URL}/${runtimeVersionRequest}" -o "/tmp/zlang.zip"
if [[ ! $? == 0 ]]; then
	echo "Failed downloading runtime."
	unset GIT_LATEST_URL GIT_RELEASE_URL runtimeVersionRequest
	exit 6
fi

if [[ -z "$(file "/tmp/zlang.zip" | grep "Zip archive data")" ]]; then
	echo "Downloaded file is broken. (Not zip archive)"
	exit 5
fi

if [[ -z "$2" ]] || [[ "$2" == "default" ]]; then

	# Check if user is root
	if [[ "$USER" == "root" ]]; then
		export ROOT="/usr/local/zlang"
		echo -e "\033[93mWarning: Running as root! This is not recommended. ZLang runtime will be installed at $ROOT.\033[39m"
	fi

	export INSTALLDIR="${ROOT}/${runtimeVersionRequest}/"
else
	export INSTALLDIR="$2"
fi

# Check if directory exists
if [[ -d "$INSTALLDIR" ]]; then
	echo "Removing old version..."
	rm -rf "$INSTALLDIR" 2> /dev/null
	if [[ ! $? == 0 ]]; then
		echo "Failed removing old version. Retrying with sudo..."
		sudo rm -rf "$INSTALLDIR" 2> /dev/null
		if [[ ! $? == 0 ]]; then
			echo "Failed removing old version."
			unset GIT_LATEST_URL GIT_RELEASE_URL runtimeVersionRequest INSTALLDIR
			exit 3
		fi
	fi
fi

echo "Unpacking..."
mkdir -p "$INSTALLDIR"
unzip -qo "/tmp/zlang.zip" -d "$INSTALLDIR"
if [[ ! $? == 0 ]]; then
	echo "Failed unpacking."
	unset GIT_LATEST_URL GIT_RELEASE_URL runtimeVersionRequest INSTALLDIR
	exit 4
fi
rm -rf "$INSTALLDIR/__MACOSX"
rm -rf "$INSTALLDIR/.gitignore"
rm -rf "$INSTALLDIR/.gitattributes"

echo "Moving decompressed packages..."
mv -f "$INSTALLDIR/ZLang-$runtimeVersionRequest"/* "$INSTALLDIR"
if [[ ! $? == 0 ]]; then
	echo "Failed moving decompressed packages."
	unset GIT_LATEST_URL GIT_RELEASE_URL runtimeVersionRequest INSTALLDIR
	exit 4
fi
rm -rf "$INSTALLDIR/ZLang-$runtimeVersionRequest"

# If it is not localizing runtime
if [[ -z "$2" ]] || [[ "$2" == "default" ]] ; then
	# Add to zshrc

	if [[ -e "$ROOT/selected" ]]; then
		echo "Removing old symbolic link..."
		rm -f "$ROOT/selected"
	fi

	echo "Creating new symbolic link..."
	ln -sf "$INSTALLDIR" "$ROOT/selected"

	echo "Adding zlang loader to zshrc..."
	if [[ -z "$(cat ~/.zshrc | grep "ZLANG_HOME=")" ]]; then
		echo "# Load zlang" >> ~/.zshrc
		echo "export ZLANG_HOME=\"$ROOT/selected\"" >> ~/.zshrc
		echo "if [[ -f "\"$ROOT/selected/zlang-linker\"" ]]; then source "$ROOT"/selected/zlang-linker; fi" >> ~/.zshrc
		echo "alias zshrc=\"source ~/.zshrc\"" >> ~/.zshrc
	fi

	if  [[ "$3" == "--bash" ]]; then
		echo "Adding zlang loader to bashrc..."
		if [[ ! -f ~/.bashrc ]] || [[ -z "$(cat ~/.bashrc | grep "ZLANG_HOME=")" ]]; then
			echo "# Load zlang" >> ~/.bashrc
			echo "export ZLANG_HOME=\"$ROOT/selected\"" >> ~/.bashrc
			echo "if [[ -f "\"$ROOT/selected/zlang-linker\"" ]]; then source "$ROOT"/selected/zlang-linker; fi" >> ~/.bashrc
			echo "alias bashrc=\"source ~/.bashrc\"" >> ~/.bashrc
		fi

		if  [[ "$4" == "--profile" ]]; then
			echo "Adding zlang loader to bash_profile..."
			if [[ ! -f ~/.bash_profile ]] || [[ -z "$(cat ~/.bash_profile | grep "ZLANG_HOME=")" ]]; then
				echo "# Load zlang" >> ~/.bash_profile
				echo "export ZLANG_HOME=\"$ROOT/selected\"" >> ~/.bash_profile
				echo "if [[ -f "\"$ROOT/selected/zlang-linker\"" ]]; then source "$ROOT"/selected/zlang-linker; fi" >> ~/.bash_profile
				echo "alias bash_profile=\"source ~/.bash_profile\"" >> ~/.bash_profile
			fi
		fi
	fi

	# Add to Path
	echo "Adding zlang-linker to path..."
	ln -s "$INSTALLDIR/zlang-linker" "$INSTALLDIR/bin/zlang-linker"
	chmod +x "$INSTALLDIR"bin/zlang-linker
	chmod +x "$INSTALLDIR"bin/zlang-uninstall
	chmod +x "$INSTALLDIR"bin/zlang-select
	if [[ "$USER" == "root" ]]; then
		echo "$ROOT/selected/bin" > "/private/etc/paths.d/zlang"
		echo -e "\033[93mWarning: Running as root! This is not recommended. Path is set by creating /etc/paths.d/zlang.\033[39m"
	else
		echo "Exporting path to $HOME/.zshrc..."
		if [[ -z "$(echo "$(cat "$HOME/.zshrc" | grep "export PATH=")" | grep "/selected/bin")" ]]; then
			echo "export PATH=\"$ROOT/selected/bin:\$PATH\"" >> "$HOME/.zshrc"
		else
			echo "Path is already set."
		fi
	fi

	# Generate receipt
	echo "Generating receipt..."
	if [[ "$USER" == "root" ]]; then
		echo "/private/etc/paths.d/zlang" > "$INSTALLDIR/receipt"
		echo -e "\033[93mWarning: Running as root! This is not recommended. Path setter at /etc/paths.d/zlang is added to removal receipt.\033[39m"
	fi
	echo "$INSTALLDIR" >> "$INSTALLDIR/receipt"
fi

echo "Cleaning up..."
chown -R "$(echo $(whoami))" "$INSTALLDIR"
rm -rf "/tmp/zlang.zip"

unset GIT_LATEST_URL GIT_RELEASE_URL runtimeVersionRequest INSTALLDIR MERGEDARGS
echo "Done!"
