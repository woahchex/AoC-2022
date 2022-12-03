local Day2 Day2 = setmetatable({
  calculateScore = function(p1, p2, useGuide2)
    p1 = p1 == "A" and 0 or p1 == "B" and 1 or 2
    p2 = (useGuide2 and 
      (p2 == "X" and p1-1 or p2 == "Z" and p1+1 or p1) or 
      (p2 == "X" and 0 or p2 == "Y" and 1 or 2)) % 3
    return (p2 - p1 + 1) % 3 * 3 + p2 + 1
  end,
  
  genericSolve = function(input, solutionType)
    local lines = Advent.Days[1].split(input)
    local score = 0
    for i, line in ipairs(lines) do
      if #line == 3 then
        local round = Advent.Days[1].split(line," ")
        score = score + Day2.calculateScore(round[1], round[2], solutionType)
      end
    end
    
    return score
  end,
  
  solve1 = function(input)
    return Day2.genericSolve(input)
  end,
  
  solve2 = function(input)
    return Day2.genericSolve(input, true)
  end
}, {__call = function( _, input )
  return Day2.solve1(input), Day2.solve2(input)
end})

return Day2