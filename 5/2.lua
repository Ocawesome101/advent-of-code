local grid = {}

setmetatable(grid, {__index = function(t, k1)
  t[k1] = setmetatable({}, {__index = function(t, k2)
    t[k2] = 0
    return t[k2]
  end})
  return t[k1]
end})

local overlaps = 0
for line in io.lines("5/i") do
  local ax, ay, bx, by = line:match("(%d+),(%d+) %-> (%d+),(%d+)")
  ax, ay, bx, by = tonumber(ax), tonumber(ay), tonumber(bx), tonumber(by)
  if ax > bx then
    ax, bx = bx, ax
  end
  if ax == bx then
    if ay > by then
      ay, by = by, ay
    end
    for i=ay, by, 1 do
      if grid[ax][i] == 1 then overlaps = overlaps + 1 end
      grid[ax][i] = grid[ax][i] + 1
    end
  elseif ay == by then
    for i=ax, bx, 1 do
      if grid[i][ay] == 1 then overlaps = overlaps + 1 end
      grid[i][ay] = grid[i][ay] + 1
    end
  else
    local diff = bx - ax
    local diff2 = by - ay
    assert(math.abs(diff) == math.abs(diff2))
    local step = (diff2 > 0 and 1 or -1)
    for i=1, diff, 1 do
      local ix, iy = ax + i - 1, ay + (i - 1) * step
      if grid[ix][iy] == 1 then overlaps = overlaps + 1 end
      grid[ix][iy] = grid[ix][iy] + 1
    end
  end
end

print(overlaps)
