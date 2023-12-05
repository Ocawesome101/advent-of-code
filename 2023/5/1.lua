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
    for num in line:gmatch("(%d+)") do
      num = tonumber(num)
      orig_seeds[#orig_seeds+1]=num
      orig_seeds[num] = true
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

local locnums = {}

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
  print(order[map], i, "=", mi)
  return find_lowest(mi, map+1)
end

for i=1, #orig_seeds do
  print("F",i,orig_seeds[i])
  locnums[i] = find_lowest(orig_seeds[i], 1)
end

table.sort(locnums)

print((locnums[1]))
