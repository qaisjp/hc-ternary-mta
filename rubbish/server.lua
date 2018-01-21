local rubbish = {

}
local activeRubbish = 0
local notice = nil
local bigThreshold = 13
local minorThreshold = 8

local xStart = 2410.84326
local yStart = 1628.72656
local xEnd = 2451.45044
local yEnd = 1665.77454
local z = 228

local happInc = 0
function setHappIncr(target)
    if target == happInc then
        return 0
    end

    local diff = target-happInc
    happInc = happInc + diff
    return diff
end

function updateHappiness()
    local targ = 0
    if(activeRubbish >= bigThreshold) then
        outputDebugString("Rubbish is bad" .. tostring(activeRubbish))
        targ = -0.125
        if not notice then
           notice = exports.hud:addMessage("People aren't happy with the mess.")
        end 
    elseif activeRubbish >= minorThreshold then
        targ = 0
        if notice then
            exports.hud:removeMessage(notice)
            notice = nil
        end
    elseif activeRubbish <= 5 then
        targ = 1
        if notice then
            exports.hud:removeMessage(notice)
            notice = nil
        end
    end

    local change = setHappIncr(targ)
    outputDebugString('moving it by '..tostring(change))
    triggerEvent('hc:happiness:incrementMultiplier', root, change)
end

function spawnRubbish()
    local x = math.random(xStart, xEnd)
    local y = -math.random(yStart, yEnd)
    local pickup = createPickup(x, y ,z, 3, 1264, math.random(10, 45)*1000)
    outputDebugString("Rubbish inital spawn")
    activeRubbish = activeRubbish + 1
    updateHappiness()
    table.insert(rubbish, pickup)
end
-- {2451.45044, -1628.72656, 228.42049}
--  {2410.84326, -1665.77454, 228.42049}
addEventHandler('onResourceStart', resourceRoot, function()
    for i = 1,15 do
        setTimer(spawnRubbish, math.random(5,45) * 1000, 1)
    end
    
end)

addEventHandler('onResourceStop', resourceRoot, function()
    local change = setHappIncr(0)
    -- outputDebugString('moving it by '..tostring(change))
    triggerEvent('hc:happiness:incrementMultiplier', root, change)
    
end)


addEventHandler('onPlayerPickupHit', root, function()
    activeRubbish = activeRubbish - 1
    outputDebugString("Rubbish reduced" .. tostring(activeRubbish))
    updateHappiness()
end)

addEventHandler ( "onPickupSpawn", resourceRoot, function()
    outputDebugString("Rubbish spawn")
    activeRubbish = activeRubbish + 1
    updateHappiness()
end)