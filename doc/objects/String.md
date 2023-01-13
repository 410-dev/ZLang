# Documentation: (Object) String

Library Type: Built-in class

**Description**

A string object for various usage.



**Preset for example**

```shell
new String as s value "Hello, World\!"
```



#### toString()

Convert current string object to default string.

| Index | Type | Purpose | Required |
| ----- | ---- | ------- | -------- |
| -     | -    | -       | -        |

**Example**

N/A



#### replace()

Replace a substring with other string.

| Index | Type           | Purpose      | Required |
| ----- | -------------- | ------------ | -------- |
| 1     | default string | To replace   | Yes      |
| 2     | default string | Replace with | Yes      |

**Prerequisite**: 

- Instance must be initialized.

**Example**

```shell
s . replace "Hello" "Hola" # New string value: "Hola, World!"
```



#### digestTo()

Hashes the string value. If saving variable is not specified, then the object's value is changed.

| Index | Type           | Purpose                         | Required |
| ----- | -------------- | ------------------------------- | -------- |
| 1     | default string | Algorithm                       | Yes      |
| 2     | default string | Name of variable to save result | No       |

**Available algorithms**

SHA-256: 32bit

SHA-384: 48bit

SHA-512: 64bit

**Prerequisite**: 

- Instance must be initialized.

**Example**

```shell
s . digestTo SHA-512
```

```shell
s . digestTo SHA-256
```



#### length()

Get the number of characters (including space and special characters) in the object.

| Index | Type           | Purpose                         | Required |
| ----- | -------------- | ------------------------------- | -------- |
| 1     | default string | Name of variable to save result | No       |

**Prerequisite**: 

- Instance must be initialized.

**Example**

```shell
s . length
```

```shell
s . length strLen
```



#### contains()

Checks if a substring exists in the object.

| Index | Type           | Purpose                         | Required |
| ----- | -------------- | ------------------------------- | -------- |
| 1     | default string | Substring to check              | Yes      |
| 2     | default string | Name of variable to save result | No       |

**Prerequisite**: 

- Instance must be initialized.

**Example**

```shell
s . contains "Hello"
```

```shell
s . contains "Hello" doContains
```



#### endsWith()

Checks if the object ends with the given substring.

| Index | Type           | Purpose                         | Required |
| ----- | -------------- | ------------------------------- | -------- |
| 1     | default string | Suffix to check                 | Yes      |
| 2     | default string | Name of variable to save result | No       |

**Prerequisite**: 

- Instance must be initialized.

**Example**

```shell
s . endsWith "World\!"
```

```shell
s . endsWith "World\!" doEnds
```



#### startsWith()

Checks if the object starts with the given substring.

| Index | Type           | Purpose                         | Required |
| ----- | -------------- | ------------------------------- | -------- |
| 1     | default string | Prefix to check                 | Yes      |
| 2     | default string | Name of variable to save result | No       |

**Prerequisite**: 

- Instance must be initialized.

**Example**

```shell
s . startsWith "Hello"
```

```shell
s . startsWith "Hello" doStarts
```



#### split()

Unsupported for now!



#### substring()

Unsupported for now!



#### random()

Generate a random string and sets the objet with generated random string.

| Index | Type            | Purpose                           | Required                               |
| ----- | --------------- | --------------------------------- | -------------------------------------- |
| 1     | default integer | Length of newly generated string  | No (Default: 1)                        |
| 2     | default string  | Regex (Range of alphabets to use) | No (Default: [a-zA-Z0-9!@#$%^&\*()_+]) |
| 3     | default integer | Number of lines to generate       | No (Default: 1)                        |

**Prerequisite**: 

- Instance must be initialized.

**Example**

```shell
s . random
```

```shell
s . random 32
```

```shell
s . random 32 "[a-zA-Z0-9]" 1
```

```shell
s . random 32 _ 15
```

```shell
s . random 32 "[A-Z0-9]" _
```



