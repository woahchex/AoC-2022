local Advent = {
  DAYS_COMPLETE = 3,
  
  Days = {},
  Input = {},
  Output = { -- Verified correct answers
    {74198, 209914},
    {9759, 12429},
    {7581, 2525}
  }
} _G.Advent = Advent

function Advent.testAll()
  for i = 1, Advent.DAYS_COMPLETE do
    local part1, part2 = Advent.Days[i](Advent.Input[i])
    assert(part1 == Advent.Output[i][1], "Day "..i.." Part One failed: "..part1.." ~= "..Advent.Output[i][1].." (Correct)")
    assert(part2 == Advent.Output[i][2], "Day "..i.." Part Two failed: "..part2.." ~= "..Advent.Output[i][2].." (Correct)")
  end
  print("All tests passed :)!")
end

for i = 1, Advent.DAYS_COMPLETE do
  Advent.Days[i] = require("AdventOfCode2022/Days/Day"..i)
  Advent.Input[i] = io.open("AdventOfCode2022/Input/Day"..i .. ".txt", "r"):read("*all")
end

Advent.testAll()