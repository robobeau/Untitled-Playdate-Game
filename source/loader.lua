-- Convenience variables
local pd <const> = playdate
local gfx <const> = pd.graphics

local defaults = {
  -- ended = false,
  -- started = false,
}

class('Loader', defaults).extends(gfx.sprite)

function Loader:init(config)
end

-- function Loader:Start()

-- end

-- function Loader:Stop()
  
-- end

function Loader.update()
  coroutine.yield()
end

-- local allImagesProcessed = false

-- -- our main update function, called every 0.033 seconds by Playdate OS.
-- function playdate.update()
--   if allImagesProcessed == false then
--     -- process images
--     for i = 1, #images do
--       -- some time-consuming process…
--       processImage( images[i] )

--       -- draw a progress bar
--       local progressPercentage = i / #images
--       playdate.graphics.fillRect( 100, 20, 200*progressPercentage, 40 )

--       -- yield to the OS, giving it a chance to update the screen
--       coroutine.yield()
--       -- execution will resume here when the OS calls coroutine.resume()
--     end

--     allImagesProcessed = true
--   else
--     -- main game update and drawing code
--   end
-- end
