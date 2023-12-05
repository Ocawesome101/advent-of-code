local orig_seeds = {}
local maps = {
  sts = {},
  stf = {},
  ftw = {},
  wtl = {},
  ltt = {},
  tth = {},
  htl = {},
}
local order = {'sts','stf','ftw','wtl','ltt','tth','htl'}
local map

for line in io.lines() do
  if line:match("seeds") then
    for start, len in line:gmatch("(%d+) (%d+)") do
      start, len = tonumber(start), tonumber(len)
      orig_seeds[#orig_seeds+1] = {start=start, len=len}
    end
  elseif line:match("map") then
    map = table.concat({line:match("^(.).+%-(.).+%-(.).+ map:")})
    maps[map].ranges={}
  elseif #line > 2 then
    local dst, src, len = line:match("(%d+) +(%d+) +(%d+)")
    dst, src, len = tonumber(dst), tonumber(src), tonumber(len)
    table.insert(maps[map].ranges, {src=src, dst=dst, len=len, diff=dst-src})
  end
end

local function find_lowest(i, map)
  local m = maps[order[map]]
  if not m then return i end
  local mi = math.huge
  for _, range in pairs(m.ranges) do
    if range.src <= i and range.src+range.len > i then
      mi = math.min(mi, i+range.diff)
    end
  end
  if mi == math.huge then mi = i end
  return find_lowest(mi, map+1)
end

local min = math.huge
for i=1, #orig_seeds do
  local s = orig_seeds[i]
  for i=s.start, s.start+s.len-1 do
    min = math.min(min, find_lowest(i, 1))
  end
end

print((min))
