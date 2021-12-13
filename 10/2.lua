local chars = "[%(%[{<]"
local closing = "[%)%]}>]"
local complement = {
  ["("] = ")",
  [")"] = "(",
  ["["] = "]",
  ["]"] = "[",
  ['{'] = '}',
  ['}'] = '{',
  ['<'] = ">",
  ['>'] = "<"
}

local function checkline(l)
  local stack = {}
  for c in l:gmatch(".") do
    if c:match(chars) then
      stack[#stack+1] = c
    elseif stack[#stack] == complement[c] then
      stack[#stack] = nil
    else
      return c
    end
  end
  return nil, table.concat(stack):reverse()
    :gsub(".", function(k) return complement[k] end)
end

local scores = {}
for line in io.lines("10/i") do
  local bad, fin = checkline(line)
  local score = 0
  if not bad then -- not bad just incomplete
    fin = fin:gsub(".", function(k)
      score = score * 5
      if k == ")" then score = score + 1 end
      if k == "]" then score = score + 2 end
      if k == "}" then score = score + 3 end
      if k == ">" then score = score + 4 end
      return k
    end)
    scores[#scores+1] = score
  end
end

table.sort(scores)
local score = scores[math.ceil(#scores/2)]
print(score)
