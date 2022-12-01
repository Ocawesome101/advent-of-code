local insts = {}

for line in io.lines("24/i") do
  local inst = line:match("([^ ]+)")
  local a, b
  if inst == "inp" then
    insts[#insts+1] = {}
    a = line:match("[^ ]+ ([^ ]+)")
  else
    a, b = line:match("[^ ]+ ([^ ]+) ([^ ]+)")
    a, b = tonumber(a) or a, tonumber(b) or b
  end
  insts[#insts][#insts[#insts]+1] = {inst, a, b}
end

local statemt = {__index = function(_,k) return k end}

local function run(num, insts, r)
  for i=1, #insts, 1 do
    local it, a, b = table.unpack(insts[i])
    if it == "inp" then
      r[a] = num
    else
      if it == "add" then
        r[a] = r[a] + r[b]
      elseif it == "mul" then
        r[a] = r[a] * r[b]
      elseif it == "div" then
        if b==0 then print "DIV BY 0" return end
        r[a] = r[a] // r[b]
      elseif it == "mod" then
        if r[a] < 0 or r[b] <= 0 then print "BAD MOD" return end
        r[a] = r[a] % r[b]
      elseif it == "eql" then
        r[a] = r[a] == r[b] and 1 or 0
      end
    end
  end
end

local rs = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}

local gi = 0
io.stdout:setvbuf("no")
local function solve(index, state)
  if index > 14 then return end
  gi = gi + 1
  if gi == 10000 then gi = 0 io.write(".") end
  for i=9, 1, -1 do
    local new = setmetatable({w = state.w, x = state.x, y = state.y,
      z = state.z}, statemt)
    run(i, insts[index], new)
    if index == 14 and new.z == 0 then print("YES", index, i) rs[index] = i return true end
    if solve(index + 1, new) then print("YES", index, i) rs[index] = i return true end
  end
end

print(solve(1, setmetatable({w = 0, x = 0, y = 0, z = 0}, statemt)))
print(table.concat(rs))
