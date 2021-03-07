--[[Functii ce trebuie adaugate in vrp/modules/inventory.lua]]--

--[[Functii complete (nu se afla in inventory.lua]]--

rucsac = {}

function vRP.setRucsac(user_id,tRucsac)
	if not rucsac[user_id] then rucsac[user_id] = 0 end
	
	if vRP.getInventoryWeight(user_id) <= (vRP.getInventoryMaxWeight(user_id) - rucsac[user_id] + tRucsac) then
		rucsac[user_id] = tRucsac
		if tRucsac == 0 then
			TriggerClientEvent('sterge:rucsac',source)
		end
		return true
	else 
		return false
	end
end

function vRP.getRucsac(user_id)
	if user_id then
		return rucsac[user_id]
	end
end


--[[Functii ce trebuie editate (toate liniile marcate trebuie adăugate, restul probabil că sunt deja în vrp)]]--

-- give action
function ch_give(idname, player, choice)
  local user_id = vRP.getUserId(player)
  if user_id then
    -- get nearest player
    local nplayer = vRPclient.getNearestPlayer(player,10)
    if nplayer then
      local nuser_id = vRP.getUserId(nplayer)
      if nuser_id then
        -- prompt number
        local amount = vRP.prompt(player,lang.inventory.give.prompt({vRP.getInventoryItemAmount(user_id,idname)}),"")
        local amount = parseInt(amount)
        -- weight check
		local greutate = true																--[[Adaugate]]--
		if idname == "rucsac" or idname == "rucsac2" or idname == "rucsac3" then		--[[Adaugate]]--
			greutate = vRP.setRucsac(user_id,0)											--[[Adaugate]]--
		end																				--[[Adaugate]]--
		if greutate then																	--[[Adaugate]]--
			local new_weight = vRP.getInventoryWeight(nuser_id)+vRP.getItemWeight(idname)*amount
			if new_weight <= vRP.getInventoryMaxWeight(nuser_id) then
			  if vRP.tryGetInventoryItem(user_id,idname,amount,true) then
				vRP.giveInventoryItem(nuser_id,idname,amount,true)
				vRPclient.playAnim(player,true,{{"mp_common","givetake1_a",1}},false)
				vRPclient.playAnim(nplayer,true,{{"mp_common","givetake2_a",1}},false)
			  else
				vRPclient.notify(player,lang.common.invalid_value())
			  end
			else
			  vRPclient.notify(player,lang.inventory.full())
			end
		else  																--[[Adaugate]]--
			vRPclient.notify(player,"~r~Goliti mai intai rucsacul.")		--[[Adaugate]]--
		end																	--[[Adaugate]]--
      else
        vRPclient.notify(player,lang.common.no_player_near())
      end
    else
      vRPclient.notify(player,lang.common.no_player_near())
    end
  end
end

-- trash action
function ch_trash(idname, player, choice)
  local user_id = vRP.getUserId(player)
  if user_id then
    -- prompt number
    local amount = vRP.prompt(player,lang.inventory.trash.prompt({vRP.getInventoryItemAmount(user_id,idname)}),"")
    local amount = parseInt(amount)
	local greutate = true															--[[Adaugate]]--
	if idname == "rucsac" or idname == "rucsac2" or idname == "rucsac3" then	--[[Adaugate]]--
		greutate = vRP.setRucsac(user_id,0)										--[[Adaugate]]--
	end																			--[[Adaugate]]--
	if greutate then 																--[[Adaugate]]--
		if vRP.tryGetInventoryItem(user_id,idname,amount,false) then
		  vRPclient.notify(player,lang.inventory.trash.done({vRP.getItemName(idname),amount}))
		  vRPclient.playAnim(player,true,{{"pickup_object","pickup_low",1}},false)
		else
		  vRPclient.notify(player,lang.common.invalid_value())
		end
	else 																		--[[Adaugate]]--
      vRPclient.notify(player,"~r~Goliti mai intai rucsacul.")				--[[Adaugate]]--
    end																			--[[Adaugate]]--
  end
end

-- return maximum weight of the user inventory
function vRP.getInventoryMaxWeight(user_id)
  if not rucsac[user_id] then rucsac[user_id] = 0 end
  return math.floor(vRP.expToLevel(vRP.getExp(user_id, "physical", "strength")))*cfg.inventory_weight_per_strength + rucsac[user_id] --[[Adaugate]]--
end


		local cb_put = function(idname)
          local amount = vRP.prompt(source, lang.inventory.chest.put.prompt({vRP.getInventoryItemAmount(user_id, idname)}), "")
          amount = parseInt(amount)
			local greutate = true 																--[[Adaugate]]--
			if idname == "rucsac" or idname == "rucsac2" or idname == "rucsac3" then 	--[[Adaugate]]--
				greutate = vRP.setRucsac(user_id,0) 											--[[Adaugate]]--
			end 																			--[[Adaugate]]--
			if greutate then 																	--[[Adaugate]]--
			  local new_weight = vRP.computeItemsWeight(chest.items)+vRP.getItemWeight(idname)*amount
			  if new_weight <= max_weight then
				if amount >= 0 and vRP.tryGetInventoryItem(user_id, idname, amount, true) then
				  local citem = chest.items[idname]
				  if citem ~= nil then
					citem.amount = citem.amount+amount
				  else
					chest.items[idname] = {amount=amount}
				  end
				  if cb_in then cb_in(idname,amount) end
				  vRP.closeMenu(source)
				end
			  else
				vRPclient.notify(source,lang.inventory.chest.full())
			  end
			else																		--[[Adaugate]]--
				vRPclient.notify(source,"Ai rucsacul echipat.")			--[[Adaugate]]--
			end																			--[[Adaugate]]--
        end