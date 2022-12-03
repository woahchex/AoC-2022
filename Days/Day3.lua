local Day3 Day3 = setmetatable({
  findCommonChar = function(strings)
    local base = strings[1]
    local matches = {}
    for i = 2, #strings do
      for char in base:gmatch(".") do
        if strings[i]:find(char) and matches[char] ~= false then
          matches[char] = true
        else
          matches[char] = false
        end
      end
    end
    
    for char, matched in pairs(matches) do
      if matched then return char end
    end
  end,
  
  solve1 = function(input)
    local sum = 0
    local rucksacks = Advent.Days[1].split(input)
    for _, line in ipairs(rucksacks) do
      local c1, c2 = line:sub(1,#line/2), line:sub(#line/2+1, #line)
      local match = Day3.findCommonChar{c1, c2}
      if match then
        local byte = match:byte()
        sum = sum + (byte < 91 and byte - 38 or byte - 96)
      end
    end
    return sum
  end,
    
  solve2 = function(input)
    local sum, buffer = 0, {}
    local rucksacks = Advent.Days[1].split(input)
    for _, line in ipairs(rucksacks) do
      buffer[#buffer+1] = line
      if #buffer == 3 then
        local byte = Day3.findCommonChar(buffer):byte()
        sum = sum + (byte < 91 and byte - 38 or byte - 96)
        buffer = {}
      end
    end
    return sum
  end
}, {__call = function( _, input )
  return Day3.solve1(input), Day3.solve2(input)
end})

return Day3