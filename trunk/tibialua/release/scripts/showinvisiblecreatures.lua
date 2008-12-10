if tibia_isshowinvisiblecreaturesenabled() == true then
    tibia_setshowinvisiblecreatures(false)
    tibia_setstatusbartext("Show Invisible Creatures: Off")
else
    tibia_setshowinvisiblecreatures(true)
    tibia_setstatusbartext("Show Invisible Creatures: On")
end
