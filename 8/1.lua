
local numbers = {
  [0] = "abcefg",
  "cf", -- 1
  "acdeg", -- 2
  "acdfg", -- 3
  "bcdf", -- 4
  "abdfg", -- 5
  "abdefg", -- 6
  "acf", -- 7
  "abcdefg", -- 8
  "abcdfg" -- 9
}

local n = 0

for line in io.lines("8/i") do
--  local map = {a, b, c, d, e, f, g}
  local lnumbers = {}
  local words = {}
  local rl = false
  for word in line:gmatch("[^ ]+") do
    if word == "|" then rl = true
    elseif rl then words[#words+1] = word end
  end
  for _, word in ipairs(words) do
    --if word == "|" then break end
    if #word == 2 then -- this is a 1
      n = n + 1
      lnumbers[1] = word
    elseif #word == 4 then -- this is a 4
      n = n + 1
      lnumbers[4] = word
    elseif #word == 3 then -- this is a 7
      n = n + 1
      lnumbers[3] = word
    elseif #word == 7 then -- this is an 8
      n = n + 1
      lnumbers[7] = word
    end
  end
end

print(n)
