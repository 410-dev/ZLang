# ZLang

### Excel a shell script - Improve, simplify, extend shell script.

### Overview

ZLang is a successor of eBash2 with greater compatibility and extended features. It is a shell script extension runtime which has more user-friendly commands and utilities.

### Installation

```bash 
curl -Ls https://raw.githubusercontent.com/410-dev/ZLang/main/installer.zsh | zsh
```

If you are writing a script, you MUST prepend this code to the script file in order to fully load ZLang library.

```bash
#!/bin/zsh
source $ZLANG_HOME/zlang-linker $ZLANG_HOME
```

<br>
<br>

### Native Translator (WIP)

ZLang script requires library to fully function. However, if developers use [ZLang2Native](https://github.com/410-dev/ZLang2Native), then the ZLang script will be able to be run on machines that do not have ZLang library installed.

<br>

<br>

### Uninstalling

Type the following command:

```shell
zlang-uninstall
```



### Changing runtime version (If installed multiple versions)

To see selectable versions:

```shell
zlang-select
```

To change version:

```shell
zlang-select <version>
```



#### Disabling non-zsh environment warning

To remove "Warning: ZLang is intended to run in zsh environment." message, prepend `export ZLANG_SUPPRESS_WARNING="YES"` to either .bashrc or .bash_profile.



#### Documentation

[Go to documentation](./doc/Main.md)

