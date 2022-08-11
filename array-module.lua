-- @name          Lua Array Module
-- @namespace     https://github.com/hadestia/Lua-Array-module
-- @version       0.1
-- @description   A set of tools to extend Lua's quite simple arrays with more intuitive, traditional methods.
-- @author        Hadestia
-- @license       MIT
-- @updateUrl     https://raw.github.com/hadestia/lua-array-module/main/array-module.lua
-- @downloadUrl   https://raw.github.com/hadestia/lua-array-module/main/array-module.lua

local Arr = {}
Arr.meta = {__index = Arr}

---@desc A function that will sets a usefull methods for the given table
---@param table: table 
---@returns table[]
function Array(table)
    table = table or {}
    setmetatable(table, Arr.meta)
    return table
end

--!! Methods !!--

---@desc Adds an object to the array. An index can be provided to specify a position for insertion.
---@param element: element to add into may not be nil.
---@param index: number, Index of where the object should be inserted. If no index was provided the object will be appended to the array. (optional)
---@returns int index of the inserted object.
function Arr:add(element, index)
    index = index or (#self + 1)
    if index > (#self + 1) then
        index = #self
    end
    table.insert(self, index, element)
    return index
end

---@desc Adds an object to the array. An index can be provided to specify a position for insertion.
---@param arr: Array whose elements should be added. the element's keys must be 1, 2, 3, ... to prevent any confusion.
---@param index: int Index of where the elements should be inserted. If no index was provided the elements will be appended to the array. (optional)
---@returns int starting index of the inserted object.
function Arr:addAll(arr, index)
    local index = index or (#self + 1)
    
    if index > (#self + 1) then index = #self+1 end
    local startIndex = index
    
    for k, v in pairs(arr) do
        table.insert(self, index, v)
        index = index + 1
    end
    return startIndex
end

---@desc Clears the array by removing all elements. The resulting size of the array will be 0 or empty.
function Arr:clear()
    for k, _ in pairs(self) do
        self[k] = nil
    end
end

---@desc Returns true iff the given object is part of the array, however it ignores an element with is part of keys.
---@param element: The object to search for, may not be a key name or element which is part of a key.
---@returns boolean
function Arr:contains(element)
    for _, v in pairs(self) do
        if v == name then return true end
    end
    return false
end

---@desc Returns a copy of the array.
---@returns Array: the copy of the array.
function Arr:copy()
    local copied = Array{}
    for k,v in pairs(self) do
        copied[k] = v
    end
    return copied
end

---@desc Counts how many elements fulfill a given predicate.
---@param predicte: A function that returns true or false for an element of the array.
---@returns int: The total count of given element
function Arr:count(predicate)
    local total = 0
    self:forEach(
        function (k, v) 
            if predicate(v) then total = total + 1 end
        end
    )
    return total
end

---@desc Returns true iff at least one element matches the given predicate.
---@param predicate (function) A callback function that returns true or false for an element of the array.
---@returns boolean
function Arr:exists(predicate)
    local state = false
    for k, v in pairs(self) do
        state = predicate(k, v) or false
        if state then return true end
    end
    return state
end

---@desc Creates a copy that only contains filtered elements.
---@param filterFunction: function that returns a boolean statement for the key or value
---@returs Array array of filtered elements
function Arr:filter(filterFunction)
    local filtered = Array{}
    for k, v in pairs(self) do
        if filterFunction(k, v) then
            filtered[k] = v
        end
    end
    return filtered
end

---@desc Returns the index of an object in the array. If the array doesn't contain it the function returns -1.
---@param element: the object to search for.
---@returns index(int) or key(number/string) of element or -1 if it does not exist
function Arr:find(element)
    for k, v in pairs(self) do
        if v == element then return k end
    end
    return -1
end

---@desc Iterates over all elements of the array and applieds a function on them. This is especially useful to avoid explicit use of a for loop. However, this functional style comes at an allocation and performance cost because of the function. Use it when it suits your needs.
---@param callbackFunction function
function Arr:forEach(callbackFunction)
    for k, v in pairs(self) do
        callbackFunction(k, v)
    end
end

---@desc Returns true iff the array is empty. This is equivalent to checking the size size of the array being 0 manually.
---@returns boolean True iff the array is empty.
function Arr:isEmpty()
    local count = 0
    for k, v in pairs(self) do
        count = count + 1
    end
    return count == 0
end

---@desc Maps all elements to a new array using a given function.
---@param mapFunction function()
---@returns Array the mapped array
function Arr:map(mapFunction)
    local mapped = Array{}
    self:forEach(
        function (k, v)
            local key, value = mapFunction(k, v)
            mapped[key or #mapped+1] = value
        end
    )

    return mapped
end

---@desc Returns a random element of the array. it ignores element with keys and check for index range 0 to nth number returned by #table.
---@returns data, a randomly selected from array depending on its data type.
function Arr:pick()
    if not(#self ==0) then
        local rnd = math.random(1, #self)
        return self[rnd]
    end
    return nil
end

---@desc Prints all the keys and values of a single dimensional array.
function Arr:print()
    for k, v in pairs(self) do
        print(k, v)
    end
end

---@desc Removes the first appearance of an object from the array.
---@param element element Object that should be found and removed.
---@returns boolean True if the object was successfully removed
function Arr:remove(element)
    for k, v in pairs(self) do
        if v == element then self[k] = nil; return true end
    end
    return false
end

---@desc Removes the object at a specific index or key.
---@param i index|key of the object thay should be removed.
---@returns object the backup object/value on that key/index that is removed, return nil if the given index are not found.
function Arr:removeAt(i)
    if self[i] then
        local backup = self[i]
        self[i] = nil
        return backup
    end
    return nil
end

---@desc Shuffles the elements of the array into a random order. The function uses math.random internally so that the result is dependent on the current random seed value. To get different results for different runs you might call math.randomseed(os.time()) at the start of your program.
function Arr:shuffle()
    local copy = self:copy()
    local map = {}
    self:clear()
    for k, v in pairs(copy) do
        if not map[k] then
            local pos = math.random(1, #self + 1)
            table.insert(self, pos, v)
            map[k] = true
        end
    end
end

---@desc Uses natural order of the elements in the array to sort them. You can optionally provide your own function for comparing two elements.
---@param compFunc: The comparison function must return a boolean value specifying whether the first argument should be before the second argument in the array. The default behaviour is ascending order. (optional)
function Arr:sort(compFunc)
    table.sort(self, compFunc or nil)
end

---@desc Creates a sub-array for the specified range. this was only applicable for array whose keys was 1, 2, 3 and so on.
---@param startIndex: The index from where to copy.
---@param length: (int) The length of the new array. By default the array will be copied to the end. (optional)
---@returns Array: The created sub-array.
function Arr:sub(startIndex, length)
    local copied = {}
    length = length or ((#self - startIndex)+1) + startIndex
    if #self < (length + startIndex) then length = ((#self - startIndex)+1) + startIndex end
    for i = startIndex, length do
        copied[#copied+1] = self[i]
    end
    return Array(copied)
end

--!! Note that this will return a function instead of typical module which return table
return Array
