-- cleaner verson of day 3 --

local gamma, epsilon = 0, 0

local lines = {}

for line in io.lines("3/i") do
  lines[#lines+1] = tonumber(line, 2)
end

local function checkBits(n, exc)
  local bp = 2^(n-1)
  local c = 0
  for i, num in ipairs(lines) do
    if not (exc and exc[i]) then
      if num & bp ~= 0 then c = c + 1 end
    end
  end
  local ret = (c >= #lines / 2) and bp or 0
  return ret
end

for i=1, 12, 1 do
  gamma = gamma | checkBits(i)
end

epsilon = gamma ~ 4095
print(gamma * epsilon)
