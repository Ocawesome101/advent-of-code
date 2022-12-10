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
  local score = 0

  while heights[y] and heights[y][x] do
    x = x + dx
    y = y + dy

    if heights[y] and heights[y][x] and heights[y][x] >= h then
      return score + 1
    elseif heights[y] and heights[y][x] then
      score = score + 1
    end
  end

  return score
end

local c = 0

for y=1, #heights do
  for x=1, #heights[y] do
    local s = checkFrom(x, y, 1, 0)
            * checkFrom(x, y, -1, 0)
            * checkFrom(x, y, 0, 1)
            * checkFrom(x, y, 0, -1)
    c = math.max(c, s)
  end
end

print(c)
