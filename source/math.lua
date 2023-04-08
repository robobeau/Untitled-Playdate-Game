function math.clamp(a, min, max)
  return math.max(min, math.min(max, a))
end

function math.sign()
  return number > 0 and 1
    or number < 0 and -1
    or 0
end