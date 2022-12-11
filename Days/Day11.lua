local Day11 Day11 = setmetatable({
  ops = {
    ["+"] = function(a, b) return a+b end, ["-"] = function(a, b) return a-b end,
    ["*"] = function(a, b) return a*b end, ["/"] = function(a, b) return a/b end,
    ["Monkey"] = function(l, i, ln, s)  Day11.cMonkey = tonumber(s[2]:sub(1, #s[2]-1)) + 1  end,
    ["Starting"] = function(l, i, ln, s)  l[i] = Advent.Days[10].split(Advent.Days[10].split(ln, ":")[2], ", ") end,
    ["Operation:"] = function(l, i, ln, s)  l[i].operation = Advent.Days[10].split(Advent.Days[10].split(ln, ":")[2], " ")  end,
    ["Test:"] = function(l, i, ln, s)  l[i].testDivide = s[#s]; Day11.product = Day11.product * l[i].testDivide  end,
    ["If"] = function(l, i, ln, s)  l[i].operation[s[2]:sub(1,#s[2]-1)] = s[#s]  end,
    [""] = function() end
  },
  solve = function(input, rounds, worryDivisor)
    local monkys = {}
    Day11.product, Day11.cMonkey = 1, 0
    for _, line in ipairs(Advent.Days[10].split(input)) do
      local split = Advent.Days[10].split(line, "%s")
      Day11.ops[split[1]](monkys, Day11.cMonkey, line, split)
    end
    
    for round = 1, rounds do
      for monkeyIndex, monkey in ipairs(monkys) do
        for item, worry in ipairs(monkey) do
          monkey.moves = (monkey.moves or 0) + 1
          monkey[item] = math.floor(Day11.ops[monkey.operation[4]](
            monkey.operation[3]=="old" and worry or monkey.operation[3], 
            monkey.operation[5]=="old" and worry or monkey.operation[5]
          ) / worryDivisor) % Day11.product
          
          local truth = tostring(math.floor(monkey[item]/monkey.testDivide) == monkey[item]/monkey.testDivide)
          table.insert(monkys[monkey.operation[truth]+1], monkey[item])
        end
        for i = 1, #monkey do
          monkey[i]=nil
        end
      end
    end
    
    local rank = {}
    for i, monkey in ipairs(monkys) do
      rank[#rank+1] = monkey.moves
    end
    table.sort(rank)
    return rank[#rank] * rank[#rank-1]
  end
}, {__call = function(_,input)
  return Day11.solve(input, 20, 3), Day11.solve(input, 10000, 1)
end})

return Day11