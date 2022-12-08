local heights = {}

local Y = 0
for line in io.lines() do
  Y = Y + 1
  local L = {}
  heights[Y] = L
  for c in line:gmatch(".") do
    L[#L+1] = tonumber(c)
  end
end

local function checkFrom(x, y, dx, dy)
  local h = heights[y][x]

  while heights[y] and heights[y][x] do
    x = x + dx
    y = y + dy

    if heights[y] and heights[y][x] and heights[y][x] >= h then
      return false
    end
  end

  return true
end

local c = 0

for y=1, #heights do
  for x=1, #heights[y] do
    local a = 0
    if checkFrom(x, y, 1, 0) then a = 1 end
    if checkFrom(x, y, -1, 0) then a = 1 end
    if checkFrom(x, y, 0, 1) then a = 1 end
    if checkFrom(x, y, 0, -1) then a = 1 end
    c = c + a
  end
end

print(c)
