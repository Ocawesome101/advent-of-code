local heightmap = {}

local n = 0

for line in io.lines("9/i") do
  local _line = {}
  for n in line:gmatch(".") do
    _line[#_line+1] = tonumber(n)
  end
  heightmap[#heightmap+1] = _line
end

local e = {}
for r=1, #heightmap, 1 do
  local row = heightmap[r]
  for c=1, #row, 1 do
    local val = row[c]
    local nx1, nx2 = row[c-1] or 9, row[c+1] or 9
    local ny1, ny2 = (heightmap[r-1] or e)[c] or 9, (heightmap[r+1] or e)[c]or 9
    if val < nx1 and val < ny1 and val < nx2 and val < ny2 then
      n = n + val + 1
    end
  end
end

print(n)
