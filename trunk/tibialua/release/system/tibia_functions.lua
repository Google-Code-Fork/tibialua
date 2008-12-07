-- set statusbar text
function setStatusbarText (text)
    -- show statusbar text by timer
    writeBytes(STATUSBAR_TIMER, STATUSBAR_DURATION, 1)

    -- set statusbar text
    writeString(STATUSBAR_TEXT, text)
end
