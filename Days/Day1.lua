local Day1 Day1 = setmetatable({
  split = function(s, d, cast)
    d = d or '\n'
    local out = {}
    local il = 1
    local ir = 1
    
    while ir <= #s + 1 do
      ir = ir + 1
      if s:sub(ir, ir+#d-1) == d or ir > #s then
        out[#out+1] = (cast and tonumber(s:sub(il, ir-1))) or s:sub(il, ir-1)
        il = ir + #d
      end
    end
    return out
  end,
  
  rankElves = function(input)
    local splitArray = Day1.split(input, '\n')
    local count, rankedElves = 0, {0}
    for i, v in ipairs(splitArray) do
      if #v > 0 then
        count = count + tonumber(v)
      else
        for j, k in ipairs(rankedElves) do
          if count > k then
            table.insert(rankedElves, j, count)
            break
          end
        end
        count = 0
      end
    end
    
    return rankedElves
  end,
  
  solve1 = function(input)
    local ranked = Day1.rankElves(input)
    return ranked[1]
  end,
  
  solve2 = function(input)
    local ranked = Day1.rankElves(input)
    return ranked[1] + ranked[2] + ranked[3]
  end
},{__call = function(_, input)
  return Day1.solve1(input), Day1.solve2(input)
end})

return Day1