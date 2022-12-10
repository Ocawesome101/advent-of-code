local visited = {}
local points = {}
for i=1, 10 do points[i] = {x=0, y=0} end

local function sign(n)
  return n/math.abs(n)
end

local function corral(pa, pb)
  if math.abs(pb.x - pa.x) > 1 then
    -- diagonal?
    if math.abs(pb.y - pa.y) == 1 then
      pb.y = pb.y - sign(pb.y - pa.y)
    end
    pb.x = pb.x - sign(pb.x - pa.x)
  end

  if math.abs(pb.y - pa.y) > 1 then
    -- diagonal?
    if math.abs(pb.x - pa.x) == 1 then
      pb.x = pb.x - sign(pb.x - pa.x)
    end
    pb.y = pb.y - sign(pb.y - pa.y)
  end
end

local motions = {}
function motions.R(n, pa)
  pa.x = pa.x + n
  return true
end

function motions.L(n, pa)
  pa.x = pa.x - n
  return true
end

function motions.U(n, pa)
  pa.y = pa.y + n
end

function motions.D(n, pa)
  pa.y = pa.y - n
end

local mx, my, MX, MY = 0, 0, 0, 0
local function vis()
  local o = "\27[2J\27[1;1H"
  for y=MY, my, -1 do
    local l = ""
    for x=mx, MX do
      local w = false
      for n=#points, 1, -1 do
        local p = points[n]
        if p.x == x and p.y == y then
          l = l .. (n - 1)
          w = true
          break
        end
      end
      if not w then
        if visited[y] and visited[y][x] then l = l .. "#"
        else l = l .. "." end
      end
    end
    o = o .. (l.."\n")
  end
  io.write(o)
end

local v = 0
for line in io.lines() do
  local m, n = line:match("(.) (%d+)")
  for _=1, tonumber(n) do
    motions[m](1, points[1])

    for i=1, #points-1 do
      local pa, pb = points[i], points[i+1]
      corral(pa, pb)
      mx, my, MX, MY = math.min(mx, pa.x, pb.x), math.min(my, pa.y, pb.y),
        math.max(MX, pa.x, pb.x), math.max(MY, pa.y, pb.y)
    end

    local pb = points[#points]
    visited[pb.y] = visited[pb.y] or {}
    if not visited[pb.y][pb.x] then v = v + 1 end
    visited[pb.y][pb.x] = true

    vis()
  end
end

print(v)
