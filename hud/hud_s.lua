local messages = {}

function addMessage(msg)
    local id = createElement('hud-msg')

    table.insert(messages, {
        id = id,
        messages = {msg},
    })

    triggerClientEvent('onMessagesReceived', root, messages)

    return id
end

function removeMessage(id)
    local index = -1

    for i, v in pairs(messages) do
        outputDebugString(inspect(v))
        if v.id == id then
            id:destroy()
            index = i
            break
        end
    end

    if index == -1 then
        return
    end

    table.remove(messages, index)

    triggerClientEvent('onMessagesReceived', root, messages)
end

function setProgress(progress)
    triggerClientEvent('onProgressReceived', root, progress)
end

-- addEventHandler('onResourceStart', resourceRoot, function()
--     setTimer(function()
--        local rand = tostring(math.random() )
--        local randProgress = math.random()
--        addMessage('hello worldddddd: ' .. rand)
--        setProgress(100 * randProgress)
--     --    outputDebugString('sent!')
--     end, 1000, 5)
-- end)