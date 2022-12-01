local handle = io.open("16/i")
local data = handle:read("a")
handle:close()

local bits = {}
local n = 0
for c in data:gmatch(".") do
  if c == "\n" then break end
  c = tonumber("0x"..c)
  for i=3, 0, -1 do
    bits[n] = (c & 2^i == 0) and 0 or 1
    n = n + 1
  end
end

local packets = {}

local bit = 0

local function readBits(n)
  local r = 0
  for i=0, n-1, 1 do
    if bit+i > #bits then return end
    r = r | ((2^(n-i-1)) * bits[bit+i])
  end
  bit = bit + n
  return r
end

local sum = 0
while bit <= #bits do
  -- version
  local version = readBits(3)
  if not version then break end
  sum = sum + version
  local ptype = readBits(3)
  print(version, ptype)
  if ptype == 4 then
    local value = 0
    while true do
      local islast = readBits(1)
      local val = readBits(4)
      value = (value << 4) + val
      if islast == 0 then break end
    end
  else
    local ltid = readBits(1)
    local total
    if ltid == 0 then
      total = readBits(15)
    else
      total = readBits(11)
    end
  end
end

print(sum)
