if Tibia:IsFullLightEnabled() == true then
    Tibia:SetFullLight(false)
    Tibia:SetStatusbarText("Full Light: Off")
else
    Tibia:SetFullLight(true)
    Tibia:SetStatusbarText("Full Light: On")
end
