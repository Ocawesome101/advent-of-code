local h, d = 0, 0

for line in io.lines() do
  local cmd, num = line:match("([^ ]+) (%d+)")
  if not cmd then break end
  num = tonumber(num)
  if cmd == "forward" then
    h = h + num
  elseif cmd == "down" then
    d = d + num
  elseif cmd == "up" then
    d = d - num
  else
    print("DO NOT KNOW " .. cmd)
  end
end

print(h * d)
