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

function shuffle(array)
    local n, random, j = table.getn(array), math.random
    for i=1, n do
        j,k = random(n), random(n)
        array[j],array[k] = array[k],array[j]
    end
    return array
end

function showScreen()
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
    addEventHandler("onClientGUIClick", rightBtn, removeScreen, false)
end

function removeScreen()
    destroyElement(wdwGame)
    startTime = getTickCount()
    text = "Rebooted the wifi!"
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
    
    if(currentCount < startTime + 5000) then
        dxDrawRectangle (screenX *.40, screenY * .09, 250, 50, tocolor(0,0,0,150))
        dxDrawText ( text, screenX * .41, screenY * .1, screenX, screenY, tocolor(255,255,255), 2)
    end
    
    if(currentCount < startTimeAlert + 10000) then
        dxDrawImage ( screenX * .35, screenY * .1, 368, 159, 'hawaii.jpg', angle, 0, 0 )
    end

end


addEvent('onHawaiiAlertReceived', true)
addEventHandler('onHawaiiAlertReceived', root, showAlert)

addEventHandler ( "onClientRender", root, renderText )
addCommandHandler("mini", showScreen)
