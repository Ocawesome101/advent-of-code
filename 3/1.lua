local counts = {}

for line in io.lines("3/i") do
  local i = 0
  for c in line:gmatch(".") do
    i = i + 1
    c = tonumber(c)
    if not counts[i] then
      counts[i] = {[0] = 0, [1] = 0}
    end
    counts[i][c] = counts[i][c] + 1
  end
end

local gam, eps = "", ""
for i, c in ipairs(counts) do
  if c[1] > c[0] then
    gam = gam .. 1
    eps = eps .. 0
  else
    gam = gam .. 0
    eps = eps .. 1
  end
end

print(tonumber(gam, 2) * tonumber(eps, 2))
