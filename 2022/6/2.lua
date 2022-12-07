local inp = io.read()

local function B(i)
  return inp:sub(i,i):byte()
end

local S = 14

for i=S, #inp do
  local t, d = {}, true
  for x=0, S-1 do
    local c = B(i-x)
    if t[c] then
      d = false
      break
    end
    t[c] = true
  end
  if d then
    print(i)
    break
  end
end

