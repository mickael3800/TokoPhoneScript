--[[
    File Name:		function.lua
	Programmer:		Mickaël Papineau
	Date:			2021/06/13
	Version:		1.0.0-Alpha
	Description:    This script is some functions for the server side script.
]]--

local CallLines = Config.CallLines

function Check()

    local Ch = nil

    for i = 1, Config.LineNum, 1 do

        if (CallLines[i].Used == false) then

            Ch = i
            break

        end

    end

    return(Ch)

end

function LastCh(Id)

    local Ch = nil

    for i = 1, 99, 1 do

        if (TriggerClientEvent("isPlayerInChannel", Id, i) == true) then

            Ch = i
            break

        end

    end

    return(Ch)

end
