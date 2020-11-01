ESX              	= nil
local PlayerData 	= {}
local spawned 		= false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterCommand('motd', function()
	motd()
end)

AddEventHandler("playerSpawned", function(spawn)
	if not spawned then
		motd()
		spawned = true
	end
end)

AddEventHandler('dd_motd:wait', function(time)
	Wait(time*1000)
	display = false
end

function motd()
	local scaleform = ESX.Scaleform.Utils.RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')
	display = true

	BeginScaleformMovieMethod(scaleform, 'SHOW_WEAPON_PURCHASED')

	PushScaleformMovieMethodParameterString(Config.text1)
	PushScaleformMovieMethodParameterString(Config.text2)
	PushScaleformMovieMethodParameterString('')
	PushScaleformMovieMethodParameterInt(100)

	EndScaleformMovieMethod()
	Citizen.CreateThread(function()
		while display do
			Wait(0)
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
			TriggerEvent('dd_motd:wait', 10)
		end
	end)
end
