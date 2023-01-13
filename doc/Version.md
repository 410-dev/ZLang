# Documentation: @version

**Description**

This command allows script / user to read the version of ZLang interpreter / runtime.



### Usage

Developers may use `@version`  to obtain current version of ZLang interpreter / runtime.

`@version` is a command that prints the version of ZLang interpreter / runtime. To obtain version string only, use the following variables in 'Variables' section below.



### Variables

`EBVERSION`: Contains a string of version information such as: `1.0.0 Alpha 1 `, `1.0.1 Release`, `1.0.2 Beta`.

`EBVERSION_MAJOR`: Contains a major release version information, which is the first part when separated by period from version string. 
Ex. 1 in 1.0.2 Release

`EBVERSION_MINOR`: Contains a minor release version information, which is the second part when separated by period from version string.
Ex. 0 in 1.0.2 Release

`EBVERSION_REVISION`: Contains a revesion version information, which is the last part when separated by period from version string.
Ex. 2 in 1.0.2 Release

`EBVERSION_EDITION`: A string that contains the edition of version. 
Ex. Release in 1.0.2 Release