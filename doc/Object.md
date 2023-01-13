# Documentation: Defining / Using object

**Description**

Using library `Objective`, ZLang allows OOP-like programming style (Objeted Oriented Programming). This document specifies how to define a class, instantiating the class, and using the instantiated object.



### Usage

Developers are required to import `Objective` library using the following command:

`@import Objective`

Developers may define custom classes or use predefined classes. [Refer to this document](./objects/index.md) for predefined classes.

**Table of contents**

1. Defining a class
2. Instantiating a class to an object
3. Calling method
4. Limitations



### Defining a class

Default format:

```shell
class name() {
	@superclass Object
	
	global global_var1 "$@"
	global global_var2 "$@"
	
	function functionA() {
		...
	}
	
	function functionB() {
		...
	}
	
	execute "$@"
}
```

All classes must inherit Object as superclass using `@superclass Object` since class Object contains all of the required functions as an object. [Refer to this document](./objects/Object.md) for more details. 

Using `global` keyword, developers may define in-class global variable (such as property of object). The variable name comes after `global` keyword, then the parameter is given to `global` command by using `"$@"`.

Any functions may be defined after global variables are defined.

At the end of the class, command `execute "$@"` must be used in order for class to analyze the commands.



**Getting / Setting global variables in function**

Setting global variable: `this set <name> <value>`

Getting global variable: `$(this get <name>)`



**Usage example** 

Using the given format above, we can create a class "Human" with property of name, age, and gender, as well as getter and setter funcitons.

```shell
class Human() {
	@superclass Object
	
	global name "$@"
	global age "$@"
	global gender "$@"
	
	function getName() {
		this get name # Because 'this get' command will echo, it is unnecessary to do echo "$(this get name)."
	}
	
	function getAge() {
		this get age # Skipped variablization with the same reason above
	}
	
	function getGender() {
		this get gender # Same reason as above
	}
	
	function setName() {
		this set name "$1"
	}
	
	function setAge() {
		this set age $2 # Parameter is expected to be a number - no quotation mark
	}
	
	function setGender() {
		this set gender "$3"
	}
	
	execute "$@"
}
```



### Instantiating

A class could be instantiated with the following syntax:

```shell
new <class name> as <instance name> <global variable name> <global variable value>
```

Class could be predefined class in the library or custom class. No importing required if predefined class, but including is required for external script.

A variable could be null value by using `_`. If underscore is the actual value, then escape using `\`, which results `\_`. 

Construction variable don't need to be in the same order.

**Usage example**

Defining a String object with variable name s, with initialized value of "Hello, World!":

```shell
new String as s value "Hello, World\!"
```

Defining a String object with variable name s, with no initialization:

```shell
new String as s
```

Defining a String object with variable name s, with initialization with undefined value:

```shell
new String as s value _
```

Defining a Human object (defined in 'Defining a class' section usage example) with full information, variable name h:

```shell
new Human as h name "Alexander" age 24 gender "Male"
```

Defining a Human object with partial information, variable name h:

```shell
new Human as h name "Alexander" age _ gender _
```

```shell
new Human as h age 24 name "Alexander" gender _
```

```shell
new Human as h name _ gender "Male" age _
```



### Calling method

A method could be called by separating the object and method name by ` . `

Space must present before and after the period.

```shell
<object> . <method> <parameter>
```

If method is not specified, then period should not be present. Then, `toString()` method will automatically be invoked, which is predefiend in `Object` superclass.

Unlike object construction, variable label is unsupported, therefore the variables and values must be placed in order.

**Usage example**

Calling `random` method in Integer `i` within range of 1 to 5:

```shell
new Integer as i value _
i . random 1 5
```

Calling `contains` method in String `s`, checking if `s` has substring of 'hello' and setting the result in variable `b`:

```shell
new String as s value "Hello World"
s . contains "hello" b
# 'b' is now a variable that contains value of "true"
```



### Limitations

This is NOT a proper object oriented language, but more like an emulation using tricks. Object is defined as functions, and global variables in an object is exported and saved as `<obj>_<varname>` which means all values are exposed. Memory usage and processing speed is completely neglected for the entire system. It is only intended for ease of use, not aimed for efficiency, security or stability of code. Scripts or programs that requires securing variables or encapsulation should not use this method. 
