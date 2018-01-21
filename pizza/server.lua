addEventHandler('onResourceStart', resourceRoot, function()
    pos = Vector3(369.05975, -118.99402, 1000.55)
    sphere1 = createColSphere ( pos, 3 )

    local spheres = {
        sphere1,
    }

    for _, sphere in ipairs(spheres) do    
        addEventHandler ( "onColShapeHit", sphere, collisionHandler)
        addEventHandler ( "onColShapeLeave", sphere, leaveHandler)
    end
end)

