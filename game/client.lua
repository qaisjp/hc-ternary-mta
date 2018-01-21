local state ='skin'
addEventHandler('onClientResourceStart', resourceRoot, function()
    triggerServerEvent('hc:onPlayerReady', localPlayer)
    if localPlayer:getData('hc:overview') then
        state = 'pause'
    end

    addEventHandler('onClientRender', root, onRender)
end)

local sw, sh = guiGetScreenSize()
function onRender()
    if state == 'skin' then
        dxDrawText(
            "Press the left/right arrow keys to change your skin.",
            0, sh * .8, sw, sh,
            tocolor(255, 255, 255, 255), 2,
            'default', 'center', 'top'
        )
    elseif state == 'pause' and localPlayer:getData('hc:overview') then
        dxDrawText(
            "Press M to toggle this screen.\n Go to the red checkpoint to make pizza. This is how you get points."..
            "\n\nMake sure you pick up the bin bags. Hackers don't like a messy venue, and you'll lose points."..
            "\n\nIf an organiser (accidentally) breaks the WiFi, you need to find and reboot it.",
            0, sh * .1, sw, sh,
            tocolor(255, 255, 255, 255), 2,
            'default', 'center', 'top'
        )
    end
end

addEvent('hc:selectingSkin', true)
addEventHandler('hc:selectingSkin', localPlayer, function()
    -- local Width = 0.35
    -- local Height = 0.20

    -- -- define the X and Y positions of the window
    -- local X = 0.30
    -- local Y = 0.25
    -- -- create the window and save its element value into the variable 'wdwLogin'
    -- -- click on the function's name to read its documentation
    -- -- wdwCS = guiCreateWindow(X, Y, Width, Height, "Choose your organizer!", true)
    -- txtCS = guiCreateLabel(0, 0.8, 1, 0.6, , true)
    -- txtCS:setHorizontalAlign('center')

    -- addEventHandler('onClientRender', root, onRender)
end)

addEvent('hc:selectedSkin', true)
addEventHandler('hc:selectedSkin', localPlayer, function()
    state = 'pause'
    -- removeEventHandler('onClientRender', root, onRender)
end)