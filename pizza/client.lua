
function table.shallow_copy(t)
    local t2 = {}
    for k,v in pairs(t) do
      t2[k] = v
    end
    return t2
end


function shuffle(array)
    local n, random, j = table.getn(array), math.random
    for i=1, n do
        j,k = random(n), random(n)
        array[j],array[k] = array[k],array[j]
    end
    return array
end

function merge(t1, t2)
    for k, v in pairs(t2) do
        if (type(v) == "table") and (type(t1[k] or false) == "table") then
            merge(t1[k], t2[k])
        else
            t1[k] = v
        end
    end
    return t1
end
local firstImage = nil
local firstIndex = nil
local firstName = nil
local secondName = nil
local oldSource = nil
local pairFound = 0

function TableConcat(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end


local firstRow = {
    {
        name="cheese",
        image="pizza-box-cheese.png"
    },
    {
        name="pepperoni",
        image="pizza-box-pepperoni.png"
    },
    {
        name="meatball",
        image="pizza-box-meatballs.png"
    },
    {
        name="ham",
        image="pizza-box-ham.png"
    },
}

local secondRow = table.shallow_copy(firstRow)




function renderWindow()
    showCursor(true)
    local margin = 0.01
    local Width = 0.5
    local Height = 0.5

	-- define the X and Y positions of the window
    local X = 0.25
    local Y = 0.25
	-- define the width and height of the window
	
	-- create the window and save its element value into the variable 'wdwLogin'
	-- click on the function's name to read its documentation
    wdwPizza = guiCreateWindow(X, Y, Width, Height, "Find the pizza quickly the hackers are hungry!!:", true)

    firstRow = shuffle(firstRow)
    secondRow = shuffle(secondRow)

    local pizzas = TableConcat(firstRow, secondRow)

    for i,v in pairs(pizzas) do
        
        -- create a label with their name on the scrollpane
        local img = guiCreateStaticImage(((i - 1) % 4) * 0.25,  (math.floor((i - 1) / 4)) * 0.25 + 0.2 , 0.2, 0.2, "pizza-box.png", true, wdwPizza)
        setElementData(img, "hc:object", v)
        setElementData(img, "hc:index", i)
        --guiCreateStaticImage(0.1, 0.1 , 0.3, 0.3, "slack.png", true, wdwPizza)
        addEventHandler("onClientGUIClick", img, handleClick, false)
    end
end

function handleClick()
    local v = getElementData(source, "hc:object")
    local i = getElementData(source, "hc:index")
    outputDebugString("clicked " .. v["name"])
    if secondName then
        return
    end
    if(not firstName) then
        firstName = v["name"]
        firstImage = source
        firstIndex = i
        guiStaticImageLoadImage(source, v["image"])
    else
        if(i == firstIndex)then
            return
        else
            secondName = v["name"]
            guiStaticImageLoadImage(source, v["image"])
            if (firstName == secondName)then
                outputDebugString("won")
                firstName = nil
                secondName = nil
                removeEventHandler("onClientGUIClick", firstImage, handleClick)
                removeEventHandler("onClientGUIClick", source, handleClick)

                pairFound = pairFound + 1
                    if(pairFound == 4)then
                        destroyElement(wdwPizza)
                        showCursor(false)
                        firstRow = {
                            {
                                name="cheese",
                                image="pizza-box-cheese.png"
                            },
                            {
                                name="pepperoni",
                                image="pizza-box-pepperoni.png"
                            },
                            {
                                name="meatball",
                                image="pizza-box-meatballs.png"
                            },
                            {
                                name="ham",
                                image="pizza-box-ham.png"
                            },
                        }
                        firstName = nil
                    firstImage = nil
                    firstIndex = nil
                    secondName = nil
                    oldSource = nil
                    pairFound = 0
                    triggerServerEvent('hc:pizza:won', localPlayer)
                end
            else
                outputDebugString("lost")
                oldSource = source
                setTimer(function()
                    guiStaticImageLoadImage(firstImage,"pizza-box.png")
                    guiStaticImageLoadImage(oldSource, "pizza-box.png")
                    firstName = nil
                    firstImage = nil
                    firstIndex = nil
                    secondName = nil
                    oldSource = nil
                    
                end, 1000, 1)
            end
        end
    end
end


addEvent("hc:pizza", true)
addEventHandler('hc:pizza', root, function()
    renderWindow()
end)

addCommandHandler("pizza", renderWindow)

addEventHandler('onClientResourceStart', resourceRoot, function()
    local s = playSound3D('pizzatron.mp3', 375.82816, -115.50784, 1001.49219, true)
    s.maxDistance = 15
end)