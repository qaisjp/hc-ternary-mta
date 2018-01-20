-- local skins = {
--     {29, 'wmydrug.txd'}
-- }
function onStart()
    outputDebugString("Loading skins..")
    --for _, skin in ipairs(skins) do
    local filename = 'crogrl3.txd'
    local id = 194
    local txd = engineLoadTXD(filename)
    if not engineImportTXD(txd, id) then
        outputDebugString("Importing ID " .. tostring(id) .. " failed")
    end
end

addEventHandler('onClientResourceStart', resourceRoot, onStart)