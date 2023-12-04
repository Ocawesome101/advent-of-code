local function split(s,c)
  local W = {}
  for w in s:gmatch("[^"..c.."]+") do
    W[#W+1] = tonumber(w) or w
  end
  return W
end

local sum = 0
for line in io.lines() do
  local id, _winning, have = line:match("Card +(%d+): ([%d ]+) | ([%d ]+)")
  _winning, have = split(_winning, " "), split(have, " ")
  local winning = {}
  for i, num in pairs(_winning) do
    winning[num] = true
  end
  local value = 0
  for i=1, #have do
    if winning[have[i]] then
      if value == 0 then value = value + 1 else value = value * 2 end
    end
  end
  sum = sum + value
end

print(sum)
