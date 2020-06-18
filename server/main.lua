ESX = nil
local playersProcessingCocaine = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('viv_cocaine:buyLicense', function(source, cb, licenseName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local license = Config.LicensePrices[licenseName]

	if license then
		if xPlayer.getMoney() >= license.price then
			xPlayer.removeMoney(license.price)

			TriggerEvent('esx_license:addLicense', source, licenseName, function()
				cb(true)
			end)
		else
			cb(false)
		end
	else
		print(('viv_cocaine: %s attempted to buy an invalid license!'):format(xPlayer.identifier))
		cb(false)
	end
end)

RegisterServerEvent('viv_cocaine:pickedUpCocaleaf')
AddEventHandler('viv_cocaine:pickedUpCocaleaf', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.canCarryItem('cocaleaf', 1) then
		xPlayer.addInventoryItem('cocaleaf', 1)
	else
		xPlayer.showNotification(_U('coca_inventoryfull'))
	end
end)

ESX.RegisterServerCallback('viv_cocaine:canPickUp', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	cb(xPlayer.canCarryItem(item, 1))
end)

RegisterServerEvent('viv_cocaine:processCoca')
AddEventHandler('viv_cocaine:processCoca', function()
	if not playersProcessingCocaine[source] then
		local _source = source

		playersProcessingCocaine_source] = ESX.SetTimeout(Config.Delays.CocaProcessing, function()
			local xPlayer = ESX.GetPlayerFromId(_source)
			local xCoca = xPlayer.getInventoryItem('cocaleaf')

			if xCoca.count > 3 then
				if xPlayer.canSwapItem('cocaleaf', 3, 'purecoca', 1) then
					xPlayer.removeInventoryItem('cocaleaf', 3)
					xPlayer.addInventoryItem('purecoca', 1)

					xPlayer.showNotification(_U('coca_processed'))
				else
					xPlayer.showNotification(_U('coca_processingfull'))
				end
			else
				xPlayer.showNotification(_U('coca_processingenough'))
			end

			playersProcessingCocaine[_source] = nil
		end)
	else
		print(('viv_cocaine: %s attempted to exploit cocaine processing!'):format(GetPlayerIdentifiers(source)[1]))
	end
end)

function CancelProcessing(playerId)
	if playersProcessingCocaine[playerId] then
		ESX.ClearTimeout(playersProcessingCocaine[playerId])
		playersProcessingCocaine[playerId] = nil
	end
end

RegisterServerEvent('viv_cocaine:cancelProcessing')
AddEventHandler('viv_cocaine:cancelProcessing', function()
	CancelProcessing(source)
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	CancelProcessing(playerId)
end)

RegisterServerEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	CancelProcessing(source)
end)