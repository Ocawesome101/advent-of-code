local inp = io.read()

local function B(i)
  return inp:sub(i,i):byte()
end

for i=4, #inp do
  local a, b, c, d = B(i), B(i-1), B(i-2), B(i-3)
  if a ~= b and a ~= c and a ~= d and b ~= c and b ~= d and c ~= d then
    print(a, b, c, d, i)
    break
  end
end

