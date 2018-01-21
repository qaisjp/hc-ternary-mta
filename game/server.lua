local gamestate = {
    wifiStates = {true, true, true, true},
    wifiObjects = {},
}

-- Well Stacked Pizza Co spawnpoints
-- Interior 5
local spawnpoints = {
    {379.55991, -115.55063, 1001},
    {377.55991, -115.55063, 1001},
    {375.55991, -115.55063, 1001},
    {373.55991, -115.55063, 1001}
}

-- { 379.58090209961, -120.8191986084, 1002.2612915039, 379.58090209961, -20.819198608398, 1002.2612915039, 0, 70 }
local spawnIndex = math.random(#spawnpoints)

local skins = {29, 194, 46, 233, 250}

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

function changeSkin(player, key)
    local direction = (key == 'left') and -1 or 1
    local index = direction + player:getData('spawn-select:skin')
    if index < 1 or index > #skins then
        index = (direction == 1) and 1 or #skins
    end
    player:setData('spawn-select:skin', index)
    player.model = skins[index]
end

function toggleOverview(player)
    local mode = not player:getData('hc:overview')
    player:setData('hc:overview', mode)

    toggleAllControls(player, not mode)
    showCursor(player, mode)
    if mode then
        setCameraMatrix(player, 2388.3056640625, -1645.4122314453, 237.34294128418, 2488.1032714844, -1646.4276123047, 231.06507873535, 0, 70 )
    else
        setCameraTarget(player)
    end
end

function loadPlayer(player)
    player:setData('hc:active', true)
    bindKey(player, 'm', 'up', toggleOverview)
end

local confirmSkin
function confirmSkin(player)
    unbindKey(player, 'left', 'up', changeSkin)
    unbindKey(player, 'right', 'up', changeSkin)
    unbindKey(player, 'enter', 'up', confirmSkin)

    triggerClientEvent(player, 'hc:selectedSkin', player)
    
    player.interior = 0
    player.position = Vector3(2430, -1659, 229)

    loadPlayer(player)

    player:setData('hc:overview', false)
    toggleOverview(player)
end

addEvent('hc:onPlayerReady', true)
addEventHandler('hc:onPlayerReady', root, function()
    if source:getData('hc:active') then
        loadPlayer(source)
        return
    end

    outputChatBox('Welcome to Hackathon Simulator Cambridge.', source)

    local x, y, z = unpack(spawnpoints[spawnIndex])
    local skinIndex = math.random(#skins)
    spawnPlayer(source, x, y, z, 180, skins[skinIndex], 5)
    setCameraMatrix(source, x, y-5, z+1, x, y, z+1, 0, 70)
    -- setPedFrozen(source, true)
    toggleAllControls(source, false)
    fadeCamera(source, true)

    source:setData('spawn-select:skin', skinIndex)
    bindKey(source, "left", "up", changeSkin)
    bindKey(source, "right", "up", changeSkin)
    bindKey(source, 'enter', 'up', confirmSkin)

    triggerClientEvent(source, 'hc:selectingSkin', source)
    spawnIndex = spawnIndex + 1
    skinIndex = skinIndex + 1

    if spawnIndex >= #spawnpoints then
        spawnIndex = 1
    end

    if skinIndex >= #skins then
        skinIndex = 1
    end
end)