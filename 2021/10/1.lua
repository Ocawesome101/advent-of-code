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
end

local score = 0
for line in io.lines("10/i") do
  local bad = checkline(line)
  if bad == ")" then
    score = score + 3
  elseif bad == "]" then
    score = score + 57
  elseif bad == "}" then
    score = score + 1197
  elseif bad == ">" then
    score = score + 25137
  end
end

print(score)
