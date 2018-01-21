local physTables = {}

function randomModel()
    local ids = {46, 194, 233, 250, 116, 29}
    return(ids[math.random(#ids)])
end

function startPedgen()
    outputDebugString('Starting pedgen...')

    local map = getResourceFromName('map')
    local mapRoot = getResourceMapRootElement(map, 'something.map')
    for tIndex, ele in pairs(mapRoot.children) do
        if ele.model == 18059 then
            -- tables = tables + 1
            -- outputDebugString('i')
            -- ele.alpha = 0
            table.insert(physTables, {table = ele})

            local offsets = {
                Vector3(0, 0, 0),
                ele.matrix.right * 3.12,
                ele.matrix.right * 3.12 * 2,
                -ele.matrix.right * 3.12,
                -ele.matrix.right * 3.12 * 2,
            }

            

            for _, offset in ipairs(offsets) do
                local mat = ele.matrix
                mat:setPosition(ele.position + offset)

                local shouldBeComputered = math.random(10)
                if shouldBeComputered < 6 then

                    local pos = mat.position
                    local rand1 = math.random(0, 2)
                    local rand1_1 = math.random(0, 1)
                    local rand2 = math.random(0, 2)
                    local rand2_1 = math.random(0, 1)
                    for i=rand1_1, rand1 do
                        local ped = Ped(0, pos+mat.right*.1 + mat.right*.8 + mat.up*.1 - mat.forward*.8 + mat.forward*i*.8)
                        ped:setData('hc:sit_loop', true, true)
                        ped.frozen = true
                        ped.model = randomModel()
                        setTimer(setPedAnimation, 50, 1, ped, 'food', 'ff_sit_loop', -1, true, false, false, false)
                    end

                    for i=rand2_1, rand2 do
                        local ped = Ped(0, pos+mat.right*.1 - mat.right*.8 + mat.up*.1 - mat.forward*.8 + mat.forward*i*.8)
                        ped:setData('hc:sit_loop', true, true)
                        ped.frozen = true
                        ped.model = randomModel()
                        ped.rotation = Vector3(0, 0, 180)
                        setTimer(setPedAnimation, 50, 1, ped, 'food', 'ff_sit_loop', -1, true, false, false, false)
                    end

                    -- left set of chairs
                    local chair = Object(1721, pos + mat.right - mat.up*.4)
                    local chair = Object(1721, pos + mat.right - mat.up*.4 + mat.forward*.8)
                    local chair = Object(1721, pos + mat.right - mat.up*.4 - mat.forward*.8)
                    -- right set of chairs
                    local chair = Object(1721, pos - mat.right - mat.up*.4, 0, 0, 180)
                    local chair = Object(1721, pos - mat.right - mat.up*.4 + mat.forward*.8, 0, 0, 180)
                    local chair = Object(1721, pos - mat.right - mat.up*.4 - mat.forward*.8, 0, 0, 180)

                    -- pcs! (forward: offset towards long side) (up: height) (right: near edge of table facing player)
                    Object(2190, pos + mat.right*.1 + mat.up*.4 + mat.forward*.2)
                    Object(2190, pos + mat.right*.1 + mat.up*.4 - mat.forward*.55)
                    Object(2190, pos + mat.right*.1 + mat.up*.4 + mat.forward)

                    -- pcs! but on the other side
                    local forwardReadjust = mat.forward * .43
                    Object(2190, pos - mat.right*.1 + mat.up*.4 + mat.forward*.2 - forwardReadjust, 0, 0, 180)
                    Object(2190, pos - mat.right*.1 + mat.up*.4 - mat.forward*.55 - forwardReadjust, 0, 0, 180)
                    Object(2190, pos - mat.right*.1 + mat.up*.4 + mat.forward - forwardReadjust, 0, 0, 180)
                end
            end
        else
            -- setTimer(function()
            -- outputDebugString(ele.model)
            -- ele.position = ele.position + Vector3(0, 0, .5)
            -- end, i * 500, 1)
        end        
    end
    -- outputDebugString("There are " .. tostring(tables) .. " tables")

    
end

addCommandHandler("tryOffset", function()
    -- local 

end)

local checkPedgen
function checkPedgen(res)
    if res.name == 'map' then
        removeEventHandler('onResourceStart', root, checkPedgen)
        startPedgen()
    end
end

addEventHandler('onResourceStart', resourceRoot, function()
    local map = getResourceFromName('map')
    if not map then
        outputDebugString('pedgen: Could not find map resource.')
        return
    end

    if map.state ~= 'running' then
        if map.state ~= 'loaded' then
            outputDebugString('pedgen: unable to start map')
            return
        end
        outputDebugString('pedgen: starting map')
        addEventHandler('onResourceStart', root, checkPedgen)
        map:start(true)
    else
        startPedgen()
    end
end)