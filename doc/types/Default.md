### Types

ZLang is not strong typed language, therefore the parameters of function does not require any casting. However, some function may require certain data formatted as its type. Objects are NOT considered as types, therefore only primitive data types will be considered in this document as well as the other documentations related to function parameters.

1. any
   - Does not have specified type.
2. default string
   - A single or series of multiple characters including special characters. Some special characters such as exclamation marks may not be handled.
3. default integer
   - Numbers without decimal point or mathematical expression.
4. default float
   - Numbers with decimal point and digits but does not include mathematical expression such as fractions.
5. nullable boolean
   - The boolean value as a string. It is usually used for returning value of a function for `if` conditional statement. The true value is notated as "true", and the false value is notated as empty. (which is equivalent to -z option in shell if statement.)
6. nil (optional placeholder)
   - It is used to mark a parameter with empty value. Use this if it is only an optional value. The notation is "_". This notation is unsupported in LWZL.

