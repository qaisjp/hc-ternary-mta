local rubbish = {

}
local xStart = 0
local yStart = 0
local xEnd = 0
local yEnd = 0
local z = 0

function spawnRubbish()
    local x = math.random(xStart, xEnd)
    local y = math.random(yStart, yEnd)
    createPickup(x, y ,z, 3, 2674)
end

addEventHandler('onResourceStart', resourceRoot, function()
    setTimer(function()
        spawnRubbish()
       outputDebugString('spawned rubbish!')
    end, 1000, 5)
end)