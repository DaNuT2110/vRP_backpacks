local prop 

RegisterNetEvent("pune:rucsac")
AddEventHandler("pune:rucsac",function(rucsac)
	if rucsac == 1 then
		local prop_name = 'prop_michael_backpack'
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			DeleteObject(prop)
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 24818), 0.046, -0.17, -0.040, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
		end)
	elseif rucsac == 2 then
		local prop_name = 'p_ld_heist_bag_01'
        local playerPed = GetPlayerPed(-1)
        Citizen.CreateThread(function()
            local x,y,z = table.unpack(GetEntityCoords(playerPed))
			DeleteObject(prop)
            prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
            AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 24818), 0.020, 0.03, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
        end)
	elseif rucsac == 3 then
		local prop_name = 'p_ld_heist_bag_s_pro2_s'
        local playerPed = GetPlayerPed(-1)
        Citizen.CreateThread(function()
            local x,y,z = table.unpack(GetEntityCoords(playerPed))
			DeleteObject(prop)
            prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true,  true, true)
            AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 24818), -0.19, -0.19, 0.00, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
        end)
	end
end)

RegisterNetEvent("sterge:rucsac")
AddEventHandler("sterge:rucsac",function(rucsac)
	DeleteObject(prop)
end)