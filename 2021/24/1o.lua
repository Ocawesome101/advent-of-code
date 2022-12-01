-- thanks to u/leijurv from reddit
local addx, divz, addy = {}, {}, {}

local block, ln = 0, 0
for line in io.lines("24/i") do
  if line:sub(1,3) == "inp" then
    block = block + 1
    ln = 1
  else
    ln = ln + 1
    local i, a, b = line:match("(...) (.) (.+)")
    a, b = tonumber(a) or a, tonumber(b)

    if i == "add" and a == "x" and b then
      addx[block] = b
    elseif i == "add" and a == "y" and b then
      addy[block] = b
    elseif i == "div" and a == "z" and b then
      divz[block] = b
    end
  end
end

local zbudget = {}
for i=1, #divz, 1 do
  local a = {}
  for x=1, #divz, 1 do
    if divz[x] == 26 and x >= i then
      a[#a+1] = x
    end
  end
  zbudget[i] = 26^#a
  print("z budget for stage", i, "is", zbudget[i])
end

local function run(index, w, z)
  local x = addx[index] + (z % 26)
  z = math.floor(z / divz[index])
  if x ~= w then
    z = (z * 26) + w + addy[index]
  end
  return z
end

local candidates = {1, 2, 3, 4, 5, 6, 7, 8, 9}
local function search(index, zval)
  if index == 15 then
    if zval == 0 then
      return {}
    end
    return {}
  end
  if zval > zbudget[index] then
    return {}
  end
  local newx = addx[index] + zval % 26
  local wpot = candidates
  --if newx > 0 and newx < 10 then
  --  wpot = {newx}
  --end
  local ret = {}
  for _, w in ipairs(wpot) do
    local newz = run(index, zval, w)
    local nxt = search(index + 1, newz)
    for _, nx in ipairs(nxt) do
      ret[#ret+1] = (w * 10) + nx
    end
  end
  return ret
end

local values = search(1, 0)
print(values, #values, unpack(values))
