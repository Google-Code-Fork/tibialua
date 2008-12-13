if tibia_isfulllightenabled() == true then
    tibia_setfulllight(false)
    tibia_setstatusbartext("Full Light: Off")
else
    tibia_setfulllight(true)
    tibia_setstatusbartext("Full Light: On")
end
