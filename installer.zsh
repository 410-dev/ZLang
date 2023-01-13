#!/bin/zsh

export ROOT="$HOME/.local/zlang"

# Actual localizing
export GIT_LATEST_URL="https://raw.githubusercontent.com/410-dev/ZLang/main/latest";
export GIT_RELEASE_URL="https://github.com/410-dev/ZLang/releases/download/";

echo "Preparing zlang environment..."

if [[ -z "$1" ]]; then
	export runtimeVersionRequest="latest"
else
	export runtimeVersionRequest="$1"
fi

echo "Requested Runtime: $runtimeVersionRequest"

if [[ "$runtimeVersionRequest" == "latest" ]]; then
	echo "Downloading latest version data..."
	export runtimeVersionRequest=$(curl -Ls "$GIT_LATEST_URL")
fi

echo "Downloading runtime: $runtimeVersionRequest"
curl -L --progress-bar "${GIT_RELEASE_URL}/${runtimeVersionRequest}/ZLang-${runtimeVersionRequest}.zip" -o "/tmp/zlang.zip"
if [[ ! $? == 0 ]]; then
	echo "Failed downloading runtime."
	unset GIT_LATEST_URL GIT_RELEASE_URL runtimeVersionRequest	
	exit 6
fi

if [[ -z "$(file "/tmp/zlang.zip" | grep "Zip archive data")" ]]; then
	echo "Downloaded file is broken. (Not zip archive)"
	exit 5
fi

if [[ -z "$2" ]]; then

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

# If it is not localizing runtime
if [[ -z "$2" ]]; then
	# Add to zshrc

	if [[ -e "$ROOT/selected" ]]; then
		echo "Removing old symbolic link..."
		rm -f "$ROOT/selected"
	fi

	echo "Creating new symbolic link..."
	ln -s "$INSTALLDIR" "$ROOT/selected"

	echo "Adding zlang loader to zshrc..."
	if [[ -z "$(cat ~/.zshrc | grep "ZLANG_HOME=")" ]]; then
		echo "# Load zlang" >> ~/.zshrc
		echo "export ZLANG_HOME=\"$ROOT/selected\"" >> ~/.zshrc
		echo "if [[ -f "\"$ROOT/selected/zlang-linker\"" ]]; then source "$ROOT"/selected/zlang-linker; fi" >> ~/.zshrc
	fi

	# Add to Path
	echo "Adding zlang-linker to path..."
	chmod +x "$INSTALLDIR"/bin/zlang-linker
	chmod +x "$INSTALLDIR"/bin/uninstall-zlang
	# chmod +x "$INSTALLDIR"/zlang-linker
	# chmod +x "$INSTALLDIR"/uninstall-zlang
	# rm -rf "$INSTALLDIR/bin"
	# mkdir -p "$INSTALLDIR/bin"
	ln -s "$INSTALLDIR/zlang-linker" "$INSTALLDIR/bin/zlang-linker"
	# ln -s "$INSTALLDIR/uninstall-zlang" "$INSTALLDIR/bin/uninstall-zlang"
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

unset GIT_LATEST_URL GIT_RELEASE_URL runtimeVersionRequest INSTALLDIR
echo "Done!"
