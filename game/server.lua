local gamestate = {
    wifiStates = {true, true, true, true},
    wifiObjects = {},
}

addEventHandler('onResourceStart', resourceRoot, function()
    -- Load wifiObjects
    for i=1, 4 do
        local wifi = getElementByID("router" .. tostring(i))
        if not wifi then
            return outputDebugString('Could not find router' .. tostring(i))
        end

        wifiObjects[i] = wifi
    end
end)

addEvent('hc:onPlayerReady', true)
addEventHandler('hc:onPlayerReady', root, function()
    outputChatBox('Welcome to Hackathon Simulator Cambridge.', source)
end)