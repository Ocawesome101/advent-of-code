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

local bit = 0

local function readBits(n)
  local r = 0
  for i=0, n-1, 1 do
    if bit+i > #bits then return end
    r = (r << 1) + bits[bit+i]
  end
  bit = bit + n
  return r
end

local readPacket
readPacket = function()
  -- version
  local version = readBits(3)
  if not version then return nil end
  local ptype = readBits(3)
  print(version, ptype)
  if ptype == 4 then
    local value = 0
    local nbits = 0
    while true do
      local islast = readBits(1)
      local val = readBits(4)
      value = (value << 4) + val
      nbits = nbits + 5
      if islast == 0 then break end
    end
    return value, 6 + nbits
  else
    local ltid = readBits(1)
    local tlen
    if ltid == 0 then
      tlen = readBits(15)
    else
      tlen = readBits(11)
    end
    local subpackets = {}
    local nread = 0
    local pread = 0
    if ltid == 1 then
      while pread < tlen do
        local val, rd = readPacket()
        subpackets[#subpackets+1] = val
        pread = pread + 1
        nread = nread + rd
      end
    else
      while nread < tlen do
        local val, rd = readPacket()
        subpackets[#subpackets+1] = val
        nread = nread + rd
      end
    end
    local ret = 0
    if ptype == 0 then
      for i=1, #subpackets, 1 do ret = ret + subpackets[i] end
    elseif ptype == 1 then
      ret = subpackets[1]
      for i=2, #subpackets, 1 do ret = ret * subpackets[i] end
    elseif ptype == 2 then
      ret = math.min(table.unpack(subpackets))
    elseif ptype == 3 then
      ret = math.max(table.unpack(subpackets))
    elseif ptype == 5 then
      local a, b = subpackets[1], subpackets[2]
      if a > b then ret = 1 end
    elseif ptype == 6 then
      local a, b = subpackets[1], subpackets[2]
      if a < b then ret = 1 end
    elseif ptype == 7 then
      local a, b = subpackets[1], subpackets[2]
      if a == b then ret = 1 end
    end
    return ret, nread + 7 + (ltid == 0 and 15 or 11)
  end
end

print(readPacket())
