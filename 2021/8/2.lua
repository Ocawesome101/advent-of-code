
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

local function split(word, r)
  local c = {}
  for _c in word:gmatch(".") do
    c[#c+1] = _c
    if r then c[_c] = #c end
  end
  return c
end

local function sort(word)
  local c = split(word)
  table.sort(c)
  return table.concat(c)
end

local function has(word, chars)
  local wa = split(word, true)
  local wb = split(chars)
  for i=1, #wb, 1 do
    if not wa[wb[i]] then return false end
  end
  return true
end

local function missing(a, b)
  local wa, wb = split(a, true), split(b)
  for i=1, #wb, 1 do
    if not wa[wb[i]] then return wb[i] end
  end
end

for line in io.lines("8/i") do
  local map = {a, b, c, d, e, f, g}
  local lnumbers = {}
  local words = {}
  local output = {}
  local rl = false
  for word in line:gmatch("[^ ]+") do
    word = sort(word)
    if word == "|" then rl = true
    elseif rl then output[#output+1] = word
    else words[#words+1] = word end
  end
  local rm = {}
  for _, word in ipairs(words) do
    if #word == 2 then -- this is a 1
      lnumbers[1] = word
      rm[#rm+1]=_
    elseif #word == 4 then -- this is a 4
      lnumbers[4] = word
      rm[#rm+1]=_
    elseif #word == 3 then -- this is a 7
      lnumbers[7] = word
      rm[#rm+1]=_
    elseif #word == 7 then -- this is an 8
      lnumbers[8] = word
      rm[#rm+1]=_
    end
  end
  table.sort(rm)
  for i=#rm, 1, -1 do
    table.remove(words, rm[i])
  end
  -- now that we know those, we can figure out the segments
  -- 9 is 4 with two extras, so find that
  for _, word in ipairs(words) do
    if #word == 6 and has(word, lnumbers[4]) then
      lnumbers[9] = word
      table.remove(words, _)
      break
    end
  end
  -- 0 has all the segments of 7
  for _, word in ipairs(words) do
    if #word == 6 and has(word, lnumbers[7]) then
      lnumbers[0] = word
      table.remove(words, _)
      break
    end
  end
  -- 6 is the one remaining combination of 6 segments
  for _, word in ipairs(words) do
    if #word == 6 and word ~= lnumbers[0] and word ~= lnumbers[9] then
      lnumbers[6] = word
      table.remove(words, _)
      break
    end
  end
  -- 5 is 6 sans one segment, E
  for _, word in ipairs(words) do
    if #word == 5 and has(lnumbers[6], word) then
      lnumbers[5] = word
      table.remove(words, _)
      break
    end
  end
  -- we now know 0, 1, 4, 5, 6, 7, 8, 9
  -- 6 and 1 share one segment, F
  -- so we can figure out C and F
  map.c = missing(lnumbers[6], lnumbers[1])
  map.f = missing(map.c, lnumbers[1])
  -- 9 is 8 without segment E
  map.e = missing(lnumbers[9], lnumbers[8])
  -- we just need 2 and 3
  -- 3 has both C and F
  -- 2 has both C and E
  for _, word in ipairs(words) do
    if has(word, map.e) then
      lnumbers[2] = word
      table.remove(words, _)
      lnumbers[3] = words[1]
      break
    end
  end
  for k, v in pairs(lnumbers) do lnumbers[v] = k end
  -- now, after all that, we can finally decode!
  local outs = ""
  for i=1, #output, 1 do
    outs = outs .. lnumbers[output[i]]
  end
  n = n + tonumber(outs)
end

print(n)
