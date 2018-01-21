addEventHandler('onClientResourceStart', resourceRoot, function()
    triggerServerEvent('hc:onPlayerReady', localPlayer)
end)

local txtCS

addEvent('hc:selectingSkin', true)
addEventHandler('hc:selectingSkin', root, function()
    local Width = 0.35
    local Height = 0.20

    -- define the X and Y positions of the window
    local X = 0.30
    local Y = 0.25
    -- create the window and save its element value into the variable 'wdwLogin'
    -- click on the function's name to read its documentation
    -- wdwCS = guiCreateWindow(X, Y, Width, Height, "Choose your organizer!", true)
    txtCS = guiCreateLabel(0, 0.8, 1, 0.6, "Press the left/right arrow keys to change your skin.", true)
    txtCS:setHorizontalAlign('center')
end)

addEvent('hc:selectedSkin', true)
addEventHandler('hc:selectedSkin', root, function()
    destroyElement(txtCS)
end)