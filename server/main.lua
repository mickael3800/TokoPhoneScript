--[[
    File Name:		main.lua
	Programmer:		Mickaël Papineau
	Date:			2021/06/13
	Version:		1.0.0-Alpha
	Description:    This script is the main server side script.
]]--

local List = {}
local Last = {}
local CallLines = Config.CallLines

RegisterNetEvent("startCall")
AddEventHandler("startCall", function(Id)

	if (IsPlayerPlaying(Id) == true) then

		local Line = Check()

		if (Line == not nil) then

			Last[source] = LastCh(source)
			Last[Id] = LastCh(Id)

			List[source] = Line
			List[Id] = Line

			CallLines[Line].Used = true
			CallLines[Line].Waiting = true
			CallLines[Line].Num = 2
			CallLines[Line].Id = {source, Id}

			TriggerClientEvent("Notify", source, 1)
			TriggerClientEvent("CallNotify", Id, source)

			while (CallLines[Line].Anw == nil) do

				local start = os.time()

				if (os.time() > start + 60) then

					CallLines[Line].Anw = false

				end

			end

			if (CallLines[Line].Anw == true) then

				if (Last[source] == not nil) then

					TriggerClientEvent("removePlayerFromRadio", source, Last[source])

				end

				if (Last[Id] == not nil) then

					TriggerClientEvent("removePlayerFromRadio", Id, Last[Id])

				end

				TriggerClientEvent("addPlayerToRadio", source, CallLines[Line].Ch, false)
				TriggerClientEvent("addPlayerToRadio", Id, CallLines[Line].Ch, false)

				TriggerClientEvent("Notify", source, 2)
				TriggerClientEvent("Notify", Id, 2)

				CallLines[Line].Waiting = false

			elseif (CallLines[Line].Anw == false) then

				CallLines[Line].Used = false
				CallLines[Line].Waiting = false
				CallLines[Line].Num = 0
				CallLines[Line].Id = nil
				CallLines[Line].Anw = nil

				Last[source] = nil
				Last[Id] = nil

				List[source] = nil
				List[Id] = nil

				TriggerClientEvent("Notify", source, 4)

			end

		elseif (Line == nil) then

			TriggerClientEvent("Notify", source, 3)

		end

	elseif (IsPlayerPlaying(Id) == false) then

		TriggerClientEvent("Notify", source, 3)

	end

end)

RegisterNetEvent("endCall")
AddEventHandler("endCall", function()

	local Line = List[source]

	for i = 1, CallLines[Line].Num, 1 do

		TriggerClientEvent("removePlayerFromRadio", CallLines[Line].Id[i], CallLines[Line].Ch)

		if (Last[CallLines[Line].Id[i]] == not nil) then

			TriggerClientEvent("addPlayerToRadio", CallLines[Line].Id[i], Last[CallLines[Line].Id[i]], true)

		end

		TriggerClientEvent("Notify", CallLines[Line].Id[i], 5)

		Last[CallLines[Line].Id[i]] = nil
		List[CallLines[Line].Id[i]] = nil

	end

	CallLines[Line].Used = false
	CallLines[Line].Waiting = false
	CallLines[Line].Num = 0
	CallLines[Line].Id = nil
	CallLines[Line].Anw = nil

end)

RegisterNetEvent("addCall")
AddEventHandler("addCall", function(Id)

	if (IsPlayerPlaying(Id) == true) then

		local Line = List[source]

		Last[Id] = LastCh(Id)
		List[Id] = Line

		CallLines[Line].Anw = nil
		CallLines[Line].Num = CallLines[Line].Num + 1
		CallLines[Line].Id[CallLines[Line].Num] = Id

		TriggerClientEvent("Notify", source, 1)
		TriggerClientEvent("CallNotify", Id, source)

		while (CallLines[Line].Anw == nil) do

			local start = os.time()

			if (os.time() > start + 60) then

				CallLines[Line].Anw = false

			end

		end

		if (CallLines[Line].Anw == true) then

			if (Last[Id] == not nil) then

				TriggerClientEvent("removePlayerFromRadio", source, Last[source])

			end

			TriggerClientEvent("addPlayerToRadio", Id, CallLines[Line].Ch, false)

			TriggerClientEvent("Notify", source, 2)
			TriggerClientEvent("Notify", Id, 2)

		elseif (CallLines[Line].Anw == false) then

			CallLines[Line].Id[CallLines[Line].Num] = nil
			CallLines[Line].Num = CallLines[Line].Num - 1

			Last[Id] = nil
			List[Id] = nil

			TriggerClientEvent("Notify", source, 4)

		end

	elseif (IsPlayerPlaying(Id) == false) then

		TriggerClientEvent("Notify", source, 3)

	end

end)

RegisterNetEvent("anwCall")
AddEventHandler("anwCall", function(Anw)

	local Line = List[source]

	if (Anw == true) then

		CallLines[Line].Anw = true

	elseif (Anw == false) then

		CallLines[Line].Anw = false

	end

end)

RegisterNetEvent("dscCall")
AddEventHandler("dsCall", function()

	local Line = List[source]
	local Num

	for i = 1, CallLines[Line].Num, 1 do

		if (Last[CallLines[Line].Id[i]] == source) then

			Num = i

		end

	end

	TriggerClientEvent("removePlayerFromRadio", source, CallLines[Line].Ch)

	if (Last[source] == not nil) then

		TriggerClientEvent("addPlayerToRadio", source, Last[source], true)

	end

	table.remove(CallLines[Line].Id, Num)

	CallLines[Line].Num = CallLines[Line].Num - 1

end)
