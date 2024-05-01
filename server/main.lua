Citizen.CreateThread(function()
    Citizen.Wait(3500)
    print('^7[^2INFO^7] The ^6private mode ^7is enabled, ^6only whitelisted ^7players can join the server.^7')
end)

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local player = source
    local allowed = false
    local ident = nil
    deferrals.defer()
    deferrals.update(Config.Locales.CheckingPermissions)

    for _, identifier in ipairs(GetPlayerIdentifiers(player)) do
        for _, allowedIdentifier in ipairs(Config.AllowedIdentifiers) do
            if identifier == allowedIdentifier then
                ident = identifier
                allowed = true
                break
            end
        end
    end
    if allowed then
        deferrals.done()
        print('^7[^2INFO^7] Allowed player connected: ' .. GetPlayerName(player) .. ' (' .. ident .. ')')
    else
        deferrals.done(Config.Locales.NoPermissions)
        print('^7[^2INFO^7] Disallowed player tried to connect: ' .. GetPlayerName(player))
    end
end)