function Eat_gem(keys)
	local caster = keys.caster
	if not caster then return end
	if not caster:IsRealHero() then return end

	item_gem = CreateItem("item_gem", caster, caster) 
	caster:AddNewModifier(caster, item_gem, "modifier_item_gem_of_true_sight", {});
	 for i=0, 5, 1 do
         local current_item = keys.caster:GetItemInSlot(i)
         if current_item ~= nil then
             if current_item:GetName() == "item_eatable_gem" then
                 keys.caster:RemoveItem(current_item);
			end
		end
     end
	
	
end
