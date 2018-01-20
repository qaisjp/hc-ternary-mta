addEventHandler('onClientResourceStart', resourceRoot, function()
    triggerServerEvent('onPlayerReady', localPlayer)
end)