if Tibia:IsLevelSpyEnabled() == true then
    Tibia:SetLevelSpy(false)
    Tibia:SetStatusbarText("Level Spy: Off")
else
    Tibia:SetLevelSpy(true)
    Tibia:SetStatusbarText("Level Spy: On")
end
