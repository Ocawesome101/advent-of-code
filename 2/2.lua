local h, d, a = 0, 0, 0

for line in io.lines() do
  local cmd, num = line:match("([^ ]+) (%d+)")
  if not cmd then break end
  num = tonumber(num)
  if cmd == "forward" then
    h = h + num
    d = d + (a * num)
  elseif cmd == "down" then
    a = a + num
  elseif cmd == "up" then
    a = a - num
  else
    print("DO NOT KNOW " .. cmd)
  end
end

print(h * d)
