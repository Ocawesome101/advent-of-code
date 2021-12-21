local scores = {
  0, 0
}

local p1 = 5
local p2 = 8

local rolls = 0
local value = 0

local function roll()
  rolls = rolls + 1
  value = value + 1
  if value > 100 then value = 1 end
  return value
end

while scores[1] < 1000 and scores[2] < 1000 do
  p1 = p1 + roll() + roll() + roll()
  while p1 > 10 do p1 = p1 - 10 end
  scores[1] = scores[1] + p1
  if scores[1] >= 1000 then break end
  p2 = p2 + roll() + roll() + roll()
  while p2 > 10 do p2 = p2 - 10 end
  scores[2] = scores[2] + p2
end

table.sort(scores)
print(scores[1], rolls)
print(scores[1] * rolls)
