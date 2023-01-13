# Documentation: @import

**Description**

This command allows script to use functions that are predefined in ZLang library.



### Usage

Developers may use `@import <library>`  to import a predfined library script.

Library may be a bundle of scripts, or can be a single script file. When a library is imported, the command automatically decides the format of the library whether it is a directory or script file. If the library is a bundle, then the command automatically imports all `.ebsrc` file inside the directory. If the library is a script file, then the command automatially imports the file. When developers want to import only one script file in a bundle, then the separator between the bundle name and script file is `/`.

If developers have to import external script files (Outside of predefined library), it is highly recommended to use [`@include`](./Include.md) command instead.



**Ex.** 

`@import Foundation` : Read all Foundation bundle

`@import Foundation/string`: Read default string library from Foundation bundle

