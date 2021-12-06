local fish = {
  [0] = 0,
  0,
  0,
  0,
  0,
  0,
  0,
  0,
  0
}

for num in io.open("6/i"):read("a"):gmatch("([^\n,]+)") do
  local n = tonumber(num)
  fish[n] = fish[n] + 1
end

local function simulate()
  local f0 = fish[0]
  for i=1, 8, 1 do
    fish[i - 1] = fish[i]
  end
  fish[6] = fish[6] + f0
  fish[8] = f0
end

for i=1, 256, 1 do simulate() end

local sum = 0
for i=0, #fish, 1 do sum = sum + fish[i] end
print(sum)
