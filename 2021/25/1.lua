local w, h = 0, 0
local map = {}

local y = 0
for line in io.lines("25/t") do
  local x = 0
  h = math.max(h, y)
  for c in line:gmatch(".") do
    w = math.max(w, x)
    local pos = x .. "," .. y
    map[pos] = c ~= "." and c or false
    x = x + 1
  end
  y = y + 1
end

local function move(x, y, val, filter, map)
  if val == ">" then
    x = (x + 1) % w
  elseif val == "v" then
    y = (y + 1) % h
  end
  local potential = x .. "," .. y
  return filter ~= val and x..","..y or potential
end

local function mapiter(map, mode)
  local new = {}
  local moved = 0
  for y=0, h, 1 do
    for x=0, w, 1 do
      local pos = x..","..y
      local npos = move(x, y, map[pos], map)
      if pos ~= npos then moved = moved + 1 end
      new[npos] = map[pos]
    end
  end
  return new, moved
end

local i = 0
repeat
  local mov
  map, mov = mapiter(mapiter(map, ">"), "v")
  i = i + 1
until mov == 0
print(i)
