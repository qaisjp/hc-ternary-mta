local text = ""
local labels = {
    "Send Missile Alert Test Message",
    "Reboot the wifi",
    "Download Minecraft",
    "Reboot firewall",
    "Flush DNS",
    "Do you know the way?",
    "Initialize wifi protection",
    "Rotate keys",
    "Download new firmware",
    "Ban users",
    "Destroy certificates",
    "Reboot the malware protection",
    "Add a Bictoin node"
}
local startTime = 0
local startTimeAlert = 0
local routerId = 0
local hasAScreen = false


function shuffle(array)
    local n, random, j = table.getn(array), math.random
    for i=1, n do
        j,k = random(n), random(n)
        array[j],array[k] = array[k],array[j]
    end
    return array
end

function showFixScreen()
    if(hasAScreen == false) then
        showCursor(true)
        local Width = 0.35
        local Height = 0.50

	    -- define the X and Y positions of the window
        local X = 0.30
        local Y = 0.25
	    -- create the window and save its element value into the variable 'wdwLogin'
	    -- click on the function's name to read its documentation
        local window = guiCreateWindow(X, Y, Width, Height, "Wifi configuration tool", true)
        local rightBtn
        for i,v in pairs(shuffle(labels)) do
            if(v == "Reboot the wifi") then
                rightBtn = guiCreateButton((i -1)% 2  * 210 + 30, math.floor(i / 2) * 50 + 30,200,40, v, false, window)
            elseif (v == "Send Missile Alert Test Message") then
                local alertBtn = guiCreateButton((i -1)% 2  * 210 + 30, math.floor(i / 2) * 50 + 30,200,40, v, false, window)
                addEventHandler("onClientGUIClick", alertBtn, sendAlertToTheServer, false)
            else
                local fakeBtn = guiCreateButton((i -1) % 2 * 210+ 30, math.floor(i / 2) * 50 + 30,200,40, v, false, window)
            end
        end
        addEventHandler("onClientGUIClick", rightBtn, function()
            removeScreen("Wifi rebooted!",window)
            local router = getElementByID("router" .. tostring(routerId))
            local broken = setElementData(router, "hc:broken", false)
            triggerServerEvent('hc:del-marker', router)
        end, false)
        hasAScreen = true
    end
end



function showWorkingScreen()
    if(hasAScreen == false) then
        showCursor(true)
        local Width = 0.35
        local Height = 0.20

	    -- define the X and Y positions of the window
        local X = 0.30
        local Y = 0.25
	    -- create the window and save its element value into the variable 'wdwLogin'
        -- click on the function's name to read its documentation
        local window = guiCreateWindow(X, Y, Width, Height, "Wifi configuration tool", true)

        local turnOffBtn = guiCreateButton(30, 30,200,40, "DANGER: Turn the Wifi Off", false, window)
        local quitBtn = guiCreateButton(240, 30,200,40, "Close", false, window)

        addEventHandler("onClientGUIClick", turnOffBtn, function()
            outputDebugString("clicked")
            removeScreen("Wifi has been turned off!", window)
            local router = getElementByID("router" .. tostring(routerId))
            local broken = setElementData(router, "hc:broken", true)
            triggerServerEvent('hc:create-marker', router)
        end, false)
        addEventHandler("onClientGUIClick", quitBtn, function()
            outputDebugString("clicked")
            removeScreen("Aborted", window)
        end, false)
        hasAScreen = true
    end
end

function removeScreen(textToPut, window)
    destroyElement(window)
    renderTextAndSetStartTime(textToPut)
    showCursor(false)
    hasAScreen = false
end

local screenX,screenY = guiGetScreenSize()

function sendAlertToTheServer()
    triggerServerEvent ( "onHawaiiAlertSent", resourceRoot)
end






function showAlert()
    startTimeAlert = getTickCount()
end


function renderText()
	
	
	currentCount = getTickCount ()
    
    if(currentCount < startTime + 3000) then
        dxDrawRectangle (screenX *.40, screenY * .09, 400, 50, tocolor(0,0,0,150))
        dxDrawText ( text, screenX * .41, screenY * .1, screenX, screenY, tocolor(255,255,255), 2)
    end
    
    if(currentCount < startTimeAlert + 10000) then
        dxDrawImage ( screenX * .35, screenY * .1, 368, 159, 'hawaii.jpg', angle, 0, 0 )
    end

end

function renderTextAndSetStartTime(textToRender)
    text = textToRender
    startTime = getTickCount()
end

function immediatlyRemoveText()
    startTime = 0
end



addEvent('onHawaiiAlertReceived', true)
addEventHandler('onHawaiiAlertReceived', root, showAlert)


addEvent('renderMessageForRouter', true)
addEventHandler('renderMessageForRouter', root, function(shouldShow, rID)
    if(shouldShow) then
        renderTextAndSetStartTime("Press E to interact with the Router")
        local router = getElementByID("router" .. tostring(rID))
        local broken = getElementData(router, "hc:broken")
        bindKey('e', 'up', 
        function()
            if(broken) then
                return showFixScreen()
            else 
                return showWorkingScreen()
            end
        end)
        routerId = rID
    else
        immediatlyRemoveText()
        --removeScreen("Aborted")
        unbindKey('e')
        routerId = 0
    end
end)




addCommandHandler("miniW", showWorkingScreen)
addCommandHandler("miniF", showFixScreen)


addEventHandler ( "onClientRender", root, renderText )