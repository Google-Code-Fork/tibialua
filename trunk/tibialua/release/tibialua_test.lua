print("Hello World!")

if (Tibia:IsOnline() == true) then
    print("Player is online.")
else
    print("Player is offline.")
end

if (Tibia:IsOutfitMale(Tibia:GetPlayerOutfit()) == true) then
    print("Player is male.")
elseif (Tibia:IsOutfitFemale(Tibia:GetPlayerOutfit()) == true) then
    print("Player is female.")
end

print("Player ID: " .. Tibia:GetPlayerId())
print("Player Level: " .. Tibia:GetPlayerLevel())
print("Player EXP: " .. Tibia:GetPlayerExp())
print("Player X: " .. Tibia:GetPlayerX())
print("Player Y: " .. Tibia:GetPlayerY())
print("Player Z: " .. Tibia:GetPlayerZ())

text_player_id = iup.text {value = Tibia:GetPlayerId(), expand = "HORIZONTAL"}

text_player_level = iup.text {value = Tibia:GetPlayerLevel(), expand = "HORIZONTAL"}

text_player_exp = iup.text {value = Tibia:GetPlayerExp(), expand = "HORIZONTAL"}

button_exit = iup.button {title = "Exit", size = "32x12"}

function button_exit:action()
    iup.ExitLoop()
    dialog:destroy()
end

dialog = iup.dialog
{
    iup.vbox
    {
        iup.label {title = "Player ID:"},
        text_player_id,
        iup.label {title = "Player Level:"},
        text_player_level,
        iup.label {title = "Player EXP:"},
        text_player_exp,
        iup.fill{},
        button_exit
    }
    ;title = "Tibia Lua Test", rastersize = "320x240", margin = "10x10", maxbox = "NO", resize = "NO"
}

dialog:showxy(iup.CENTER, iup.CENTER)

iup.SetFocus(dialog)

iup.MainLoop()
