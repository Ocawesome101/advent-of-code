local sum = 0

for line in io.lines() do
  line = line:gsub("[A-Z]", function(c)
    return string.char(c:byte() - (string.byte("A") - 27)) end)
  line = line:gsub("[a-z]", function(c)
    return string.char(c:byte() - (string.byte("a") - 1)) end)
  local c1, c2 = line:sub(1, #line // 2), line:sub(#line // 2 + 1)
  local found
  c1 = c1:gsub(".", function(c)
    if c2:find(c, nil, true) and not found then
      print(c:byte())
      sum = sum + c:byte()
      found = true
    end
  end)
end

print(sum)
