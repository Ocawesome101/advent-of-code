local dots = {}

local maxw = 0
local lfx, lfy = 0
local function foldX(v)
  for r, row in ipairs(dots) do
    for i=0, v-1, 1 do
      local ia, ib = v - i - 1, v + i + 1
      row[ia] = row[ia] or row[ib]
      row[ib] = false
    end
  end
end

local function merge(a, b)
  for i=1, maxw, 1 do
    a[i] = a[i] or b[i]
    b[i] = false
  end
end

local function foldY(v)
  for i=0, v-1, 1 do
    local ia, ib = v - i - 1, v + i + 1
    merge(dots[ia], dots[ib])
  end
end

local fold = false
for line in io.lines("13/i") do
  if line == "" then
    fold = true
  elseif not fold then
    local a, b = line:match("(%d+),(%d+)")
    local x, y = tonumber(a), tonumber(b)
    for i=0, y, 1 do dots[i] = dots[i] or {} end
    dots[y][x] = true
    maxw = math.max(x, maxw)
  elseif fold then
    local xy, v = line:match("fold along ([xy])=(%d+)")
    if xy == "x" then
      foldX(v)
    elseif xy == "y" then
      foldY(v)
    end
  end
end

for i=0, #dots, 1 do
  for j=1, 80, 1 do
    if dots[i][j] then
      io.write("#")
    else
      io.write(" ")
    end
  end
  io.write("\n")
end
