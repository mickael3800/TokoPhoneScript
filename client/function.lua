--[[
    File Name:		function.lua
	Programmer:		Mickaël Papineau
	Date:			2021/06/13
	Version:		1.0.0-Alpha
	Description:    This script is some functions for the client side script.
]]--

RegisterNetEvent("Notify")
AddEventHandler("Notify", function(num)

    if (num == 1) then

        notify("~y~Dialling...")

    elseif (num == 2) then

        notify("~g~Call Connected.")

    elseif (num == 3) then

        notify("~r~Call Rejected by Network.")

    elseif (num == 4) then

        notify("~r~Call Rejected by User.")

    elseif (num == 5) then

        notify("~r~Call Ended.")

    elseif (num == 6) then

        notify("~r~Call Disconnected.")

    end

end)

RegisterNetEvent("CallNotify")
AddEventHandler("CallNotify", function(caller)

    notify(GetPlayerName(caller), " is trying to call you. /callanw [~g~y~w~/~r~n~w~]")

end)

function notify(msg)    --The function to notify the player.

    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true, false)

end
