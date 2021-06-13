--[[
    File Name:		main.lua
	Programmer:		Mickaël Papineau
	Date:			2021/06/13
	Version:		1.0.0-Alpha
	Description:    This script is the main client side script.
]]--

local lastCh = nil

RegisterCommand("call", function(source, args, raw)

    if (IsPlayerPlaying(source) == true) then

        TriggerServerEvent("startCall", tonumber(args[1]))

    elseif (IsPlayerPlaying(source) == false) then

		TriggerClientEvent("Notify", source, 3)

    end

end, false)

RegisterCommand("calladd", function(source, args, raw)

    if (IsPlayerPlaying(source) == true) then

        TriggerServerEvent("addCall", tonumber(args[1]))

    elseif (IsPlayerPlaying(source) == false) then

		TriggerClientEvent("Notify", source, 3)

    end

end, false)

RegisterCommand("calldsc", function()

    TriggerServerEvent("dscCall")

end, false)

RegisterCommand("callanw", function(source, args, raw)

    if (args[1] == "y" or args[1] == "Y") then

        TriggerServerEvent("anwCall", true)

    elseif (args[1] == "n" or args[1] == "N") then

        TriggerServerEvent("anwCall", false)

    end

end, false)

RegisterCommand("callend", function()

    TriggerServerEvent("endCall")

end, false)
