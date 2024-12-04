local data = io.read("a")

local sum = 0
local Do = true

repeat
  local nmul = data:find("mul%(%d+,%d+%)") or math.huge
  local ndo = data:find("do%(%)") or math.huge
  local ndont = data:find("don't%(%)") or math.huge
  local closest = math.min(nmul, ndo, ndont)

  if closest == math.huge then break end
  data = data:sub(closest)
  if #data == 0 then break end
  local inst = data:match("[a-z']+")
  data = data:sub(#inst)
  if inst == "mul" then
    local m1, m2 = data:match("%((%d+),(%d+)%)")
    data = data:sub(1)
    if Do then
      sum = sum + tonumber(m1)*tonumber(m2)
    end
  elseif inst == "do" then
    data = data:sub(2)
    Do = true
  elseif inst == "don't" then
    data = data:sub(2)
    Do = false
  end

until #data == 0

print(sum)
