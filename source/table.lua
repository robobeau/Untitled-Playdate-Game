table.assign = function(target, source)
  for k in pairs(source) do
    target[k] = source[k]
  end
end
