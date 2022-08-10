#Lua-Array-module

A set of tools to extend Lua's quite simple arrays with more intuitive, traditional methods.

Before That, this was already been implemented on TheoTown(city building simulation game) on their library, and it was inspired from it. although this was a replica using my own logic i already ask for permission on the dev. of the said game and granted.

Alright this was made as a metatable for array objects and can therefore be applied to arrays without a copy operation.

Technically Lua has no arrays but tables only. The extended functionality added by this module allows you to change size of the array. You can therefore also use it as a list interface.

Note that nil is not an allowed value in an array since it confuses the '#'(length-)operator.

Creating a new "array" with extended functionality is quite easy. After the creation you can call the methods mentioned below on it.


###How to use the module
``` lua
local Array = require ('array-module') -- get access to module from the path.

local a = Array() -- use the module
```

###How it works
**Empty array**
``` lua
local a = Array() -- creates an empty array
local b = Array{} -- same as the first one
```
**Array with elements**
``` lua
local a = Array( { 1, 2, 3 } ) -- creates an array with elements
local b = Array{ 'a', 'b', 'c' } -- all the same
```

##:green_book: Class Documentation

###Array:add(element[, index])
Adds an object to the array. An index can be provided to specify a position for insertion.
- parameters
  - element: Object to add. May not be nil.
  - index: number Index of where the object should be inserted. If no index was provided the object will be appended to the array. (optional)
- Returns
  - int: Index of the inserted object.
- Usage
``` lua
local a = Array()
a:add(1)
a:add(2)
a:add(3, 1)
print(tostring(a))  --Prints {3, 1, 2}
```

###

- Parameters
  - 
- Returns
  - 
- Usage
``` lua
  
```

###

- Parameters
  - 
- Returns
  - 
- Usage
``` lua
  
```

###

- Parameters
  - 
- Returns
  - 
- Usage
``` lua
  
```

###

- Parameters
  - 
- Returns
  - 
- Usage
``` lua
  
```

###

- Parameters
  - 
- Returns
  - 
- Usage
``` lua
  
```

###

- Parameters
  - 
- Returns
  - 
- Usage
``` lua
  
```

###

- Parameters
  - 
- Returns
  - 
- Usage
``` lua
  
```

###

- Parameters
  - 
- Returns
  - 
- Usage
``` lua
  
```




