if Tibia:IsShowInvisibleCreaturesEnabled() == true then
    Tibia:SetShowInvisibleCreatures(false)
    Tibia:SetStatusbarText("Show Invisible Creatures: Off")
else
    Tibia:SetShowInvisibleCreatures(true)
    Tibia:SetStatusbarText("Show Invisible Creatures: On")
end
