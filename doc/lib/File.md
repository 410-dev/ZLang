# Documentation: File

Library Type: Built-in library bundle

**Description**

Manages the file system with specific functions.




## File/archive

**Dependencies**

Foundation: exception, string

File: check, new, attribute

[LINUX: zip, unzip]



#### File.compress()

This method creates an archive (.zip) without root structure.

| Index | Type           | Purpose                               | Required |
| ----- | -------------- | ------------------------------------- | -------- |
| 1     | default string | Path to file or directory to compress | Yes      |

**Example**

```shell
File.compress /Users/foo/Documents/compressthis
```



#### File.compressAbsolutePathStructure()

This method creates an archive (.zip) with root structure.

| Index | Type           | Purpose                               | Required |
| ----- | -------------- | ------------------------------------- | -------- |
| 1     | default string | Path to file or directory to compress | Yes      |

**Example**

```shell
File.compressAbsolutePathStructure /Users/foo/Documents/compressthis
```



#### File.decompress()

This method creates an archive (.zip) without root structure.

| Index | Type           | Purpose                                   | Required |
| ----- | -------------- | ----------------------------------------- | -------- |
| 1     | default string | Path to file or directory to archive file | Yes      |
| 2     | default string | Path to destination directory             | Yes      |

**Example**

```shell
File.decompress /Users/foo/Documents/compressed.zip
```





## File/attribute

**Dependencies**

Foundation: exception, string

File: check

#### File.setHidden() - Linux unsupported

Set a file or directory to hidden state.

| Index | Type                 | Purpose                   | Required |
| ----- | -------------------- | ------------------------- | -------- |
| 1     | boolean (true/false) | Flag of hidden / revealed | Yes      |
| 2     | default string       | Path to file or directory | Yes      |

**Example**

```shell
File.setHidden true /Users/foo/Documents/hide # Hide file / directory
```



#### File.rename()

| Index | Type           | Purpose                           | Required |
| ----- | -------------- | --------------------------------- | -------- |
| 1     | default string | Path to initial file or directory | Yes      |
| 2     | default string | Path to final file or directory   | Yes      |

**Example**

```shell
File.rename /Users/foo/Downloads/file1 /Users/foo/Documents/file2
```





## File/check

**Dependencies**

Foundation: exception, string

#### File.exists()

Check if the path is either directory or file.

| Index | Type           | Purpose                       | Required |
| ----- | -------------- | ----------------------------- | -------- |
| 1     | default string | Path to check                 | Yes      |
| 2     | default string | Variable name to store result | No       |

**Example**

```shell
File.exists /Users/foo/Documents/test
```

```shell
File.exists /Users/foo/Documents/test isExist # isExist is now a variable containing 'true' or 'false'
```



#### File.isDirectory()

Check if the path is directory.

| Index | Type           | Purpose                       | Required |
| ----- | -------------- | ----------------------------- | -------- |
| 1     | default string | Path to check                 | Yes      |
| 2     | default string | Variable name to store result | No       |

**Example**

```shell
File.isDirectory /Users/foo/Documents/test
```

```shell
File.isDirectory /Users/foo/Documents/test isExist # isExist is now a variable containing 'true' or 'false'
```



#### File.isFile()

Check if the path is file.

| Index | Type           | Purpose                       | Required |
| ----- | -------------- | ----------------------------- | -------- |
| 1     | default string | Path to check                 | Yes      |
| 2     | default string | Variable name to store result | No       |

**Example**

```shell
File.isFile /Users/foo/Documents/test
```

```shell
File.isFile /Users/foo/Documents/test isExist # isExist is now a variable containing 'true' or 'false'
```



## File/copy

**Dependencies**

Foundation: exception, string

File: check

#### File.copyFile()

Copy a file to a directory.

| Index | Type           | Purpose             | Required |
| ----- | -------------- | ------------------- | -------- |
| 1     | default string | Path to source      | Yes      |
| 2     | default string | Path to destination | Yes      |

**Example**

```shell
File.copyFile /Users/foo/Downloads/source /Users/foo/Documents
```



#### File.copyDirectory()

Copy a directory to a directory.

| Index | Type           | Purpose             | Required |
| ----- | -------------- | ------------------- | -------- |
| 1     | default string | Path to source      | Yes      |
| 2     | default string | Path to destination | Yes      |

If the first parameter ends with `/`, then it will copy the files inside the directory to destination. Otherwise, it will copy a directory as a whole.

**Example**

```shell
File.copyDirectory /Users/foo/Downloads/myFolder /Users/foo/Documents/myOtherFolder
```

```shell
File.copyDirectory /Users/foo/Downloads/myFolder/ /Users/foo/Documents/myOtherFolder
```



## File/list

**Dependencies**

Foundation: exception, string

#### File.list()

Make a list of files and directories in directory

| Index | Type           | Purpose                  | Required |
| ----- | -------------- | ------------------------ | -------- |
| 1     | default string | Path to target directory | Yes      |
| 2     | default string | Option to `ls`           | No       |

**Example**

```shell
File.list /Users/foo/Documents
```



## File/name

**Dependencies**

Foundation: exception, string

#### File.getFileName()

Get name of a file or directory including extension

| Index | Type           | Purpose                          | Required |
| ----- | -------------- | -------------------------------- | -------- |
| 1     | default string | Path to target file or directory | Yes      |
| 2     | default string | Variable name to store result    | No       |

**Example**

```shell
File.getFileName /Users/foo/Documents
```

```shell
File.getFileName /Users/foo/Documents fName # variable fName will contain "Documents"
```

```shell
File.getFileName /Users/foo/Documents/Text.txt fName # variable fName will contain "Text.txt"
```



#### File.getName()

Get name of a file or directory excluding extension

| Index | Type           | Purpose                          | Required |
| ----- | -------------- | -------------------------------- | -------- |
| 1     | default string | Path to target file or directory | Yes      |
| 2     | default string | Variable name to store result    | No       |

**Example**

```shell
File.getName /Users/foo/Documents
```

```shell
File.getName /Users/foo/Documents fName # variable fName will contain "Documents"
```

```shell
File.getName /Users/foo/Documents/Text.txt fName # variable fName will contain "Text"
```



#### File.getExtension()

Get extension of a file

| Index | Type           | Purpose                          | Required |
| ----- | -------------- | -------------------------------- | -------- |
| 1     | default string | Path to target file or directory | Yes      |
| 2     | default string | Variable name to store result    | No       |

**Example**

```shell
File.getName /Users/foo/Documents/Text.txt
```

```shell
File.getName /Users/foo/Documents/Text.txt fName # variable fName will contain "txt"
```



#### File.getDirectoryOf()

Get the path of parent directory of given path

| Index | Type           | Purpose                          | Required |
| ----- | -------------- | -------------------------------- | -------- |
| 1     | default string | Path to target file or directory | Yes      |
| 2     | default string | Variable name to store result    | No       |

**Example**

```shell
File.getDirectoryOf /Users/foo/Documents/Text.txt
```

```shell
File.getDirectoryOf /Users/foo/Documents/Text.txt fName # variable fName will contain "/Users/foo/Documents"
```





## File/new

**Dependencies**

Foundation: exception, string, out

File: check

#### File.newFile()

Create a text file. Throws error if file already exists.

| Index | Type           | Purpose             | Required |
| ----- | -------------- | ------------------- | -------- |
| 1     | default string | Path to target file | Yes      |
| 2     | default string | Content of the file | Yes      |

**Example**

```shell
File.newFile /Users/foo/Documents/Doc.txt "Hello, World!"
```



#### File.overwrite()

Create a text file. Overwrite if file already exists.

| Index | Type           | Purpose             | Required |
| ----- | -------------- | ------------------- | -------- |
| 1     | default string | Path to target file | Yes      |
| 2     | default string | Content of the file | Yes      |

**Example**

```shell
File.overwrite /Users/foo/Documents/Doc.txt "Hello, World!"
```



#### File.createDirectory()

Create a directory to given path.

| Index | Type           | Purpose               | Required |
| ----- | -------------- | --------------------- | -------- |
| 1     | default string | Path to new directory | Yes      |
| 2     | default string | Flags for `mkdir`     | No       |

**Example**

```shell
File.createDirectory /Users/foo/Documents/MyDocuments
```



#### File.append()

Append text to a text file.

| Index | Type           | Purpose             | Required |
| ----- | -------------- | ------------------- | -------- |
| 1     | default string | Path to target file | Yes      |
| 2     | default string | Content of the file | Yes      |

**Example**

```shell
File.append /Users/foo/Documents/Doc.txt "Hello, World!"
```





## File/read

**Dependencies**

Foundation: exception, string

File: check

#### File.readString()

Read a text file.

| Index | Type           | Purpose                          | Required |
| ----- | -------------- | -------------------------------- | -------- |
| 1     | default string | Path to target file              | Yes      |
| 2     | default string | Name of variable to store result | No       |

**Example**

```shell
File.readString /Users/foo/Documents/Doc.txt
```

```shell
File.readString /Users/foo/Documents/Doc.txt fileContent
```





## File/remove

**Dependencies**

Foundation: exception, string, out

File: check



#### File.removeFile()

Removes a file, but not a directory.

| Index | Type           | Purpose             | Required |
| ----- | -------------- | ------------------- | -------- |
| 1     | default string | Path to target file | Yes      |

**Example**

```shell
File.removeFile /Users/foo/Documents/Doc.txt
```



#### File.removeDirectory()

Removes a directory, but not a file.

| Index | Type           | Purpose                  | Required |
| ----- | -------------- | ------------------------ | -------- |
| 1     | default string | Path to target directory | Yes      |

**Example**

```shell
File.removeDirectory /Users/foo/Documents/MyDocuments
```



#### File.remove()

Removes a file or directory if exists.

| Index | Type           | Purpose                          | Required |
| ----- | -------------- | -------------------------------- | -------- |
| 1     | default string | Path to target file or directory | Yes      |

**Example**

```shell
File.remove /Users/foo/Documents/Hello
```

