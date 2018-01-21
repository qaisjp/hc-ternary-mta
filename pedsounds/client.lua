local sounds = {'Hacker1.mp3', 'Hacker2.mp3', 'Hacker3.mp3', 'Hacker4.mp3'}
local soundPos = {
    {2431.02148, -1657.95178, 228.42049},
    {2413.02515, -1658.22644, 228.42049},
    {2415.43579, -1632.78650, 228.42049},
    {2431.24683, -1633.27295, 228.42049}
}
function onStart()
    for i, fpath in ipairs(sounds) do
        local x, y, z = unpack(soundPos[i])
        playSound3D( fpath, x, y, z, true )
    end

end

addEventHandler('onClientResourceStart', resourceRoot, onStart)