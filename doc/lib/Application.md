# Documentation: Application

Library Type: Built-in library bundle

**Description**

Manages the context of the script if the script is intended to run as an application. 'Context' in this context is similar as application name.



## Application/context

**Dependencies**

Foundation: exception, string

#### Application.setApplicationName()

This method is intended to set the application context.

| Index | Type           | Purpose          | Required |
| ----- | -------------- | ---------------- | -------- |
| 1     | default string | Application Name | Yes      |

**Example**

```shell
Application.setApplicationName "myapp"
```






## Application/defaults
**Dependencies**

Foundation: exception

File: *

#### Application.setData()

This method is intended to save data of application. The data could be configurations, user data, etc. The data is not encrypted.

| Index | Type           | Purpose    | Required |
| ----- | -------------- | ---------- | -------- |
| 1     | default string | Data Key   | Yes      |
| 2     | any            | Data Value | Yes      |

**Prerequisite**: 

- Application context must be set before method is called using `Application.setApplicationName()`.

**Example**

```shell
Application.setData "username" "jack"
```





#### Application.getData()

This method is intended to save data of application. The data could be configurations, user data, etc. The data is not encrypted.

| Index | Type           | Purpose        | Required |
| ----- | -------------- | -------------- | -------- |
| 1     | default string | Data Key       | Yes      |
| 2     | default string | Memory to save | No       |

**Prerequisite**: 

- Application context must be set before method is called using `Application.setApplicationName()`.
- Application default data must be set before method is called using `Application.setData()`.

**Example**

```shell
Application.getData "username" # jack
```

```shell
Application.getData "username" name # variable `name` contains "jack"
```

