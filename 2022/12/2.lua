local finder = require("12.pathfinding")

local A, E = {}

local map = {}
for line in io.lines() do
  local row = {}
  for c in line:gmatch(".") do
    if c == "S" or c == "a" then
      A[#A+1] = {x=#row+1, y=#map+1}
      c = "a"
    elseif c == "E" then
      E = {x=#row+1, y=#map+1}
      c = "z"
    end
    row[#row+1] = {c=c:byte(),x=#row+1,y=#map+1}
  end
  map[#map+1] = row
end

local dist = math.huge
for i=1, #A do
  local S = A[i]
  local path = finder("one", map[S.y][S.x], map[E.y][E.x], function(n)
    local ret = {}
    local try = {}
    try[#try+1] = map[n.y-1] and map[n.y-1][n.x]
    try[#try+1] = map[n.y+1] and map[n.y+1][n.x]
    try[#try+1] = map[n.y][n.x-1]
    try[#try+1] = map[n.y][n.x+1]
    for i=1, #try do
      if try[i].c - n.c <= 1 then
        ret[#ret+1] = try[i]
      end
    end
    return ret
  end)

  if #path > 0 then
    dist = math.min(dist, #path-1)
  end
end

print(dist)
