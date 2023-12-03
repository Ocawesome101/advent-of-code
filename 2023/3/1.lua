local schem = {}
local numbers = {}
do
  local l = 0
  for line in io.lines() do
    l = l + 1
    for i, num in line:gmatch("()(%d+)") do
      numbers[#numbers+1] = {L=l, I=i, N=#num, V=tonumber(num)}
    end
    for i, sym in line:gmatch("()([^%d%.])") do
      schem[l] = schem[l] or {}
      schem[l][i] = sym
    end
  end
end

local sum = 0
for _, num in pairs(numbers) do
  local line, index, length, value = num.L, num.I, num.N, num.V
  for L=math.max(1, line-1), line+1 do
    local b = false
    for I=math.max(1, index-1), index+length do
      if schem[L] and schem[L][I] then
        sum = sum + value
        print(value, schem[L][I])
        b = true
        break
      end
    end
    if b then break end
  end
end

print(sum)
