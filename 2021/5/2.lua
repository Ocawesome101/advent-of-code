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
  if ax == bx then
    if ay > by then
      ay, by = by, ay
    end
    for i=ay, by, 1 do
      if grid[ax][i] == 1 then overlaps = overlaps + 1 end
      grid[ax][i] = grid[ax][i] + 1
    end
  elseif ay == by then
    if ax > bx then
      ax, bx = bx, ax
    end
    for i=ax, bx, 1 do
      if grid[i][ay] == 1 then overlaps = overlaps + 1 end
      grid[i][ay] = grid[i][ay] + 1
    end
  else
    local diff = bx - ax
    local diff2 = by - ay
    assert(math.abs(diff) == math.abs(diff2))
    local stepX = (math.abs(diff) == diff) and 1 or -1
    local stepY = (math.abs(diff2) == diff2) and 1 or -1
    for i=1, math.abs(diff) + 1, 1 do
      local ix, iy = ax + ((i - 1) * stepX), ay + ((i - 1) * stepY)
      if grid[ix][iy] == 1 then overlaps = overlaps + 1 end
      grid[ix][iy] = grid[ix][iy] + 1
    end
  end
end

print(overlaps)
