local score = 0

local function i(n, l, h)
  return h >= n and n >= l
end

for line in io.lines() do
  local b, e, B, E = line:match("(%d+)%-(%d+),(%d+)%-(%d+)")
  b, e, B, E = tonumber(b), tonumber(e), tonumber(B), tonumber(E)

  if i(B, b, e) or i(E, b, e) or i(b, B, E) or i(e, B, E) then
    score = score + 1
  end
end

print(score)
