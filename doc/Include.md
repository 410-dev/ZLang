# Documentation: @include

**Description**

This command allows script to use functions that are predefined outside of ZLang library.



### Usage

Developers may use `@include <script path / directory path>`  to import and execute a prewritten script file outside of ZLang library.

The given path may be a path to directory that contains multiple scripts, or to a single script file. The command automatically decides the format of the destination whether it is a directory or a script file. If the destination path is a directory, then the command automatically imports by executing all `.ebsrc` file inside the directory. If the destination path is a script file, then the command automatially imports the file by executing the script.

The single script file must use the extension: `.ebsrc`

If developers have to import internal library, it is highly recommended to use [`@import`](./Import.md) command instead.

**Ex.** 

`@include /Users/foo/scripts` : Read all ebsrc files in /Users/foo/scripts.

`@include /Users/foo/scripts/myscript`: Read myscript.ebsrc file in /Users/foo/scripts.

