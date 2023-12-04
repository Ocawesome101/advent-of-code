local function split(s,c)
  local W = {}
  for w in s:gmatch("[^"..c.."]+") do
    W[#W+1] = tonumber(w) or w
  end
  return W
end

local copies = {}
for line in io.lines() do
  local id, _winning, have = line:match("Card +(%d+): ([%d ]+) | ([%d ]+)")
  id = tonumber(id)
  copies[id] = copies[id] or 1
  _winning, have = split(_winning, " "), split(have, " ")
  local winning = {}
  for i, num in pairs(_winning) do
    winning[num] = true
  end
  local value = 0
  for i=1, #have do
    if winning[have[i]] then
      value = value + 1
    end
  end
  for i=1, value do
    copies[id+i] = (copies[id+i] or 1) + copies[id]
  end
end

local sum = 0
for i=1, #copies do
  sum = sum + copies[i]
end

print(sum)
