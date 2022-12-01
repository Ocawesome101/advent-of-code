local crabs = {}

local min, max = 100, 0
for n in io.open("7/i"):read("a"):gmatch("[^,\n]+") do
  n = tonumber(n)
  crabs[#crabs+1] = n
  if n < min then min = n end
  if n > max then max = n end
end

local mf, mfdist = 1000000, 1000000
for i=min, max, 1 do
  local fuel = 0
  for n=1, #crabs, 1 do
    local c = crabs[n]
    if c > i then
      fuel = fuel + (c - i)
    else
      fuel = fuel + (i - c)
    end
  end
  if fuel < mf then
    mfdist = i
    mf = fuel
  end
end
print(mf)
