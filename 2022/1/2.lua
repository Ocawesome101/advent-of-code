local elves = {0}

for line in io.lines() do
  if #line == 0 then
    elves[#elves+1] = 0
  else
    elves[#elves] = elves[#elves] + tonumber(line)
  end
end

table.sort(elves)
print(elves[#elves] + elves[#elves-1] + elves[#elves-2])
