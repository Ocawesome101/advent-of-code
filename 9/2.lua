local heightmap = {}

for line in io.lines("9/i") do
  local _line = {}
  for n in line:gmatch(".") do
    _line[#_line+1] = tonumber(n)
  end
  heightmap[#heightmap+1] = _line
end

local e = {}
local visited = {}
local function find(r, c)
  local n = 0
  if visited[r] and visited[r][c] then return -1 end
  local row = heightmap[r]
  if not row then return -1 end
  local val = row[c]
  visited[r] = visited[r] or {}
  visited[r][c] = true
  if not val then return -1 end
  if val == 9 then return -1 end
  local nx1, nx2 = row[c-1] or 30, row[c+1] or 30
  local ny1, ny2 = (heightmap[r-1] or e)[c] or 30,
    (heightmap[r+1] or e)[c] or 30
  if val < nx1 then n = n + 1 + find(r, c-1) end
  if val < nx2 then n = n + 1 + find(r, c+1) end
  if val < ny1 then n = n + 1 + find(r-1, c) end
  if val < ny2 then n = n + 1 + find(r+1, c) end
  return n
end

local basins = {}
for r=1, #heightmap, 1 do
  local row = heightmap[r]
  for c=1, #row, 1 do
    local val = row[c]
    local nx1, nx2 = row[c-1] or 9, row[c+1] or 9
    local ny1, ny2 = (heightmap[r-1] or e)[c] or 9, (heightmap[r+1] or e)[c]or 9
    if val < nx1 and val < ny1 and val < nx2 and val < ny2 then
      basins[#basins+1] = find(r, c) + 1
    end
  end
end

table.sort(basins)

print(basins[#basins] * basins[#basins-1] * basins[#basins-2])
