local Day4 Day4 = setmetatable({
  genericSolve = function(input, sol)
    local lines = Advent.Days[1].split(input)
    local cases = 0
    for _, line in ipairs(lines) do
      local pairs = Advent.Days[1].split(line, ",")
      if not pairs[2] then break end
      local p1 = Advent.Days[1].split(pairs[1], "-", true) 
      local p2 = Advent.Days[1].split(pairs[2], "-", true) 
      
      if sol and ((p1[1] <= p2[1] and p1[2] >= p2[1]) or (p1[1] <= p2[2] and p1[2] >= p2[2]) 
      or (p2[1] <= p1[1] and p2[2] >= p1[1]) or (p2[1] <= p1[2] and p2[2] >= p1[2])) or
         (p1[1] <= p2[1] and p1[2] >= p2[2]) or (p2[1] <= p1[1] and p2[2] >= p1[2]) then
        cases = cases + 1
      end
    end
    return cases    
  end,  
  
  solve1 = function(input)
    return Day4.genericSolve(input, false)
  end,
  
  solve2 = function(input)
    return Day4.genericSolve(input, true)
  end
},{__call = function(_,input)
  return Day4.solve1(input), Day4.solve2(input)
end})

return Day4