local schem = {}
local numbers = {}

do
  local l = 0
  for line in io.lines() do
    l = l + 1
    for i, num in line:gmatch("()(%d+)") do
      numbers[#numbers+1] = {L=l, I=i, N=#num, V=tonumber(num)}
    end
    for i, sym in line:gmatch("()(%*)") do
      schem[l] = schem[l] or {}
      schem[l][i] = sym
    end
  end
end

local adajacent = {}
for _, num in pairs(numbers) do
  local line, index, length, value = num.L, num.I, num.N, num.V
  for L=math.max(1, line-1), line+1 do
    local b = false
    for I=math.max(1, index-1), index+length do
      if schem[L] and schem[L][I] then
        adajacent[L] = adajacent[L] or {}
        adajacent[L][I] = adajacent[L][I] or {}
        table.insert(adajacent[L][I], value)
        break
      end
    end
  end
end

local sum = 0
for L, line in pairs(adajacent) do
  for I, index in pairs(line) do
    if #index == 2 then
      sum = sum + index[1]*index[2]
    end
  end
end

print(sum)
