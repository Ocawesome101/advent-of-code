local moves = {}

for line in io.lines() do
  moves[#moves+1] = {line:match("([ABC]) ([XYZ])")}
end

local rps = {
  A = "rock",
  B = "paper",
  C = "scissors",
}

local scores = {
  rock = 1,
  paper = 2,
  scissors = 3
}

local beats = {
  rock = "paper",
  paper = "scissors",
  scissors = "rock"
}

local loses = {
  rock = "scissors",
  paper = "rock",
  scissors = "paper"
}

local score = 0

for i=1, #moves do
  local m = moves[i]
  m[1] = rps[m[1]]

  if m[2] == "X" then
    m[2] = loses[m[1]]
  elseif m[2] == "Y" then
    m[2] = m[1]
  elseif m[2] == "Z" then
    m[2] = beats[m[1]]
  end
  local thisscore = scores[m[2]]

  if m[1] == m[2] then
    thisscore = thisscore + 3
  elseif beats[m[1]] == m[2] then
    thisscore = thisscore + 6
  end

  score = score + thisscore
end

print(score)
