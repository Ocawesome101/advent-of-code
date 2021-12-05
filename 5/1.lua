local grid = {}

setmetatable(grid, {__index = function(t, k)
  t[k] = setmetatable({}, {__index = function(t, k)
    t[k] = 0
    return t[k]
  end})
  return t[k]
end})

local overlaps = 0
for line in io.lines("5/i") do
  local ax, ay, bx, by = line:match("(%d+),(%d+) %-> (%d+),(%d+)")
  ax, ay, bx, by = tonumber(ax), tonumber(ay), tonumber(bx), tonumber(by)
  if ax > bx then
    ax, bx = bx, ax
  end
  if ay > by then
    ay, by = by, ay
  end
  if ax == bx then
    for i=ay, by, 1 do
      if grid[ax][i] == 1 then overlaps = overlaps + 1 end
      grid[ax][i] = grid[ax][i] + 1
    end
  elseif ay == by then
    for i=ax, bx, 1 do
      if grid[i][ay] == 1 then overlaps = overlaps + 1 end
      grid[i][ay] = grid[i][ay] + 1
    end
  end
end

print(overlaps)
