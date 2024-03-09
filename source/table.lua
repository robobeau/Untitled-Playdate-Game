table.assign = function(target, source)
  for k in pairs(source) do
    target[k] = source[k]
  end
end

table.map = function(source, func, start, finish)
  local map <const> = {}

  for i = start or 1, finish or #source, 1 do
    table.insert(map, func(source[i], i, source))
  end

  return map
end