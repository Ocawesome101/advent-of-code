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

local function copy(t)
  local new = {}
  for i=1, #t, 1 do new[i] = t[i] end
  return new
end

local function search(cave, visited, path)
  visited = visited or {}
  path = path or {}
  for k, v in pairs(cave) do
    if k == "end" then
      paths[#paths+1] = path
      path = copy(path)
      paths[#paths][#paths[#paths]+1] = "end"
    elseif not visited[k] then
      path[#path+1] = k
      local visited = setmetatable({}, {__index = visited})
      if k:lower() == k then
        visited[k] = true
      end
      search(v, visited, copy(path))
    end
  end
end

search(caves.start, {start=true}, {"start"})
print(#paths)
