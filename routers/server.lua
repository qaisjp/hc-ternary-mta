local router1 = nil
local router2 = nil
local router3 = nil
local router4 = nil
local sphere1 = nil
local sphere2 = nil
local sphere3 = nil
local sphere4 = nil

function sendHawaiiAlertToAllClient()
    triggerClientEvent('onHawaiiAlertReceived', root)
end

addEvent( "onHawaiiAlertSent", true )
addEventHandler( "onHawaiiAlertSent", resourceRoot, sendHawaiiAlertToAllClient )

addEventHandler('onResourceStart', resourceRoot, function()
    router1 = getElementByID("router1")
    setElementData(router1, "hc:broken", false, true)
    router2 = getElementByID("router2")
    setElementData(router1, "hc:broken", false, true)
    router3 = getElementByID("router3")
    setElementData(router1, "hc:broken", true, true)
    router4 = getElementByID("router4")
    setElementData(router1, "hc:broken", true, true)
    local pos = nil

    pos = router1.position
    sphere1 = createColSphere ( pos, 3 )
    sphere1:setData("hc:routerId", 1)

    pos = router2.position
    sphere2 = createColSphere ( pos, 3 )
    sphere2:setData("hc:routerId", 2)

    pos = router3.position
    sphere3 = createColSphere ( pos, 3 )
    sphere3:setData("hc:routerId", 3)

    
    pos = router4.position
    sphere4 = createColSphere ( pos, 3 )
    sphere4:setData("hc:routerId", 4)

    local spheres = {
        sphere1,
        sphere2,
        sphere3,
        sphere4
    }

    for _, sphere in ipairs(spheres) do    
        addEventHandler ( "onColShapeHit", sphere, collisionHandler)
        addEventHandler ( "onColShapeLeave", sphere, leaveHandler)
    end
end)

function collisionHandler(thePlayer, _)
    outputDebugString("Hitted")
    local id = source:getData("hc:routerId")
    if getElementType ( thePlayer ) == "player" then
        triggerClientEvent(thePlayer, "renderMessageForRouter", root, true, id)
    end
end

function leaveHandler(thePlayer,_)
    local id = source:getData("hc:routerId")
    if getElementType ( thePlayer ) == "player" then
        triggerClientEvent(thePlayer, "renderMessageForRouter", root, false, id)
    end
end

