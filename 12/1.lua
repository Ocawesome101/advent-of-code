local caves = {}

for line in io.lines("12/i") do
  local a, b = line:match("([^%-]+)%-([^%-]+)")
  if not caves[a] then
    caves[a] = {}
  end
  if not caves[b] then
    caves[b] = {}
  end
  caves[a][b] = caves[b]
  caves[b][a] = caves[a]
end

local paths = {}

local function search(cave, visited)
  local found = {}
  for k, v in pairs(cave) do
    if v:lower() == v then
      visited[v] = true
    end
  end
end
