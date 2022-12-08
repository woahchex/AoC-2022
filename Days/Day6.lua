local Day6 Day6 = setmetatable({
  solve = function(input, packetSize)
    local buffer = ""
    for pos = 1, #input do
      local char = input:sub(pos,pos)
      buffer = buffer:find(char) and buffer:sub(buffer:find(char)+1, #buffer)..char or buffer .. char
      if #buffer == packetSize then
        return pos
      end
    end
  end
}, {__call = function(_,input)
  return Day6.solve(input, 4), Day6.solve(input, 14)
end})

return Day6