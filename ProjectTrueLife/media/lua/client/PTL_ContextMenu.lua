-- Project True Life - Contextual Menu Revamp

-- Suppress Radial Menu where possible.
-- We want to supplement the standard interaction menu with our Sims 4 style context actions,
-- without wiping out vanilla multiplayer menus entirely (which would break trading/safehouses).

function PTL_AddCustomActions(player, context, worldobjects, test)
    if test and ISWorldObjectContextMenu.Test then return true end

    -- We are no longer suppressing all radial menus globally, to prevent invisible soft-locks.
    -- We are also no longer calling context:clear() to avoid wiping out essential multiplayer UI.

    local playerObj = getSpecificPlayer(player)
    local inv = playerObj:getInventory()

    -- Direct interaction options based on what we clicked
    for _, obj in ipairs(worldobjects) do
        local sprite = obj:getSprite()
        if sprite then
            local spriteName = sprite:getName()

            -- Example: Cleaning up blood or grime
            if obj:hasModData() and obj:getModData().isDirty or (spriteName and string.match(spriteName, "blood")) then
                context:addOption("Nettoyer", worldobjects, function()
                    -- Action to clean
                    if inv:containsType("Bleach") and inv:containsType("BathTowel") then
                        playerObj:Say("Je nettoie ça.")
                        -- Add timed action here in a real mod
                    else
                        playerObj:Say("J'ai besoin de javel et d'une serviette.")
                    end
                end)
            end

            -- Example: Destroying things (if holding a sledgehammer)
            if inv:containsType("Sledgehammer") then
                context:addOption("Detruire", worldobjects, function()
                    playerObj:Say("Destruction en cours.")
                    obj:getSquare():transmitRemoveItemFromSquare(obj)
                    obj:getSquare():RemoveTileObject(obj)
                end)
            end

            -- Example: Painting
            if inv:containsType("Paintbrush") and inv:containsType("Paintbucket") then
                context:addOption("Repeindre", worldobjects, function()
                    playerObj:Say("Je peins ce mur.")
                end)
            end
        end
    end

    -- If we clicked nothing interactive, just add a generic examine
    if context.numOptions == 0 then
        context:addOption("Examiner", worldobjects, function()
            playerObj:Say("Il n'y a rien de special ici.")
        end)
    end
end

-- Remove PreFill, we will just wipe the options at the end of OnFill
Events.OnFillWorldObjectContextMenu.Add(PTL_AddCustomActions)
