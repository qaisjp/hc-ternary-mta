function onStart()
    outputDebugString("Loading skins..")
    local filename = 'wmydrug.txd'
    local id = 29
    local txd = engineLoadTXD(filename)
    if not engineImportTXD(txd, id) then
        outputDebugString("Importing ID " .. tostring(id) .. " failed")
    end
end

addEventHandler('onClientResourceStart', resourceRoot, onStart)