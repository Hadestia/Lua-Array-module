# Lua-Array-module v0.1

A set of tools to extend Lua's quite simple arrays with more intuitive, traditional methods.

Before That, this was already been implemented on TheoTown(city building simulation game) on their library, and it was inspired from it. although this was a replica using my own logic i already ask for permission on the dev. of the said game and granted.

Alright this was made as a metatable for array objects and can therefore be applied to arrays without a copy operation.

Technically Lua has no arrays but tables only. however keys which value 1, 2, 3 and so on was presented as array, but there are some methods that returns the key on a call back function for other usage. The extended functionality added by this module allows you to change size of the array. You can therefore also use it as a list interface.

Note that nil is not an allowed value in an array since it confuses the '#'(length-)operator.

Creating a new "array" with extended functionality is quite easy. After the creation you can call the methods mentioned below on it.

## License
- **MIT LICENSE**

## Credit
- TheoTown(game)

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
  - arr: Array whose elements should be added. the element's keys must be 1, 2, 3, ... to prevent any confusion.
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
local c = a:count(function (v) return v == 3 end)
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
print(a:exists(function (k, v) return v == 2 end)) --Prints true
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

### Arr:find(element)
Returns the index of an object in the array. If the array doesn't contain it the function returns -1.
- Parameters
  - element: the object to search for.
- Returns
  - index(int) or key(number/string) of element or -1 if it does not exist
- Usage
``` lua
local a = Array{'a', 'b', 'c'}
print(a:find('b'))  --Prints 2
```

### Arr:forEach(callbackFunction)
Iterates over all elements of the array and applieds a function on them. This is especially useful to avoid explicit use of a for loop. However, this functional style comes at an allocation and performance cost because of the function. Use it when it suits your needs.
- Parameters
  - callbackFunction: function
- Usage
``` lua
local a = Array{1, 2, 3}
for i = 1, #a do --Typical approach
  print(a[i])
end
a:forEach(function(x) print(x) end) --Functional style
```

### Arr:isEmpty()
Returns true if the array is empty. This is equivalent to checking the size size of the array being 0 manually.
- Returns
  - boolean: True iff the array is empty.
- Usage
``` lua
local a = Array{}
print(a:isEmpty()) --Prints true
```

### Arr:map(mapFunction)
Maps all elements to a new array using a given function.
- Parameters
  - mapFunction: function
- Returns
  - Array: the mapped array
- Usage
``` lua
local a = Array{1, 2, 3}
local b = a:map(function(k, x) return k, 2 * x end)
print(tostring(b))  --Prints {2, 4, 6}
```

### Arr:pick()
Returns a random element of the array. it ignores element with keys and check for index range 0 to nth number returned by #table.
- Returns
  - data, a randomly selected from array depending on its data type.
- Usage
``` lua
local a = Array{1, 3, 5}
print(a:pick()) --Prints 1 or 3, or 5 / unknown since random
```

### Arr:print()
Prints all the keys and values of a single dimensional array.
- Usage
``` lua
local a = Array{1, 3, 5}
a:print() --Prints 1: 1, 2: 3, 3: 5
```

### Arr:remove(element)
Removes the first appearance of an object from the array. use `table[key] = nil` to remove the entire element with has key
- Parameters
  - element: element Object that should be found and removed.
- Returns
  - boolean True if the object was successfully removed
- Usage
``` lua
local a = Array{2, 6}
print(a:remove(6)) --Prints true
```

### Arr:removeAt(i)
Removes the object at a specific index or key.
- Parameters
  - i: index or key of the object thay should be removed.
- Returns
  - object the backup object/value on that key/index that is removed, return nil if the given index are not found.
- Usage
``` lua
local a = Array{6, 8, true}
print(a:removeAt(1)) --Prints 6
print(tostring(a)) -- {8, true}
```

### Arr:shuffle()
Shuffles the elements of the array into a random order. The function uses math.random internally so that the result is dependent on the current random seed value. To get different results for different runs you might call math.randomseed(os.time()) at the start of your program.

### Arr:sort([compFunc])
Uses natural order of the elements in the array to sort them. You can optionally provide your own function for comparing two elements.
- Parameters
  - compFunc: The comparison function must return a boolean value specifying whether the first argument should be before the second argument in the array. The default behaviour is ascending order. (optional)
- Usage
``` lua
local arr = Array{1, 5, 0, 6, 1, 3, 2, 4}
arr:sort()
print(tostring(arr))  --Prints {0, 1, 1, 2, 3, 4, 5, 6}
arr:sort(function(a,b) return a > b end)
print(tostring(arr))  --Prints {6, 5, 4, 3, 2, 1, 1, 0}
```

### Arr:sub(startIndex[, length])
Creates a sub-array for the specified range. this was only applicable for array whose keys was 1, 2, 3 and so on.
- Parameters
  - startIndex: The index from where to copy.
  - length: (int) The length of the new array. By default the array will be copied to the end. (optional)
- Returns
  - Array: The created sub-array.
- Usage
``` lua
local a = Array{1, 2, 3, 4, 5, 6}
print(tostring(a))  --Prints {1, 2, 3, 4, 5, 6}
local b = a:sub(2, 4)
print(tostring(b))  --Prints {2, 3, 4, 5}
```

