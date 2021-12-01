local numbers = {}

for line in io.lines() do
  numbers[#numbers+1] = tonumber(line)
end

local windows = {}

for i=1, #numbers - 2, 1 do
  local n = numbers[i] + numbers[i+1] + numbers[i+2]
  windows[#windows+1] = n
end

local increased = 0
for i=2, #windows, 1 do
  if windows[i] > windows[i - 1] then
    increased = increased + 1
  end
end

print(increased)
