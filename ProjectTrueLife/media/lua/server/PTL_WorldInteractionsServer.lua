-- Project True Life - World Interactions (Server)

-- Global table to store claims
if not ModData.get("PTL_Claims") then
    ModData.add("PTL_Claims", {})
end

function PTL_OnClientCommand(module, command, playerObj, args)
    if module ~= "PTL" then return end

    if command == "ProposeContract" then
        print("[PTL Server] Mayor " .. playerObj:getUsername() .. " proposed a contract to " .. tostring(args.target))
        -- Server logic for contracts goes here (e.g. creating a pending contract in moddata)
    elseif command == "HealPlayer" then
        print("[PTL Server] Medic " .. playerObj:getUsername() .. " is healing " .. tostring(args.target))
        -- In a real mod we would find the target IsoPlayer and remove damage/infections
    elseif command == "ClaimZone" then
        print("[PTL Server] Mayor " .. playerObj:getUsername() .. " claimed zone at " .. args.x .. "," .. args.y .. " for " .. tostring(args.target))
        local claims = ModData.getOrCreate("PTL_Claims")
        -- Create a simple chunk-based claim key
        local claimKey = tostring(math.floor(args.x / 10)) .. "_" .. tostring(math.floor(args.y / 10))
        claims[claimKey] = args.target
        ModData.transmit("PTL_Claims")
    end
end

Events.OnClientCommand.Add(PTL_OnClientCommand)
