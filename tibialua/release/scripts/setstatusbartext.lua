text_set = iup.text {value = "blah blah blah", expand = "HORIZONTAL"}

button_set = iup.button {title = "Set", size = "32x12"}

button_exit = iup.button {title = "Exit", size = "32x12"}

function button_set:action()
    Tibia:SetStatusbarText(iup.GetAttribute(text_set, "VALUE"))
end

function button_exit:action()
    iup.ExitLoop()
    dialog:destroy()
end

dialog = iup.dialog
{
    iup.vbox
    {
        iup.label {title = "Fill the textbox below and press the Set button"},
        iup.hbox
        {
            text_set,
            button_set
        },
        iup.fill{},
        button_exit
    }
    ;title = "Set Statusbar Text", rastersize = "320x240", margin = "10x10", maxbox = "NO", resize = "NO"
}

dialog:showxy(iup.CENTER, iup.CENTER)

iup.SetFocus(dialog)

iup.MainLoop()
