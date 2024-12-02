local safe = 0

local function nsplit(line)
  local w = {}
  for t in line:gmatch("[^ ]+") do
    w[#w+1] = tonumber(t)
  end
  return w
end

local function sign(n)
  if n == 0 then return 1 end
  return n/math.abs(n)
end

local function cp(t)
  local n={}
  for i=1, #t do n[i] = t[i] end
  return n
end

local function testSafety(t, r)
  if r then table.remove(t, r) end
  local bs = sign(t[2] - t[1])
  for i=2, #t do
    local cur, last = t[i], t[i-1]
    local dif = cur - last
    if sign(dif) ~= bs or math.abs(dif) == 0 or math.abs(dif) > 3 then
      return false
    end
  end
  return true
end

for line in io.lines() do
  local num = nsplit(line)
  if testSafety(num) then
    safe = safe + 1
  else
    for i=1, #num do
      if testSafety(cp(num), i) then
        safe = safe + 1
        break
      end
    end
  end
end

print(safe)
