local gamestate = {
    wifiStates = {true, true, true, true},
    wifiObjects = {},
}

local spawnpoints = {
    {2460.83496, -1635.53442, 200.08281},
    {2459.38159, -1635.71252, 200.08281},
    {2457.32324, -1636.10168, 200.08281},
    {2454.28906, -1636.53101, 200.09010}
}
local spawnIndex = 1

local skins = {29, 194}
local skinIndex = 1

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
    spawnPlayer(source, spawnpoints[spawnIndex], 180, skins[skinIndex])

    spawnIndex = spawnIndex + 1
    skinIndex = skinIndex + 1

    if spawnIndex >= #spawnpoints then
        spawnIndex = 1
    end

    if skinIndex >= #skins then
        skinIndex = 1
    end
end)