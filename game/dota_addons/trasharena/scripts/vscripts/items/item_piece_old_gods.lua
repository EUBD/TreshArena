function Base( keys )
	local caster = keys.caster
	local ability = keys.ability
	local charges = ability:GetCurrentCharges()


	if(charges >= 10) then
	    for i=0, 5, 1 do
	        local current_item = keys.caster:GetItemInSlot(i)
	        if current_item ~= nil then
	            if current_item:GetName() == "item_piece_old_gods" then
	                keys.caster:RemoveItem(current_item)
<<<<<<< HEAD:game/dota_addons/trasharena/scripts/vscripts/items/item_war_axe_piece.lua
	                keys.caster:AddItem(CreateItem("item_war_axe_dummy", keys.caster, keys.caster))  
	        	end
	    	end
=======
	                keys.caster:AddItem(CreateItem("item_essence_old_gods", keys.caster, keys.caster))  
				end
			end
>>>>>>> origin/master:game/dota_addons/trasharena/scripts/vscripts/items/item_piece_old_gods.lua
	    
		end
	end
end
function Destroy( keys )
	local modifier = "modifier_piece_old_gods_damage"
	local caster = keys.caster
	local ability = keys.ability

	caster:SetModifierStackCount(modifier,caster,0)
	caster:RemoveModifierByName(modifier)
	end
