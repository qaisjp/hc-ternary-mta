local rubbish = {

}
local activeRubbish = 0

treshold = 7

local xStart = 2410.84326
local yStart = 1628.72656
local xEnd = 2451.45044
local yEnd = 1665.77454
local z = 228.42049

function spawnRubbish()
    local x = math.random(xStart, xEnd)
    local y = -math.random(yStart, yEnd)
    local pickup = createPickup(x, y ,z, 3, 2674, 5000)
    outputDebugString("Rubbish inital spawn")
    if(activeRubbish >= treshold) then
        outputDebugString("Rubbish is bad" .. tostring(activeRubbish))
    end
    activeRubbish = activeRubbish + 1
    table.insert(rubbish, pickup)
end
-- {2451.45044, -1628.72656, 228.42049}
--  {2410.84326, -1665.77454, 228.42049}
addEventHandler('onResourceStart', resourceRoot, function()
    for i = 1,10 do
        setTimer(spawnRubbish, math.random(3,10) * 1000, 1)
    end
    
end)

addEventHandler('onPlayerPickupHit', resourceRoot, function()
    activeRubbish = activeRubbish - 1
    outputDebugString("Rubbish reduced" .. tostring(activeRubbish))
    if(activeRubbish < treshold) then
        outputDebugString("Rubbish is okay" .. tostring(activeRubbish))
    end
end)
addEventHandler ( "onPickupSpawn", resourceRoot, function()
    outputDebugString("Rubbish spawn")
    activeRubbish = activeRubbish + 1
    if(activeRubbish >= treshold) then
        outputDebugString("Rubbish is bad" .. tostring(activeRubbish))
    end
end)