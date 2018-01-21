addEventHandler('onClientResourceStart', resourceRoot, function()
    -- Cause massive lag by maxing out draw distance of all objects
    for i, v in ipairs(getElementsByType("object")) do
        local model = getElementModel(v)
        engineSetModelLODDistance(model, 300)   -- Set maximum draw distance
    end

    for _, ped in ipairs(getElementsByType('ped', getResourceDynamicElementRoot(thisResource))) do
        setPedSkin(ped, 46)
        setTimer(setPedAnimation, 50, 1, ped, 'food', 'ff_sit_loop', -1, true, false, false, false)
    end
end)

