local sw, sh = guiGetScreenSize() 
local browser

outputChatBox('Cinema loaded.')
function render()
	local x, y, z = 2464.24561, -1645.59924, 230.33594
	dxDrawMaterialLine3D(x, y, z + 4, x, y, z, browser, 18.2, tocolor(255, 255, 255, 255), 2458.06006, -1645.59766, 230.33594+4)
	-- dxDrawImage(0, 0, sw, sh, browser, 0, 0, 0, tocolor(255,255,255,255), true)
end

function loadCinemaURL()
	outputChatBox("Browser loaded.")
	loadBrowserURL(browser, 'https://hackcambridge.com/live')
	addEventHandler('onClientPreRender', root, render)
end

function loadBrowser()
	browser = createBrowser(sw, sh, false, false)
	addEventHandler('onClientBrowserCreated', browser, loadCinemaURL)
end

addEventHandler('onClientResourceStart', resourceRoot, function()
	if isBrowserDomainBlocked('hackcambridge.com') then
		requestBrowserDomains({'hackcambridge.com'})
	else
		loadBrowser()
	end
end)

addEventHandler('onClientBrowserWhitelistChange', root, function(newDomains)
	if newDomains[1] ~= 'hackcambridge.com' then
		return
	end

	loadBrowser()
end)