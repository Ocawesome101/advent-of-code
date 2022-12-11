local monkeys = {}

local function split(t, p, c)
  local r = {}
  for w in t:gmatch("[^"..p.."]+") do
    if c then w = c(w) end
    r[#r+1] = w
  end
  return r
end

local it = false
local common = 1
for line in io.lines() do
  if line:sub(1,1) == "M" then -- Monkey #:
    monkeys[tonumber(line:sub(-2, -2)) + 1] = {insp = 0}
  elseif not it then
    if line:sub(3,3) == "S" then -- Starting items
      local items_raw = line:match("Starting items: (.+)")
      monkeys[#monkeys].items = split(items_raw, ", ", tonumber)

    elseif line:sub(3,3) == "O" then -- Operation
      monkeys[#monkeys].operation = load([[return function(old)
        local ]] .. line:match("Operation: (.+)") .. [[
        return new
      end]])()

    elseif line:sub(3,3) == "T" then -- Test
      it = true
      monkeys[#monkeys].test = {
        factor = tonumber(line:match("divisible by (%d+)"))
      }
      common = common * monkeys[#monkeys].test.factor
    end
  elseif #line == 0 then
    it = false
  else
    local cond, num = line:match("If ([^ :]+): throw to monkey (%d+)")
    monkeys[#monkeys].test[cond == "true"] = tonumber(num)
  end
end

for round=1, 10000 do
  for m=1, #monkeys do
    m = monkeys[m]
    for i=1, #m.items do
      m.insp = m.insp + 1
      m.items[i] = m.operation(m.items[i])
    end
    for i=1, #m.items do
      m.items[i] = m.items[i] % common
      local to = m.test[m.items[i] % m.test.factor == 0] + 1
      table.insert(monkeys[to].items, m.items[i])
    end
    m.items = {}
  end
end

table.sort(monkeys, function(a,b)
  return a.insp > b.insp
end)

print(monkeys[1].insp * monkeys[2].insp)
