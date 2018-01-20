local gamestate = {
    wifiStates = {true, true, true, true},
    wifiObjects = {},
}

-- Well Stacked Pizza Co spawnpoints
-- Interior 5
local spawnpoints = {
    {379.55991, -115.55063, 1000.45},
    {376.55991, -115.55063, 1000.45},
    {373.55991, -115.55063, 1000.45}
}

-- { 379.58090209961, -120.8191986084, 1002.2612915039, 379.58090209961, -20.819198608398, 1002.2612915039, 0, 70 }
local spawnIndex = math.random(#spawnpoints)

local skins = {29, 194}
local skinIndex = math.random(#skins)

addEventHandler('onResourceStart', resourceRoot, function()
    -- Load wifiObjects
    for i=1, 4 do
        local wifi = getElementByID("router" .. tostring(i))
        if not wifi then
            return outputDebugString('Could not find router' .. tostring(i))
        end

        gamestate.wifiObjects[i] = wifi
    end
end)

addEvent('hc:onPlayerReady', true)
addEventHandler('hc:onPlayerReady', root, function()
    outputChatBox('Welcome to Hackathon Simulator Cambridge.', source)

    local x, y, z = unpack(spawnpoints[spawnIndex])
    spawnPlayer(source, x, y, z, 180, skins[skinIndex], 5)
    setCameraMatrix(source, x, y-5, z+2, x, y, z+2, 0, 70)
    fadeCamera(source, true)

    spawnIndex = spawnIndex + 1
    skinIndex = skinIndex + 1

    if spawnIndex >= #spawnpoints then
        spawnIndex = 1
    end

    if skinIndex >= #skins then
        skinIndex = 1
    end
end)