if Tibia:IsNameSpyEnabled() == true then
    Tibia:SetNameSpy(false)
    Tibia:SetStatusbarText("Name Spy: Off")
else
    Tibia:SetNameSpy(true)
    Tibia:SetStatusbarText("Name Spy: On")
end
