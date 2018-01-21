addEventHandler('onClientResourceStart', resourceRoot, function()
    -- Cause massive lag by maxing out draw distance of all objects
    for i, v in ipairs(getElementsByType("object")) do
        local model = getElementModel(v)
        engineSetModelLODDistance(model, 300)   -- Set maximum draw distance
    end

    for _, ped in ipairs(getElementsByType('ped')) do
        setPedVoice(ped, 'PED_TYPE_DISABLED', 'PED_TYPE_DISABLED')
        if ped:getData('hc:sit_loop') then
            setTimer(setPedAnimation, 50, 1, ped, 'food', 'ff_sit_loop', -1, true, false, false, false)
        end
    end

    for _, player in ipairs(getElementsByType('player')) do
        setPedVoice(player, 'PED_TYPE_DISABLED', 'PED_TYPE_DISABLED')
    end
end)


function handleDisplay()
	local peds = getElementsByType('ped')
    for i,v in ipairs(peds) do
        if isElement(v) then
            local text = getElementData(v, 'hc:text')
            if type(text) == 'string' then
                local camPosXl, camPosYl, camPosZl = getPedBonePosition (v, 6)
                local camPosXr, camPosYr, camPosZr = getPedBonePosition (v, 7)
                local x,y,z = (camPosXl + camPosXr) / 2, (camPosYl + camPosYr) / 2, (camPosZl + camPosZr) / 2
                --local posx,posy = getScreenFromWorldPosition(x,y,z+0.25)
                local cx,cy,cz = getCameraMatrix()
                local px,py,pz = getElementPosition(v)
                local distance = getDistanceBetweenPoints3D(cx,cy,cz,px,py,pz)
                local posx,posy = getScreenFromWorldPosition(x,y,z+0.020*distance+0.10)
                local elementtoignore1 = getPedOccupiedVehicle(getLocalPlayer()) or getLocalPlayer()
                local elementtoignore2 = getPedOccupiedVehicle(v) or v
                if posx and distance <= 45 and ( isLineOfSightClear(cx,cy,cz,px,py,pz,true,true,false,true,false,true,true,elementtoignore1) or isLineOfSightClear(cx,cy,cz,px,py,pz,true,true,false,true,false,true,true,elementtoignore2) ) and ( not maxbubbles or  0 < maxbubbles ) then -- change this when multiple ignored elements can be specified
                    local width = dxGetTextWidth(text,1,"default")
                    
                    dxDrawRectangle(posx - (3 + (0.5 * width)),posy - (2 + (0 * 20)),width + 5,19,tocolor(0,0,0,255))
                    dxDrawRectangle(posx - (6 + (0.5 * width)),posy - (2 + (0 * 20)),width + 11,19,tocolor(0,0,0,40))
                    dxDrawRectangle(posx - (8 + (0.5 * width)),posy - (1 + (0 * 20)),width + 15,17,tocolor(0,0,0,255))
                    dxDrawRectangle(posx - (10 + (0.5 * width)),posy - (1 + (0 * 20)),width + 19,17,tocolor(0,0,0,40))
                    dxDrawRectangle(posx - (10 + (0.5 * width)),posy - (0 * 20) + 1,width + 19,13,tocolor(0,0,0,255))
                    dxDrawRectangle(posx - (12 + (0.5 * width)),posy - (0 * 20) + 1,width + 23,13,tocolor(0,0,0,40))
                    dxDrawRectangle(posx - (12 + (0.5 * width)),posy - (0 * 20) + 4,width + 23,7,tocolor(0,0,0,255))
                    
                    local r,g,b = 255,255,255
                    
                    
                    dxDrawText(text,posx - (0.5 * width),posy - (0 * 20),posx - (0.5 * width),posy - (0 * 20),tocolor(r,g,b,255),1,"default","left","top",false,false,false)
                end
            end
        end
    end
end

addEventHandler('onClientRender', root, handleDisplay)