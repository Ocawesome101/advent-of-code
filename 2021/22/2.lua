local xmt = {
  __index = function(t, k)
    t[k] = false
    return t[k]
  end
}

local ymt = {
  __index = function(t, k)
    t[k] = setmetatable({}, xmt)
    return t[k]
  end
}

local zmt = {
  __index = function(t, k)
    t[k] = setmetatable({}, ymt)
    return t[k]
  end
}

-- cubes[z][y][x] = on|off (true|false)
local cubes = setmetatable({}, zmt)

local mx, my, mz, xx, xy, xz = 0, 0, 0, 0, 0, 0
for line in io.lines("22/i") do
  local onoff, x1, x2, y1, y2, z1, z2 = line:match(
  "(o[nf]f?) x=([^%.]+)%.%.([^,]+),y=([^%.]+)%.%.([^,]+),z=([^%.]+)%.%.([^,]+)"
  )
  onoff = onoff == "on"
  x1, x2, y1, y2, z1, z2 =
    tonumber(x1), tonumber(x2),
    tonumber(y1), tonumber(y2),
    tonumber(z1), tonumber(z2),
  assert(x1 and x2 and y1 and y2 and z1 and z2)

  mx = math.min(x1, mx)
  my = math.min(y1, my)
  mz = math.min(z1, mz)
  xx = math.max(x2, xx)
  xy = math.max(y2, xy)
  xz = math.max(z2, xz)
  for x=x1, x2, 1 do
    for y=y1, y2, 1 do
      for z=z1, z2, 1 do
        cubes[z][y][x] = onoff
      end
    end
  end
end

local on = 0
for x=mx, xx, 1 do
  for y=my, xy, 1 do
    for z=mz, xz, 1 do
      on = on + (cubes[z][y][x] and 1 or 0)
    end
  end
end
print(on)
