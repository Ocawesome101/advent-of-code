local sum = 0

local function pri(line)
  line = line:gsub("[A-Z]", function(c)
    return string.char(c:byte() - (string.byte("A") - 27)) end)
  line = line:gsub("[a-z]", function(c)
    return string.char(c:byte() - (string.byte("a") - 1)) end)
  return line
end

local function t(l, i)
  return not not l:find(string.char(i), nil, true)
end

for e1, e2, e3 in io.lines(nil, "l", "l", "l") do
  e1, e2, e3 = pri(e1), pri(e2), pri(e3)
  for i=1, 52 do
    if t(e1, i) and t(e2, i) and t(e3, i) then
      sum = sum + i
      break
    end
  end
end

print(sum)
