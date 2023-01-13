# Documentation: ZLang

**Description**

This documentation contains how functions and objects should be used.



### General

ZLang is highly improved version of eBash2-CE, which is an extended command bundle of bash. ZLang extended its compatibility to zsh, therefore most of the language syntax follows zsh scripting syntax.



### Types

ZLang is not strong typed language, therefore the parameters of function does not require any casting. However, some function may require certain data formatted as its type. Objects are NOT considered as types, therefore only primitive data types will be considered in this document as well as the other documentations related to function parameters.

1. any
   - Does not require certain type.
2. string
   - A single or series of multiple characters including special characters. Some special characters such as exclamation marks may not be handled.
3. integer
   - Numbers without decimal point or mathematical expression.
4. float
   - Numbers with decimal point and digits but does not include mathematical expression such as fractions.



### Usage

1. [Importing library](./Import.md)
2. [Including script file](./Include.md)
3. [NULL / null](./Null.md)
4. [Run mode](./Runmode.md)
5. [Setting working directory](./Working Directory.md)
6. [Reading runtime version](./Version.md)
7. [Defining Class](./Object.md)



**Other references**

- [Built-in libraries](./lib/index.md)
- [Built-in objects](./objects/index.md)