# ZLang

### Excel a shell script - Improve, simplify, extend shell script.


#### Overview

ZLang is a successor of eBash2 with greater compatibility and extended features. It is a shell script extension runtime which has more user-friendly commands and utilities.


#### Installation
```bash 
curl -Ls https://raw.githubusercontent.com/410-dev/ZLang/main/installer.zsh | zsh
```

If you are writing a script, you MUST prepend this code to the script file in order to fully load ZLang library.
```bash
source $ZLANG_HOME/zlang-linker $ZLANG_HOME
```

<br>
<br>


#### Native Translator (WIP)

Since the mechanism of ZLang runtime is not as efficient as the native zsh script, an ZLang to native bash translator using Java is currently under development.

<br>

<br>

#### Documentation

[Go to documentation](./doc/Main.md)

