local rules = {}

local a, _, _, b = io.lines("14/i")
local start = {}
do
  local line = a(b)
  for c in line:gmatch(".") do
    start[#start+1] = c
  end
end

for line in a, _, _, b do
  local a, b = line:match("(..) %-> (.)")
  if a and b then
    rules[a] = b
  end
end

local function pair()
  local elements = {}
  for i=1, #start - 1, 1 do
    elements[#elements+1] = rules[start[i] .. start[i+1]]
  end
  for i=1, #elements, 1 do
    table.insert(start, i*2, elements[i])
  end
end

for i=1, 10, 1 do
  pair()
end
local counts = {}
for i=1, #start, 1 do
  if not counts[start[i]] then counts[start[i]] = 0 end
  counts[start[i]] = counts[start[i]] + 1
end

for k,v in pairs(counts) do
  if type(k) == "string" then
    counts[#counts+1] = {char = k, count = v}
  end
end

table.sort(counts, function(a, b) return a.count > b.count end)
print(counts[1].count - counts[#counts].count)
