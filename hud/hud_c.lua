local messages = {
   
}

local margin = 0.01
local lastY = 0
local hasSatisfactionBeenChanged = true

-- function addMessage(_, ...)
--     local str = table.concat({...}, " ")
--     list[#list] = str
-- end

-- addCommandHandler("add", addMessage)


function onMessagesReceived(list)
    for _, msg in ipairs(messages) do
        destroyElement(msg.window)
    end
    messages = list
    
    lastY = margin
    for i, msg in ipairs(messages) do
        -- outputDebugString('creating msg ' .. msg.id)
        createNotificationWindow(i, msg)
    end
end

function onProgressReceived(progress)
    -- outputDebugString('changing progress ' .. tostring(progress))
    local image = ""
    if(progress > 80) then
        image = "happy.png"
    elseif(progress > 60) then
        image = "happy_neutral.png"
    elseif(progress > 40) then
        image = "real_neutral.png"
    else
        image = "sad.png"
    end
    guiStaticImageLoadImage(emotionImage, image)
    guiProgressBarSetProgress(progressBar, progress)
end

addEvent('onMessagesReceived', true)
addEventHandler('onMessagesReceived', root, onMessagesReceived)

addEvent('onProgressReceived', true)
addEventHandler('onProgressReceived', root, onProgressReceived)


-- function onRender()
--     if hasSatisfactionBeenChanged then
--         if ( progressBar ) then
--             -- set the progress
--             guiProgressBarSetProgress(progressBar, 80)
--                 -- get the progress
--             progress = guiProgressBarGetProgress(progressBar)
--             -- output to the chatbox
--             outputChatBox ( "Current progress:" .. progress .. "%" )
--         else --if the progressbar was not found
--             outputChatBox ("progressbar not found!")
--                -- output a message
--         end
--         hasSatisfactionBeenChanged = false
--     end
-- end
-- addEventHandler('onClientRender', root, onRender)

function createNotificationWindow(index, message)
    local Width = 0.25
    local Height = #message.messages * 0.04 + 0.03

	-- define the X and Y positions of the window
    local X = 1 - Width - margin
    local Y = lastY
    lastY = lastY + Height + margin
	-- define the width and height of the window
	
	-- create the window and save its element value into the variable 'wdwLogin'
	-- click on the function's name to read its documentation
    wdwSlack = guiCreateWindow(X, Y, Width, Height, "Slack Notification", true)
    message.window = wdwSlack
    --scrollpane = guiCreateScrollPane(0,0,1,1,true,wdwSlack)
    	-- delete all the existing labels
	--for i,v in ipairs(getElementChildren(scrollpane)) do
	--	destroyElement(v)
	--end

    -- for every player in the server
    local i = 0
    for k,v in pairs(message.messages) do
        -- create a label with their name on the scrollpane
        guiCreateStaticImage(15, i * 20  + 20, 20, 20, "slack.png", false, wdwSlack )
        guiCreateLabel(40,i * 20  + 20,300,20,v,false,wdwSlack)
        i =  i + 1
    end
end

function createSatisfactionProgressBar()
    progressBar = guiCreateProgressBar( margin + 0.1, margin + 0.05, 0.4, 0.03, true, nil ) --create the gui-progressbar
    emotionImage = guiCreateStaticImage(0, 0, 0.1, 0.2, "sad.png", true, nil )
end


function hideHud()
    setPlayerHudComponentVisible ("clock" , false )
    setPlayerHudComponentVisible ("money" , false )
    setPlayerHudComponentVisible ("health" , false )
    setPlayerHudComponentVisible ("weapon" , false )
    setPlayerHudComponentVisible ("radar" , false )
    showChat(false)
end


function onResourceStart()
    hideHud()
    createSatisfactionProgressBar()
end

addEventHandler("onClientResourceStart", resourceRoot, onResourceStart)