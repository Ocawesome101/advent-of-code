local scanners = {}
local s = 0

for line in io.lines("19/i") do
  local id = line:match("%-%-%- scanner (%d+) %-%-%-")
  if id then
    s = tonumber(id)
    scanners[s] = {}
  elseif #line > 0 then
    local x, y, z = line:match("([^,]+),([^,]+),([^,]+)")
    x, y, z = tonumber(x), tonumber(y), tonumber(z)
    assert(x and y and z, line)
    table.insert(scanners[s], {x, y, z})
  end
end

local maps = {}

for i=0, #scanners, 1 do
  local sc = scanners[i]
  local map = {}
  maps[i] = map
  for _, pos in ipairs(sc) do
    local x, y, z = pos[1], pos[2], pos[3]
    map[x] = map[x] or {}
    map[x][y] = map[x][y] or {}
    map[x][y][z] = true
  end
end



local function rotate(map)
  local new = {}
  for xv, x in pairs(map) do
    for yv, y in pairs(x) do
      for zv, z in pairs(y) do
        new[]
      end
    end
  end
  return new
end
