modified_skins = {
    [29] = 'wmydrug.txd',
    [194] = 'crogrl3.txd'
}

function onStart()
    outputDebugString("Loading skins..")

    for k, v in pairs(modified_skins) do
        local txd = engineLoadTXD(v)
            outputDebugString('Could not load txd for ' ..)
        local success = engineImportTXD(txd, k)
        if not success then
            outputDebugString("Importing ID " .. tostring(k) .. " failed")
        end
    end

end

addEventHandler('onClientResourceStart', resourceRoot, onStart)