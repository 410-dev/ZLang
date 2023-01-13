#!/bin/zsh

# Check if zlang is already installed
if [[ -f "/private/etc/paths.d/zlang" ]] && [[ -z "$1" ]]; then
	echo "zlang is already installed. Add version parameter to override this error."
	exit 8
fi

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
sudo curl -L --progress-bar "${GIT_RELEASE_URL}/${runtimeVersionRequest}/ZLang-${runtimeVersionRequest}.zip" -o "/tmp/zlang.zip"
if [[ ! $? == 0 ]]; then
	echo "Failed downloading runtime."
	unset GIT_LATEST_URL GIT_RELEASE_URL runtimeVersionRequest	
	exit 6
fi

if [[ -z "$(file "/tmp/zlang.zip" | grep "Zip archive data")" ]]; then
	echo "Downloaded file is broken. (Not zip archive)"
	exit 5
fi

export ROOT="/usr/local/zlang"
if [[ -z "$2" ]]; then
	export INSTALLDIR="${ROOT}/${runtimeVersionRequest}/"
	echo "To save, the tool needs superuser permission."
	sudo echo -n ""
	if [[ $? == 0 ]]; then
		echo "Granted."
	else
		echo "Failed granting superuser permission."
		unset GIT_LATEST_URL GIT_RELEASE_URL runtimeVersionRequest INSTALLDIR
		exit 7
	fi
else
	export INSTALLDIR="$2"
fi

echo "Unpacking..."
sudo mkdir -p "$INSTALLDIR"
sudo unzip -qo "/tmp/zlang.zip" -d "$INSTALLDIR"
if [[ ! $? == 0 ]]; then
	echo "Failed unpacking."
	unset GIT_LATEST_URL GIT_RELEASE_URL runtimeVersionRequest INSTALLDIR
	exit 4
fi
sudo rm -rf "$INSTALLDIR/__MACOSX"

# If it is not localizing runtime
if [[ -z "$2" ]]; then
	# Add to zshrc

	if [[ -e "$ROOT/selected" ]]; then
		echo "Removing old selected version..."
		sudo rm -f "$ROOT/selected"
	fi
	echo "Creating new selected version..."
	sudo ln -s "$INSTALLDIR" "$ROOT/selected"

	echo "Adding zlang loader to zshrc..."
	if [[ -z "$(cat ~/.zshrc | grep "ZLANG_HOME=")" ]]; then
		echo "# Load zlang" >> ~/.zshrc
		echo "export ZLANG_HOME=\"$ROOT/selected\"" >> ~/.zshrc
		echo "if [[ -f "\"$ROOT/selected/zlang-linker\"" ]]; then source "$ROOT"/selected/zlang-linker; fi" >> ~/.zshrc
	fi

	# Add to Path
	echo "Adding zlang-linker to path..."
	sudo chmod +x "$INSTALLDIR"/zlang-linker
	sudo chmod +x "$INSTALLDIR"/uninstall-zlang
	sudo rm -rf "$INSTALLDIR/bin"
	sudo mkdir -p "$INSTALLDIR/bin"
	sudo ln -s "$INSTALLDIR/zlang-linker" "$INSTALLDIR/bin/zlang-linker"
	sudo ln -s "$INSTALLDIR/uninstall-zlang" "$INSTALLDIR/bin/uninstall-zlang"
	echo "$INSTALLDIR/bin" | sudo tee -a "/private/etc/paths.d/zlang" > /dev/null

	# Generate receipt
	echo "Generating receipt..."
	echo "/private/etc/paths.d/zlang" | sudo tee -a "$INSTALLDIR/receipt" >/dev/null
	echo "$INSTALLDIR" | sudo tee -a "$INSTALLDIR/receipt" > /dev/null
fi

echo "Cleaning up..."
sudo chown -R "$(echo $(whoami))" "$INSTALLDIR"
sudo rm -rf "/tmp/zlang.zip"

unset GIT_LATEST_URL GIT_RELEASE_URL runtimeVersionRequest INSTALLDIR
echo "Done!"
