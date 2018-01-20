modified_skins = {
    [29] = 'wmydrug.txd',
    [194] = 'crogrl3.txd'
}

function onStart()
    outputDebugString("Loading skins..")

    for k, v in modified_skins do
        local txd = engineLoadTXD(v)
        local success = engineImportTXD(txd, k)
        if not success then
            outputDebugString("Importing ID " .. tostring(k) .. " failed")
        end

    end


    -- local filename = 'crogrl3.txd'
    -- local id = 194
    -- local txd = engineLoadTXD(filename)
    -- if not engineImportTXD(txd, id) then
    --     outputDebugString("Importing ID " .. tostring(id) .. " failed")
    -- end
end

addEventHandler('onClientResourceStart', resourceRoot, onStart)