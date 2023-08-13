-- Convenience variables
local pd <const> = playdate
local geo <const> = pd.geometry
local poi <const> = geo.point
local rec <const> = geo.rect

-- Tiled's custom properties need to be converted into a table.
function ConvertCustomPropertiesToTable(customProperties)
  local properties <const> = {}

  for _, customProperty in ipairs(customProperties) do
    properties[customProperty.name] = customProperty.value
  end

  return properties
end

function ExtractCharacterObjects(objects)
  local center = nil
  local collisions <const> = {
    Hitboxes = {},
    Hurtboxes = {},
    Pushbox = nil,
  }

  for i, object in ipairs(objects) do
    local properties <const> = ConvertCustomPropertiesToTable(object.properties or {})

    if (object.type == 'Center') then
      center = poi.new(object.x, object.y)
    elseif (object.type == 'Hitbox') then
      table.insert(collisions['Hitboxes'], {
        name = object.name, -- For debugging ;)
        properties = properties,
        rect = rec.new(object.x, object.y, object.width, object.height),
        type = object.type,
      })
    elseif (object.type == 'Hurtbox') then
      table.insert(collisions['Hurtboxes'], {
        name = object.name, -- For debugging ;)
        properties = properties,
        rect = rec.new(object.x, object.y, object.width, object.height),
        type = object.type,
      })
    elseif (object.type == 'Pushbox') then
      collisions['Pushbox'] = {
        name = object.name, -- For debugging ;)
        properties = properties,
        rect = rec.new(object.x, object.y, object.width, object.height),
        type = object.type,
      }
    end
  end

  return center, collisions
end