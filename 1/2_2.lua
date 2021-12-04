local numbers = {}

for line in io.lines() do
  numbers[#numbers+1] = tonumber(line)
end

local increased = 0
for i=4, #numbers, 1 do
  if numbers[i] > numbers[i - 3] then
    increased = increased + 1
  end
end

print(increased)
