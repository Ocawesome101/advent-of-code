local data = io.read("a")

local sum = 0

for m1, m2 in data:gmatch("mul%((%d+),(%d+)%)") do
  print(m1, m2)
  sum = sum + tonumber(m1) * tonumber(m2)
end

print(sum)
