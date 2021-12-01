local numbers = {}

for line in io.lines() do
  numbers[#numbers+1] = tonumber(line)
end

local increased = 0
for i=2, #numbers, 1 do
  if numbers[i] > numbers[i - 1] then
    increased = increased + 1
  end
end

print(increased)
