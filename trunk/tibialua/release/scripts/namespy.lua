if tibia_isnamespyenabled() == true then
    tibia_setnamespy(false)
    tibia_setstatusbartext("Name Spy: Off")
else
    tibia_setnamespy(true)
    tibia_setstatusbartext("Name Spy: On")
end
