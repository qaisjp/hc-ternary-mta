function sendHawaiiAlertToAllClient()
    triggerClientEvent('onHawaiiAlertReceived', root)
end

addEvent( "onHawaiiAlertSent", true )
addEventHandler( "onHawaiiAlertSent", resourceRoot, sendHawaiiAlertToAllClient )