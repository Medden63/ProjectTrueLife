-- Project True Life - World Interactions (Client)

function PTL_OnPlayerInteract(player, context, worldobjects, test)
    local playerObj = getSpecificPlayer(player)

    local targetPlayer = nil
    for _, obj in ipairs(worldobjects) do
        if instanceof(obj, "IsoPlayer") and obj ~= playerObj then
            targetPlayer = obj
            break
        end
    end

    if targetPlayer then
        -- This logic is appended to the context menu if a player is clicked
        local option = context:addOption("Interagir (PTL)", nil, nil)
        local subMenu = context:getNew(context)
        context:addSubMenu(option, subMenu)

        -- Mayor action: propose contract
        if playerObj:getDescriptor():getProfession() == "mayor" then
            subMenu:addOption("Proposer un contrat de travail", nil, function()
                playerObj:Say("Je vous propose un contrat de reconstruction.")
                sendClientCommand(playerObj, "PTL", "ProposeContract", {target = targetPlayer:getUsername()})
            end)

            subMenu:addOption("Attribuer parcelle (Claim)", nil, function()
                playerObj:Say("Je vous attribue cette zone.")
                local sq = playerObj:getSquare()
                sendClientCommand(playerObj, "PTL", "ClaimZone", {target = targetPlayer:getUsername(), x = sq:getX(), y = sq:getY()})
            end)
        end

        -- Medic action: Heal
        if playerObj:getDescriptor():getProfession() == "fieldmedic" then
            subMenu:addOption("Soigner", nil, function()
                playerObj:Say("Laissez-moi vous examiner.")
                sendClientCommand(playerObj, "PTL", "HealPlayer", {target = targetPlayer:getUsername()})
            end)
        end

        -- General action
        subMenu:addOption("Echanger ressources", nil, function()
            playerObj:Say("Voulez-vous faire du troc ?")
            -- Trade UI hook would go here
        end)
    end
end

-- Hook after our main context menu wipe
Events.OnFillWorldObjectContextMenu.Add(PTL_OnPlayerInteract)
