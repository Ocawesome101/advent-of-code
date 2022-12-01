local onum = {}
local cnum = {}

for line in io.lines("3/i") do
  local split = {}
  for c in line:gmatch(".") do
    split[#split+1] = tonumber(c)
  end
  onum[#onum+1] = split
  cnum[#cnum+1] = split
end
local blen = #onum[1]

local function filterOnBit(bit, num, l)
  local del = {}
  local b0, b1 = {}, {}
  local c0, c1 = 0, 0
  for i, n in ipairs(num) do
    if n[bit] == 1 then c1 = c1 + 1 b1[i] = true
    else c0 = c0 + 1 b0[i] = true end
  end
  if c0 > c1 then
    del = l and b0 or b1
  else
    del = l and b1 or b0
  end
  if #num > 1 then
    for i=#num, 1, -1 do
      if del[i] then
        table.remove(num, i)
      end
    end
  end
end

local oxr, cor = 0, 0
for i=1, blen, 1 do
  filterOnBit(i, onum)
  filterOnBit(i, cnum, true)
end
print(tonumber(table.concat(onum[1]), 2) * tonumber(table.concat(cnum[1]), 2))
