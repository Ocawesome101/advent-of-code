local crabs = {}

local min, max = 100, 0
for n in io.open("7/i"):read("a"):gmatch("[^,\n]+") do
  n = tonumber(n)
  crabs[#crabs+1] = n
  if n < min then min = n end
  if n > max then max = n end
end

local m
local cache = {}
m = function(n)
  if cache[n] then return cache[n] end
  local r = n * (n+1) / 2
  cache[n] = r
  return r
end
--[[
  local r = 0
  for i=1, n, 1 do
    r = r + i
  end
  return r
end]]

local mf, mfdist = 10000000000000000, 0
for i=min, max, 1 do
  local fuel = 0
  for n=1, #crabs, 1 do
    local c = crabs[n]
    if c > i then
      fuel = fuel + m(c - i)
    else
      fuel = fuel + m(i - c)
    end
  end
  if fuel < mf then
    mfdist = i
    mf = fuel
  end
end
print(mf)
