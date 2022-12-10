local visited = {}
local head, tail = {x=0, y=0}, {x=0, y=0}

local function corraly(a)
  if a and (tail.x < head.x - 1 or tail.x > head.x + 1) then tail.y = head.y end

  if tail.y < head.y - 1 then
    tail.y = head.y - 1
  elseif tail.y > head.y + 1 then
    tail.y = head.y + 1
  end
end

local function corralx(a)
  if a and (tail.y < head.y - 1 or tail.y > head.y + 1) then tail.x = head.x end

  if tail.x < head.x - 1 then
    tail.x = head.x - 1
  elseif tail.x > head.x + 1 then
    tail.x = head.x + 1
  end
end

local function corral(isx)
  if isx then corraly(true) corralx() else corralx(true) corraly() end
end

local motions = {}
function motions.R(n)
  head.x = head.x + n
  corral(true)
end

function motions.L(n)
  head.x = head.x - n
  corral(true)
end

function motions.U(n)
  head.y = head.y + n
  corral(false)
end

function motions.D(n)
  head.y = head.y - n
  corral(false)
end

local v = 0
for line in io.lines() do
  local m, n = line:match("(.) (%d+)")
  print(m, n)
  for _=1, tonumber(n) do
    motions[m](1)
    visited[tail.y] = visited[tail.y] or {}
    if not visited[tail.y][tail.x] then v = v + 1 end
    visited[tail.y][tail.x] = true
    print("\t", head.x, head.y, tail.x, tail.y)
  end
end

print(v)
