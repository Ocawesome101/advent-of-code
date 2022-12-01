local on, off = 0, 0
local cubes = {}

local minx, miny, minz, maxx, maxy, maxz = 0, 0, 0, 0, 0, 0

for line in io.lines("22/t") do
  local cmd, x1, x2, y1, y2, z1, z2 = line:match(
  "(o[nf]f?) x=([^%.]+)%.%.([^,]+),y=([^%.]+)%.%.([^,]+),z=([^%.]+)%.%.([^,]+)"
  )
  cmd = cmd == "on"
  x1, x2, y1, y2, z1, z2 =
    tonumber(x1), tonumber(x2),
    tonumber(y1), tonumber(y2),
    tonumber(z1), tonumber(z2),
  assert(x1 and x2 and y1 and y2 and z1 and z2)

  local val = (x2 - x1 + 1) * (y2 - y1 + 1) * (z2 - z1 + 1)
  if cmd then
    on = on + val
  else
    off = off + val
  end
--[[
  minx = math.min(x1, minx)
  miny = math.min(y1, miny)
  minz = math.min(z1, minz)
  maxx = math.max(x1, maxx)
  maxy = math.max(y1, maxy)
  maxz = math.max(z1, maxz)

  local vertices = {
    {x1, y1, z1},
    {x1, y1, z2},
    {x1, y2, z1},
    {x1, y2, z2},
    {x2, y1, z1},
    {x2, y1, z2},
    {x2, y2, z1},
    {x2, y2, z2}
  }
  for _, cube in ipairs(cubes) do
    local x1, x2, y1, y2, z1, z2 = table.unpack(cube)
    
    -- check all eight vertices
    for _, v in ipairs(vertices) do
      if v[1] >= x1 and v[1] <= x2 and v[2] >= y1 and v[2] <= y2 and
          v[3] >= z1 and v[3] <= z2 then
        
      end
    end
  end
  
  cubes[#cubes+1] = {x1, x2, y1, y2, z1, z2}]]
end

print(on, off)
