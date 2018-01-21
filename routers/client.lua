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


function shuffle(array)
    local n, random, j = table.getn(array), math.random
    for i=1, n do
        j,k = random(n), random(n)
        array[j],array[k] = array[k],array[j]
    end
    return array
end

function showFixScreen()
    showCursor(true)
    local Width = 0.35
    local Height = 0.50

	-- define the X and Y positions of the window
    local X = 0.30
    local Y = 0.25
	-- create the window and save its element value into the variable 'wdwLogin'
	-- click on the function's name to read its documentation
    wdwGame = guiCreateWindow(X, Y, Width, Height, "Wifi configuration tool", true)

    for i,v in pairs(shuffle(labels)) do
        if(v == "Reboot the wifi") then
            rightBtn = guiCreateButton((i -1)% 2  * 210 + 30, math.floor(i / 2) * 50 + 30,200,40, v, false, wdwGame)
        elseif (v == "Send Missile Alert Test Message") then
            alertBtn = guiCreateButton((i -1)% 2  * 210 + 30, math.floor(i / 2) * 50 + 30,200,40, v, false, wdwGame)
            addEventHandler("onClientGUIClick", alertBtn, sendAlertToTheServer, false)
        else
            fakeBtn = guiCreateButton((i -1) % 2 * 210+ 30, math.floor(i / 2) * 50 + 30,200,40, v, false, wdwGame)
        end
    end
    addEventHandler("onClientGUIClick", rightBtn, function()
        removeScreen("Wifi rebooted!")
    end, false)
end



function showWorkingScreen()
    showCursor(true)
    local Width = 0.35
    local Height = 0.20

	-- define the X and Y positions of the window
    local X = 0.30
    local Y = 0.25
	-- create the window and save its element value into the variable 'wdwLogin'
	-- click on the function's name to read its documentation
    wdwGame = guiCreateWindow(X, Y, Width, Height, "Wifi configuration tool", true)

    turnOffBtn = guiCreateButton(30, 30,200,40, "DANGER: Turn the Wifi Off", false, wdwGame)
    quitBtn = guiCreateButton(240, 30,200,40, "Close", false, wdwGame)

    addEventHandler("onClientGUIClick", turnOffBtn, function()
        removeScreen("Wifi has been turned off!")
    end, false)
    addEventHandler("onClientGUIClick", quitBtn, function()
        removeScreen("Aborted")
    end, false)
end

function removeScreen(textToPut)
    destroyElement(wdwGame)
    renderTextAndSetStartTime(textToPut)
    showCursor(false)
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
        bindKey('e', 'up', getElementByID(rID).getElementData("hc:broken") and showFixScreen or showWorkingScreen)
        routerId = rID
    else
        immediatlyRemoveText()
        bindKey('e', 'up', nil)
        routerId = 0
    end
end)




addCommandHandler("miniW", showWorkingScreen)
addCommandHandler("miniF", showFixScreen)


addEventHandler ( "onClientRender", root, renderText )