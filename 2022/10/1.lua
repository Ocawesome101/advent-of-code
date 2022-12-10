local adding = false
local to_add = false
local c = 0
local x = 1
local function cycle()
  c = c + 1
  if adding then
    to_add = adding
    adding = false
  else
    local ins = io.read("l")
    if not ins then return true end
    if ins ~= "noop" then
      adding = assert(tonumber(ins:match("addx (.+)")))
    end
  end
  print(c, x)
end

local s = 0
while not cycle() do
  if c == 20 or c == 60 or c == 100 or c == 140 or c == 180 or c == 220 then
    print(("strength = %d * %d = %d"):format(c, x, c * x))
    s = s + (c * x)
  end
  if to_add then
    x = x + to_add
    to_add = false
  end
end

print(s)
