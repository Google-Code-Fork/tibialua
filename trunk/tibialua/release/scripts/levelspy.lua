if tibia_islevelspyenabled() == true then
    tibia_setlevelspy(false)
    tibia_setstatusbartext("Level Spy: Off")
else
    tibia_setlevelspy(true)
    tibia_setstatusbartext("Level Spy: On")
end
