local Day5 Day5 = setmetatable({
  reverse = function(array)
    for i = 1, math.floor(#array/2) do
      local tmp = array[i]
      array[i] = array[#array-i+1]
      array[#array-i+1] = tmp
    end
  end,
  
  parse = function(lines)
    local cLine = 1
    local stacks = {{},{},{},{},{},{},{},{},{}}
    while lines[cLine] and type(Advent.Days[1].split(lines[cLine], " ", true)[1]) ~= "number" do
      for i = 1, 9 do
        local char = lines[cLine]:sub(2+(i-1)*4,2+(i-1)*4)
        if char ~= " " and #char > 0 then
          stacks[i][#stacks[i]+1] = char
        end
      end
      cLine = cLine + 1
    end
    for _, t in ipairs(stacks) do Day5.reverse(t) end
    return stacks, cLine + 2
  end,
  
  solve = function(input, reverse)
    local lines = Advent.Days[1].split(input)
    local stacks, start = Day5.parse(lines)
    
    for i = start, #lines-1 do
      local info = Advent.Days[1].split(lines[i], " ", true)
      for i = info[2], 1, -1 do
        table.insert(stacks[info[6]], table.remove(stacks[info[4]], #stacks[info[4]] - (reverse and i or 1) + 1))
      end
    end
    
    local out = ""
    for _, t in ipairs(stacks) do
      out = out .. t[#t]
    end
    
    return out    
  end
},{__call = function(_,input)
  return Day5.solve(input, false), Day5.solve(input, true)
end})

return Day5