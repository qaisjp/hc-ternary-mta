local sw, sh = guiGetScreenSize() 
local browser = createBrowser(sw, sh, false, false)
outputChatBox('Cinema loaded.')
function render()
	local x, y, z = 2464.24561, -1645.59924, 230.33594
	dxDrawMaterialLine3D(x, y, z, x, y, z-9, browser, 18.2, tocolor(255, 255, 255, 255), 2458.06006, -1645.59766, 230.33594)
	dxDrawImage(0, 0, sw, sh, browser, 0, 0, 0, tocolor(255,255,255,255), true)
	if localPlayer.name == 'qaisjp' then
		outputDebugString('render')
	end
end

addEventHandler('onClientBrowserCreated', browser, function()
	outputChatBox("Browser loaded.")
	loadBrowserURL(browser, 'https://youtube.com')
	addEventHandler('onClientPreRender', root, render)
end)
