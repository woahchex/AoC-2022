local Day7 Day7 = setmetatable({
  ["$"] = {
    cd = function(cmd)
      Day7.currentDirectory = cmd[3] == ".." and Day7.currentDirectory.parent or
        cmd[3] == "/"  and Day7.baseDirectory or Day7.currentDirectory[cmd[3]]
    end,
    ls = function() end
  },
  
  Directory = {__index = {
    size = function(self)
      local sum = 0
      for k, v in pairs(self) do
        if type(v) ~= "function" and k ~= "parent" then
          sum = sum + (tonumber(v) or v:size()) 
        end
      end
      return sum
    end
  }},
  
  newFile = function(cmd)
    Day7.currentDirectory[cmd[2]] = tonumber(cmd[1])
  end,
  newDirectory = function(cmd)
    Day7.currentDirectory[cmd[2]] = setmetatable({parent = Day7.currentDirectory}, Day7.Directory)
  end,
  dir = setmetatable({}, {__index = function()
    return Day7.newDirectory
  end}),
  
  getSum = function(directory, maxSize)
    local totalSize, cSize, maxSize, seekingThreshold = 0, directory:size(), maxSize or math.huge
    for name, val in pairs(directory) do
      if name ~= "parent" and type(val) == "table" then
        totalSize = totalSize + Day7.getSum(val, maxSize, seekingThreshold)
      end
    end
    return totalSize + (cSize > maxSize and 0 or cSize)
  end,
  findSmallest = function(directory, minSize, smallest)
    local dSize = directory:size()
    smallest = smallest and (dSize < smallest and (dSize > minSize and dSize) or smallest) or math.huge
    for name, val in pairs(directory) do
      if type(val) == "table" and val.parent and name ~= "parent" then
        smallest = Day7.findSmallest(val, minSize, smallest)
      end
    end
    return smallest
  end,
  
  solve = function(input)
    Day7.smallestFile = math.huge
    Day7.baseDirectory = setmetatable({}, Day7.Directory)
    Day7.currentDirectory = Day7.baseDirectory
    for i, line in ipairs(Advent.Days[1].split(input)) do
      local command = Advent.Days[1].split(line, " ")
      if (command[1] == "$" and command[2] == "cd") or command[1] == "dir" or tonumber(command[1]) then
        Day7[command[1]][command[2]](command)        
      end
    end
    return Day7.getSum(Day7.baseDirectory, 100000), Day7.findSmallest(Day7.baseDirectory, -40000000 + Day7.baseDirectory:size())
  end
}, {__index = function(_, cmd)
  return setmetatable({}, {__index = function() return Day7.newFile end})
end, __call = function(_,input)
  return Day7.solve(input)
end})

return Day7