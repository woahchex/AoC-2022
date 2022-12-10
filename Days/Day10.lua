local Day10 Day10 = setmetatable({
  -- Day1 split kept causing issues, so a gmatch solution:
  split = function(input, d)
    d = d or "\n"
    local out={}
    for str in string.gmatch(input, "([^"..d.."]+)") do
      out[#out+1] = tonumber(str) or str
    end
    return out
  end,
  
  newCycle = function()
    Day10.cycle = Day10.cycle + 1
    Day10.sum = Day10.sum + ((Day10.cycle-20) % 40 == 0 and Day10.cycle * Day10.x or 0)
    local line = math.floor(((Day10.cycle-1)/40)+1)
    Day10.screen[line] = Day10.screen[line] .. (math.abs(Day10.x - Day10.cycle%40 +1) <= 1 and "#" or ".")
  end,
  
  solve = function(input)
    Day10.screen, Day10.x, Day10.sum, Day10.cycle = {"","","","","",""}, 1, 0, 0
    
    for _, line in ipairs(Day10.split(input)) do
      local cmd = Day10.split(line, " ")
      Day10.newCycle()
      if cmd[1] == "addx" then
        Day10.newCycle()
        Day10.x = Day10.x + cmd[2]
      end
    end
    
    print("---------------- Day 10 ----------------")
    for _, line in ipairs(Day10.screen) do
      print(line)
    end
    print("----------------------------------------")

    return Day10.sum, true
  end
}, {__call = function(_,input)
  return Day10.solve(input)
end})

return Day10