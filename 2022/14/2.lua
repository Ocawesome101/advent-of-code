local map = {}

local AIR = 0
local ROCK = 1
local SAND = 2
local VOID = 3

local WIDTH, HEIGHT = 1000, 1000
local FLOOR = 0

for i=0, HEIGHT do
  local line = {}
  for j=0, WIDTH do
    line[j] = AIR
  end
  map[i] = line
end

local function tile(x, y, i)
  if i then map[y][x] = i end
  if not map[y] then return VOID end
  return map[y][x]
end

local function sign(n)
  return n/math.abs(n)
end

for line in io.lines() do
  local px, py
  for cpair in line:gmatch("[^ %->]+") do
    local x, y = cpair:match("(%d+),(%d+)")
    x, y = tonumber(x), tonumber(y)
    FLOOR = math.max(FLOOR, y + 2)
    if not px then
      px, py = x, y
    else
      if x == px then
        for i=py, y, sign(y-py) do
          tile(x, i, ROCK)
        end
      elseif y == py then
        for i=px, x, sign(x-px) do
          tile(i, y, ROCK)
        end
      else
        print(x, y, px, py)
        error("hmmm maybe i should handle this i guess")
      end
      px, py = x, y
    end
  end
end

for i=0, WIDTH do
  map[FLOOR][i] = ROCK
end

local function vis()
  local o = "\27[2J\27[1;1H"
  for i=0, HEIGHT do
    o = o .. table.concat(map[i], nil, 470) .. "\n"
  end
  print(o)
end

local function doSandThing()
  local sx, sy = 500, 0
  while true do
    if tile(sx, sy+1) == AIR then
      sy = sy + 1
    elseif tile(sx-1, sy+1) == AIR then
      sy = sy + 1
      sx = sx - 1
    elseif tile(sx+1, sy+1) == AIR then
      sy = sy + 1
      sx = sx + 1
    else
      tile(sx, sy, SAND)
      break
    end
  end
  --vis()
  if sx == 500 and sy == 0 then return true end
end

local counter = 0
repeat
  counter = counter + 1
--  print(counter)
until doSandThing()

print(counter)
