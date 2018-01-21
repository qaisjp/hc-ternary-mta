addEventHandler('onResourceStart', resourceRoot, function()
    pos = router1.position
    sphere1 = createColSphere ( pos, 3 )

    local spheres = {
        sphere1,
    }

    for _, sphere in ipairs(spheres) do    
        addEventHandler ( "onColShapeHit", sphere, collisionHandler)
        addEventHandler ( "onColShapeLeave", sphere, leaveHandler)
    end
end)

