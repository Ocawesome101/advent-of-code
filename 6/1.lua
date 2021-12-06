-- simulate lanternfish! --

local fish = {}

for num in io.open("6/i"):read("a"):gmatch("([^\n,]+)") do
  fish[#fish+1] = tonumber(num)
end

local function simulate()
  local newFish = 0
  for i=1, #fish, 1 do
    if fish[i] == 0 then
      newFish = newFish + 1
      fish[i] = 6
    else
      fish[i] = fish[i] - 1
    end
  end
  print("ADD", newFish)
  for i=1, newFish, 1 do
    table.insert(fish, 8)
  end
end

print(#fish)

for i=1, 80, 1 do simulate() end

print(#fish)
