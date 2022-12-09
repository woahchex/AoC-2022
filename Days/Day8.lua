local Day8 Day8 = setmetatable({
  checkAxis = function(matrix, x, y, isY)
    local vals = {true, true, isY and y-1 or x-1, isY and #matrix-y or #matrix[y]-x}
    for c = 1, (isY and #matrix or #matrix[y]) do
      if c ~= (isY and y or x) and matrix[isY and c or y][isY and x or c] >= matrix[y][x] then
        vals[isY and (c < y and 1 or 2) or (c < x and 1 or 2)] = false
        local distance, pos = math.abs((isY and y or x) - c), isY and (c < y and 3 or 4) or (c < x and 3 or 4)
        vals[pos] = distance < vals[pos] and distance or vals[pos]
      end
    end
    return vals[1] or vals[2], vals[3], vals[4]
  end,

  checkVisible = function(matrix, x, y)
    local xCollide, leftDist, rightDist = Day8.checkAxis(matrix, x, y, false)
    local yCollide, upDist, downDist = Day8.checkAxis(matrix, x, y, true)
    return xCollide or yCollide, leftDist * rightDist * upDist * downDist
  end,
    
  solve = function(input)
    local lines = Advent.Days[1].split(input)
    local treeMatrix = {}
    for i, line in ipairs(lines) do
      if line == "" then break end
      treeMatrix[#treeMatrix+1] = Advent.Days[1].split(line, "", true)
      treeMatrix[#treeMatrix][#treeMatrix[#treeMatrix]] = nil
    end
    
    local visibleTrees = #treeMatrix[1] + #treeMatrix[#treeMatrix] + (#treeMatrix-2)*2
    local maxScore = 0
    
    for y = 2, #treeMatrix-1 do
      for x = 2, #treeMatrix[y]-1 do
        local visible, score = Day8.checkVisible(treeMatrix, x, y)
        visibleTrees = visibleTrees + (visible and 1 or 0)
        maxScore = score > maxScore and score or maxScore
      end
    end
    
    return visibleTrees, maxScore
  end
}, {__call = function(_, input)
  return Day8.solve(input)
end})

return Day8