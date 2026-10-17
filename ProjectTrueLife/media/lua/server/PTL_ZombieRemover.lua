-- Project True Life - Zombie Removal Mechanism

function PTL_ClearZombies()
    -- Set global sandbox parameters to 0
    SandboxVars.ZombieConfig.PopulationMultiplier = 0.0
    SandboxVars.ZombieConfig.PopulationStartMultiplier = 0.0
    SandboxVars.ZombieConfig.PopulationPeakMultiplier = 0.0

    if isClient() then return end

    local cells = getCell()
    if not cells then return end
    local zombieList = cells:getZombieList()
    if zombieList then
        for i = zombieList:size() - 1, 0, -1 do
            local z = zombieList:get(i)
            z:removeFromWorld()
            z:removeFromSquare()
        end
    end
end

Events.OnInitGlobalModData.Add(PTL_ClearZombies)
Events.OnGameStart.Add(PTL_ClearZombies)
Events.EveryHours.Add(PTL_ClearZombies)
