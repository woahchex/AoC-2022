local Day9 Day9 = setmetatable({
  sign = function(n) return n < 0 and -1 or 1 end,
    
  solve = function(input, knots)
    local lines = Advent.Days[1].split(input)
    
    
    local segments, tailVisited = {}, {["0_0"]={0,0}}
    for i = 1, knots do
      segments[i] = {0,0}
    end
    
    
    
    --local headPosition, tailPosition, tailVisited = {0, 0}, {0, 0}, {["0_0"]={0,0}}
    local directionMap = {L = -1, U = -1, R = 1, D = 1}
    
    for ln, line in ipairs(lines) do
      if line=="" then break end
      local cmd = Advent.Days[1].split(line, " ", true)
      local workingIndex, ix2 = (cmd[1]=="R" or cmd[1]=="L")and 1 or 2, (cmd[1]=="R" or cmd[1]=="L")and 2 or 1 
      
      --print(ln)
      
      --[[for _ = 1, cmd[2] do
        for cKnot = 1, #segments do
          if cKnot == 1 then
            segments[cKnot][ix1] = segments[cKnot][ix1] + directionMap[cmd[1] ]
          else
            -- pick direction
            local dx, dy = math.abs(segments[cKnot-1][1] - segments[cKnot][1]), math.abs(segments[cKnot-1][2] - segments[cKnot][2])
            ix1 = dx < dy and 2 or dx > dy and 1 or ix1
            ix2 = ix1 == 1 and 2 or 1
            
            if math.abs(segments[cKnot][ix1] - segments[cKnot-1][ix1]) > 1 then
              if segments[cKnot][1] ~= segments[cKnot-1][1] and segments[cKnot][2] ~= segments[cKnot-1][2] then
                segments[cKnot][ix2] = segments[cKnot][ix2] + Day9.sign(segments[cKnot-1][ix2]-segments[cKnot][ix2])
              end
              
              segments[cKnot][ix1] = segments[cKnot][ix1] + Day9.sign(segments[cKnot-1][ix1]-segments[cKnot][ix1])
              
              if cKnot==#segments then
                tailVisited[segments[cKnot][1].."_"..segments[cKnot][2] ] = {segments[cKnot][1], segments[cKnot][2]}
              end
            end
          end
        end
      end]]
      
      for i = 1, cmd[2] do
        
        for c = 1, #segments-1 do
          if c == 1 then
            segments[c][workingIndex] = segments[c][workingIndex] + directionMap[cmd[1] ]
          else
            local dx, dy = math.abs(segments[c][1] - segments[c+1][1]), math.abs(segments[c][2] - segments[c+1][2])
            workingIndex = dx < dy and 2 or dx > dy and 1 or workingIndex
            ix2 = workingIndex == 1 and 2 or 1
          end
          local co = 0
          while math.abs(segments[c+1][workingIndex] - segments[c][workingIndex]) > 1 do
            co = co + 1
            if segments[c+1][1] ~= segments[c][1] and segments[c+1][2] ~= segments[c][2] then
              segments[c+1][ix2] = segments[c+1][ix2] + Day9.sign(segments[c][ix2]-segments[c+1][ix2])
            end
            local direction = Day9.sign(segments[c][workingIndex]-segments[c+1][workingIndex])
            segments[c+1][workingIndex] = segments[c+1][workingIndex] + direction
            
            
            if c==#segments-1 then
              tailVisited[segments[c+1][1].."_"..segments[c+1][2] ] = {segments[c+1][1], segments[c+1][2]}
            end
          end
        end
      end
    end
    
    local minX, maxX, minY, maxY = math.huge, -math.huge, math.huge, -math.huge
    
    local c = 0
    for _, p in pairs(tailVisited) do
      c = c + 1
      minX = minX < p[1] and minX or p[1]
      maxX = maxX > p[1] and maxX or p[1]
      minY = minY < p[2] and minY or p[2]
      maxY = maxY > p[2] and maxY or p[2]
    end
    
      for y = minY, maxY do
        local o = ""
        for x = minX, maxX do
          o = o .. (tailVisited[x.."_"..y] and "#" or ".")
        end
        --print(o)
      end
    
    return c
  end
},{__call = function(_,input)
  return Day9.solve(input, 2), false--, Day9.solve(input, 10)
end})

return Day9