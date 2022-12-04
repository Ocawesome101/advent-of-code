local score = 0

for line in io.lines() do
  local b, e, B, E = line:match("(%d+)%-(%d+),(%d+)%-(%d+)")
  b, e, B, E = tonumber(b), tonumber(e), tonumber(B), tonumber(E)

  if (b <= B and e >= E) or (B <= b and E >= e) then
    score = score + 1
  end
end

print(score)
