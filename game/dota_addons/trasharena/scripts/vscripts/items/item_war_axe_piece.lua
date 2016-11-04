function Base( keys )
	local caster = keys.caster
	local ability = keys.ability
	local charges = ability:GetCurrentCharges()


	if(charges >= 6) then
	    for i=0, 5, 1 do
	        local current_item = keys.caster:GetItemInSlot(i)
	        if current_item ~= nil then
	            if current_item:GetName() == "item_war_axe_piece" then
	                keys.caster:RemoveItem(current_item)
	                keys.caster:AddItem(CreateItem("item_war_axe_dummy", keys.caster, keys.caster))  
	        	end
	    	end
	    
		end
	end
end

function Destroy( keys )
	local modifier = "modifier_war_axe_piece_damage"
	local caster = keys.caster
	local ability = keys.ability

	caster:SetModifierStackCount(modifier,caster,0)
	caster:RemoveModifierByName(modifier)
end