local rubbish = {

}
local xStart = 2410.84326
local yStart = -1628.72656
local xEnd = 2451.45044
local yEnd = -1665.77454
local z = 228.42049

function spawnRubbish()
    local x = math.random(xStart, xEnd)
    local y = math.random(yStart, yEnd)
    createPickup(x, y ,z, 3, 2674)
end
-- {2451.45044, -1628.72656, 228.42049}
--  {2410.84326, -1665.77454, 228.42049}
addEventHandler('onResourceStart', resourceRoot, function()
    setTimer(function()
        spawnRubbish()
       outputDebugString('spawned rubbish!')
    end, 1000, 5)
end)