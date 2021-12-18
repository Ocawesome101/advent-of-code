local function step(x, y, vx, vy, my)
  if x > 275 or y < -75 then return end
  if x >= 241 and y <= -49 then return my end
  --if x > 30 or y < -10 then return end
  --if x >= 20 and y <= -5 then return my end
  my = math.max(y + vy, my)
  return step(x + vx, y + vy, math.max(0, vx - 1), vy - 1, my)
end

local function cast(vx, vy)
  return step(0, 0, vx, vy, 0)
end

local my = 0

for vx=1, 100, 1 do
  for vy=1, 100, 1 do
    my = math.max(my, cast(vx, vy) or 0)
  end
end

print(my)
