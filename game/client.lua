addEventHandler('onClientResourceStart', resourceRoot, function()
    triggerServerEvent('hc:onPlayerReady', localPlayer)
end)