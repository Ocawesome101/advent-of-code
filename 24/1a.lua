local stages = {}
local chunk = ""

local replacements = {
  {"add (.) (.+)", "%1 = %1 + %2\n"},
  {"mul (.) (.+)", "%1 = %1 * %2\n"},
  {"div (.) (.+)", "%1 = math.floor(%1 / %2)\n"},
  {"mod (.) (.+)", "%1 = %1 %% %2\n"},
  {"eql (.) (.+)", "%1 = %1 == %2 and 1 or 0\n"}
}

for line in io.lines("24/i") do
  if line:sub(1,3) == "inp" then
    if #chunk > 0 then
      chunk = chunk .. "return z\nend"
      stages[#stages+1] = assert(load(chunk, "=stage"..(#stages+1)))()
    end
    chunk = "return function(w, z)\nlocal x, y = 0, 0\n"
  else
    for i=1, #replacements, 1 do
      line = line:gsub(unpack(replacements[i]))
    end
    chunk = chunk .. line
  end
end

if #chunk > 0 then
  chunk = chunk .. "return w, x, y, z\nend"
  stages[#stages+1] = assert(load(chunk, "=stage"..(#stages+1)))()
end

local gi = 0
io.stdout:setvbuf("no")
local rs = {}
local function solve(index, z)
  if index > 14 then return end
  gi = gi + 1
  if gi == 10000000 then gi = 0 io.write(".") end
  for i=9, 1, -1 do
    local nz = stages[index](i, z)
    if index == 14 and nz == 0 then
      print("YES", index, i)
      rs[index] = i
      return true
    end
    if solve(index + 1, nz) then
      print("YES", index, i)
      rs[index] = i
      return true
    end
  end
end

print(solve(1, 0, 0, 0))
print(table.concat(rs))
