local rules = {}

local a, _, _, b = io.lines("14/i")
local start = {}
local counts = {}
local elements = {}
do
  local line = a(b)
  for c in line:gmatch(".") do
    elements[c] = (elements[c] or 0) + 1
    start[#start+1] = c
  end
  for i=1, #start-1, 1 do
    counts[start[i]..start[i+1]] = (counts[start[i]..start[i+1]] or 0) + 1
  end
end


for line in a, _, _, b do
  local a, b = line:match("(..) %-> (.)")
  if a and b then
    rules[a] = b
  end
end

local function pair()
  local ncounts = {}
  for pair, ins in pairs(rules) do
    local a, b = pair:sub(1,1), pair:sub(-1)
    --elements[a] = (elements[a] or 0) + 1
    --elements[b] = (elements[b] or 0) + 1
    local na, nb = a .. ins, ins .. b
    local n = counts[pair] or 0
    elements[ins] = (elements[ins] or 0) + n
    --ncounts[pair] = 0
    ncounts[na] = (ncounts[na] or 0) + n
    ncounts[nb] = (ncounts[nb] or 0) + n
  end
  counts = ncounts
end

for i=1, 40, 1 do
  pair()
end

local sort = {}
for k, v in pairs(elements) do
  if v ~= 0 then sort[#sort+1] = v end
end
table.sort(sort)
print(sort[#sort] - sort[1])
