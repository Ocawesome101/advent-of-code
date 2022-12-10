local visited = {}
local points = {}
for i=1, 10 do points[i] = {x=0, y=0} end

local function corraly(a, pa, pb)
  if a and (pb.x < pa.x - 1 or pb.x > pa.x + 1) then pb.y = pa.y end

  if pb.y < pa.y - 1 then
    pb.y = pa.y - 1
  elseif pb.y > pa.y + 1 then
    pb.y = pa.y + 1
  end
end

local function corralx(a, pa, pb)
  if a and (pb.y < pa.y - 1 or pb.y > pa.y + 1) then pb.x = pa.x end

  if pb.x < pa.x - 1 then
    pb.x = pa.x - 1
  elseif pb.x > pa.x + 1 then
    pb.x = pa.x + 1
  end
end

local function corral(isx, pa, pb)
  if isx then corraly(true, pa, pb) corralx(nil, pa, pb)
  else corralx(true, pa, pb) corraly(nil, pa, pb) end
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

local mx, my, MX = 0, 0, 0
local function vis()
  for y=my, #visited do
    for x=mx, MX do
      local w = false
      for n=1, #points do
        local p = points[n]
        if p.x == x and p.y == y then
          io.write(n-1)
          w = true
          break
        end
      end
      if not w then
        if visited[y] and visited[y][x] then io.write("#")
        else io.write(".") end
      end
    end
    io.write("\n")
  end
  io.write("\n")
end

local v = 0
for line in io.lines() do
  local m, n = line:match("(.) (%d+)")
  for _=1, tonumber(n) do
    local x = motions[m](1, points[1])

    for i=1, #points-1 do
      local pa, pb = points[i], points[i+1]
      corral(x, pa, pb)
      mx, my, MX = math.min(mx, pa.x, pb.x), math.min(my, pa.y, pb.y),
        math.max(MX, pa.x, pb.x)
    end

    local pb = points[#points]
    visited[pb.y] = visited[pb.y] or {}
    if not visited[pb.y][pb.x] then v = v + 1 end
    visited[pb.y][pb.x] = true

    vis()
  end
end

print(v)
