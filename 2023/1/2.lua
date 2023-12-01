
local function getNumbers(line)
  local n = {}
  local nn = {
    [0] = "()zero",
    "()one",
    "()two",
    "()three",
    "()four",
    "()five",
    "()six",
    "()seven",
    "()eight",
    "()nine",
  }
  local p, pv = {}, {}
  for i=0, #nn do
    for I in line:gmatch(nn[i]) do
      n[#n+1] = {I, i}
    end
  end
  for i,N in line:gmatch("()(%d)") do
    n[#n+1] = {i,tonumber(N)}
  end
  table.sort(n, function(a,b)
    return a[1]<b[1]
  end)
  return n
end

local total = 0
for line in io.lines() do
  print(line)
  local numbers = getNumbers(line)
  print(numbers[1][2]..numbers[#numbers][2])
  total = total + tonumber(numbers[1][2]..numbers[#numbers][2])
end

print(total)
