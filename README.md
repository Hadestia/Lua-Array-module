# Lua-Array-module

A set of tools to extend Lua's quite simple arrays with more intuitive, traditional methods.

Before That, this was already been implemented on TheoTown(city building simulation game) on their library, and it was inspired from it. although this was a replica using my own logic i already ask for permission on the dev. of the said game and granted.

Alright this was made as a metatable for array objects and can therefore be applied to arrays without a copy operation.

Technically Lua has no arrays but tables only. The extended functionality added by this module allows you to change size of the array. You can therefore also use it as a list interface.

Note that nil is not an allowed value in an array since it confuses the '#'(length-)operator.

Creating a new "array" with extended functionality is quite easy. After the creation you can call the methods mentioned below on it.


### How to use the module
``` lua
local Array = require ('array-module') -- get access to module from the path.

local a = Array() -- use the module
```

### How it works
**Empty array:**
``` lua
local a = Array() -- creates an empty array
local b = Array{} -- same as the first one
```
**Array with elements:**
``` lua
local a = Array( { 1, 2, 3 } ) -- creates an array with elements
local b = Array{ 'a', 'b', 'c' } -- all the same
```

## Class Documentation

### Arr:add(element[, index])
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

### Arr:addAll(arr, index)
Adds an object to the array. An index can be provided to specify a position for insertion.
- Parameters
  - arr: Array whose elements should be added.
  - index: int Index of where the elements should be inserted. If no index was provided the elements will be appended to the array. (optional)
- Returns
  - int: starting index of the inserted object.
- Usage
``` lua
local a = Array{1, 2, 3}
local b = Array{4, 5, 6}
a:addAll(b, 2)
print(tostring(a))  --Prints {1, 4, 5, 6, 2, 3}
```

### Arr:clear()
Clears the array by removing all elements. The resulting size of the array will be 0 or empty.

### Arr:contains(element)
Returns true iff the given object is part of the array, however it ignores an element with is part of keys.
- Parameters
  - element: The object to search for, may not be a key name or element which is part of a key.
- Returns
  - boolean
- Usage
``` lua
local a = Array{'a', 'b', 'c'}
print(a:contains('b'))  --Prints true
print(a:contains('d'))  --Prints false
```

### Arr:copy()
Returns a copy of the array.
- Returns
  - Array: the copy of the array.
- Usage
``` lua
local a = Array{1, 2, 3}
local b = a:copy()
b[1] = 42
print(tostring(a))  --Prints {1, 2, 3}
print(tostring(b))  --Prints {42, 2, 3}
```

### Arr:count(predicate)
Counts how many elements fulfill a given predicate.
- Parameters
  - predicate: A function that returns true or false for an element of the array.
- Returns
  - Array: the copy of the array.
- Usage
``` lua
local a = Array{1, 2, 3, 3}
local c = a:count(function (v) return v == 3 end end)
print(c)  --Prints 2
```

### Arr:exists(predicate)
Returns true iff at least one element matches the given predicate.
- Parameters
  - predicate (function) A function with a key and value parameters that returns true or false for an element of the array.
- Returns
  - boolean
- Usage
``` lua
local a = Array {1, 2, 3}
print(a:exists(function (k, v) return v == 2 end end)) --Prints true
```

### Arr:filter(filterFunction)
Creates a copy that only contains filtered elements.
- Parameters
  - filterFunction: function that returns a boolean statement for the key or value
- Returns
  - Array array of filtered elements
- Usage
``` lua
local a = Array{1, 2, 3}
local b = a:filter(function(x) return x % 2 == 1 end) --Keep uneven numbers
print(tostring(b))  --Prints {1, 3}
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




