local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRPbp = {}
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vRP_backpacks")
BPclient = Tunnel.getInterface("vRP_backpacks","vRP_backpacks")
Tunnel.bindInterface("vRP_backpacks",vRPbp)


Citizen.CreateThread(function()
  for k,v in pairs(rucsace) do
    vRP.defInventoryItem({k,v.name,v.desc,v.choices,v.weight})
  end
end)

rucsace = {
	["rucsac"] = {
		name = "Rucsac Mic",
		desc = "E foarte micut..",
		choices = function(args)
			local menu = {}
			menu["Echipeaza"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				TriggerClientEvent('pune:rucsac',player,1)
				vRP.setRucsac({user_id,10})
			end}
			menu["Dezechipeaza"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.setRucsac({user_id,0}) then 
					TriggerClientEvent('sterge:rucsac',player)
				else
					vRPclient._notify(player,{"~r~Goliți mai întâi rucsacul."})
				end
			end}
			return menu
		end,
		weight = 2.0
	},
	["rucsac2"] = {
		name = "Rucsac Mare",
		desc = "E destul de mare..",
		choices = function(args)
			local menu = {}
			menu["Echipeaza"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				TriggerClientEvent('pune:rucsac',player,2)
				vRP.setRucsac({user_id,50})
			end}
			menu["Dezechipeaza"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.setRucsac({user_id,0}) then 
					TriggerClientEvent('sterge:rucsac',player)
				else
					vRPclient._notify(player,"~r~Goliți mai întâi rucsacul.")
				end
			end}
			return menu
		end,
		weight = 2.0
	},
	["rucsac3"] = {
		name = "Rucsac Mediu",
		desc = "Merge pentru cateva lucruri..",
		choices = function(args)
			local menu = {}
			menu["Echipeaza"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				TriggerClientEvent('pune:rucsac',player,3)
				vRP.setRucsac({user_id,30})
			end}
			menu["Dezechipeaza"] = {function(player,choice)
				local user_id = vRP.getUserId({player})
				if vRP.setRucsac({user_id,0}) then 
					TriggerClientEvent('sterge:rucsac',player)
				else
					vRPclient._notify(player,{"~r~Goliți mai întâi rucsacul."})
				end
			end}
			return menu
		end,
		weight = 2.0
	}
}