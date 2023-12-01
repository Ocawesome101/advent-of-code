
local function getNumbers(line)
  local n = {}
  for N in line:gmatch("%d") do
    n[#n+1] = tonumber(N)
  end
  return n
end

local total = 0
for line in io.lines() do
  local numbers = getNumbers(line)
  total = total + tonumber(numbers[1]..numbers[#numbers])
end

print(total)
