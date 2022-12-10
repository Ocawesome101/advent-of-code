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
end

local crt = {}
for i=1, 40*6 do crt[i] = "." end

local function dcrt()
  local lines = {
    table.concat(crt, "", 1, 40),
    table.concat(crt, "", 41, 80),
    table.concat(crt, "", 81, 120),
    table.concat(crt, "", 121, 160),
    table.concat(crt, "", 161, 200),
    table.concat(crt, "", 201, 240)
  }
  print(table.concat(lines, "\n"))
end

while not cycle() do
  local r = c % 40
  if x <= r and x + 2 >= r then
    crt[c] = "#"
  else
    crt[c] = " "
  end
  if to_add then
    x = x + to_add
    to_add = false
  end
end

dcrt()
