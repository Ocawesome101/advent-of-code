local cache = {}

local op1 = 5-1
local op2 = 8-1

local function count_wins(p1, p2, s1, s2)
  if s1 > 20 then return 1, 0 end
  if s2 > 20 then return 0, 1 end

  local lookup = "p" .. p1 .. "p" .. p2 .. "s" .. s1 .. "s" .. s2
  if cache[lookup] then
    return table.unpack(cache[lookup])
  end

  local a1, a2 = 0, 0
  for d1 = 1, 3, 1 do
    for d2 = 1, 3, 1 do
      for d3 = 1, 3, 1 do
        local roll = d1 + d2 + d3
        local np1 = (p1 + roll) % 10
        local ns1 = s1 + np1 + 1
        local x1, y1 = count_wins(p2, np1, s2, ns1)

        a1 = a1 + y1
        a2 = a2 + x1
      end
    end
  end

  cache[lookup] = {a1, a2}

  return a1, a2
end

print(math.max(count_wins(op1, op2, 0, 0)))
