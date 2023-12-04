local function split(s,c)
  local W = {}
  for w in s:gmatch("[^"..c.."]+") do
    W[#W+1] = tonumber(w) or w
  end
  return W
end

local sum = 0
local lines = {}
local orig = {}
for line in io.lines() do
  lines[#lines+1] = line
  orig[#orig+1] = line
end

local index = 0
repeat
  index = index + 1
  local line = lines[index]
  local id, _winning, have = line:match("Card +(%d+): ([%d ]+) | ([%d ]+)")
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
    lines[#lines+1] = orig[id+i]
  end
until index == #lines

print(#lines)
