

addEventHandler('onResourceStart', resourceRoot, function()
    local foodMarker = Marker(2444.38257, -1624.58240, 228.42049, 'checkpoint', 1,255, 0, 0)
    addEventHandler('onMarkerHit', foodMarker, function(hit, dim)
        if not dim then return end
        if getElementType(hit) ~= 'player' then return end
        fadeCamera(hit, false, 1)
        setTimer(function()
            hit.interior = 5
            hit.position = Vector3(372.57025, -132.25041, 1001.49219)
            setTimer(fadeCamera, 500, 1, hit, true)
        end, 1100, 1)
    end)

    local retfood = Marker(372.28293, -133.51265, 1000.55, 'cylinder', 1, 255, 0, 0)
    retfood.interior = 5
    addEventHandler('onMarkerHit', retfood, function(hit, dim)
        outputDebugString('hi')
        if not dim then return end
        if getElementType(hit) ~= 'player' then return end
        fadeCamera(hit, false, 1)
        setTimer(function()
            hit.interior = 0
            hit.position = Vector3(2444.63721, -1627.51685, 228.4)
            setTimer(fadeCamera, 500, 1, hit, true)
        end, 1100, 1)
    end)

    local retfood = Marker(369.05975, -118.99402, 1000.55, 'cylinder', 1, 0, 255, 0)
    retfood.interior = 5
    addEventHandler('onMarkerHit', retfood, function(hit, dim)
        outputDebugString('hi')
        if not dim then return end
        if getElementType(hit) ~= 'player' then return end
        setCameraMatrix(hit,   376.5530090332, -114.91120147705, 1003.2650146484, 376.56011962891, -114.19425964355, 1002.5679321289, 0, 70 )
        triggerClientEvent(hit, 'hc:pizza', hit)
    end)
end)

addEvent('hc:pizza:won', true)
addEventHandler('hc:pizza:won', root, function()
    source:setPosition(375.25470, -120.35140, 1001.49951)
    setCameraTarget(source, source)
    triggerEvent('hc:happiness:incrementH', root, 20)
end)