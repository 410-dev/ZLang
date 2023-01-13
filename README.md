# ZLang

### Excel a shell script - Improve, simplify, extend shell script.


#### Overview

ZLang is a successor of eBash2 with greater compatibility and extended features. It is a shell script extension runtime which has more user-friendly commands and utilities.


#### Installation
```bash 
curl -Ls 
```

If you are writing a script, you MUST prepend this code to the script file in order to fully load ZLang library.
```bash
source $ZLANG_HOME/zlang-linker $ZLANG_HOME
```

<br>
<br>


#### Native Translator (WIP)

Since the mechanism of eBash2 runtime is not as efficient as the native bash script, an eBash2 to native bash translator using Java is currently under development.
It dramatically increases the script size for sure, but is uncertain about the performance.

[Check it out from here.](https://github.com/410-dev/eBash2-translator)

<br>

<br>

#### Documentation

[Go to documentation](./doc/Main.md)

