local function splitgame(g)
  local s1 = {}
  for draw in g:gmatch("[^;]+") do
    s1[#s1+1] = draw
  end
  local draws = {}
  for i=1, #s1 do
    local d = {red=0,green=0,blue=0}
    draws[#draws+1] = d
    for amt, color in s1[i]:gmatch("(%d+) ([a-z]+)") do
      d[color] = tonumber(amt)
    end
  end
  return draws
end

local sum = 0

for line in io.lines() do
  local id, poss = line:match("Game (%d+): (.+)")
  local game = splitgame(poss)
  local mr, mg, mb = 0, 0, 0
  for i=1, #game do
    mr, mg, mb =
      math.max(mr, game[i].red),
      math.max(mg, game[i].green),
      math.max(mb, game[i].blue)
  end
  sum = sum + (mr*mg*mb)
end

print(sum)
