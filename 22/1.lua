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

  if x1 > 50 or y1 > 50 or z1 > 50 or x2 < -50 or y2 < -50 or z2 < -50 then
    -- do nothing
  else
    for x=x1, x2, 1 do
      for y=y1, y2, 1 do
        for z=z1, z2, 1 do
          cubes[z][y][x] = onoff
        end
      end
    end
  end
end

local on = 0
for x=-50, 50, 1 do
  for y=-50, 50, 1 do
    for z=-50, 50, 1 do
      on = on + (cubes[z][y][x] and 1 or 0)
    end
  end
end
print(on)
