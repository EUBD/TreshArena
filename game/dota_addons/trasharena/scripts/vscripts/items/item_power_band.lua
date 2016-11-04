if item_power_band == nil then item_power_band = class({}) end

LinkLuaModifier("modifier_power_band_passive","items/item_power_band.lua",LUA_MODIFIER_MOTION_NONE)

function item_power_band:OnSpellStart(  )
	local caster = self:GetCaster()
	local hendl = ""
	local all = self:GetSpecialValueFor("all_act")
	
	

	for i=0,5 do
		hendl = caster:GetItemInSlot(i)
		if hendl and hendl:GetName() == "item_power_band" then
			caster:ModifyAgility(all)
			caster:ModifyIntellect(all)
			caster:ModifyStrength(all)
			caster:RemoveItem(hendl)
			break
		end
	end
end

function item_power_band:IsRefreshable()
	return false
end

function item_power_band:GetIntrinsicModifierName(  )
	return "modifier_power_band_passive"
end

if modifier_power_band_passive == nil then modifier_power_band_passive = class({}) end

function modifier_power_band_passive:IsHidden(  )
	return true
end

function modifier_power_band_passive:IsPurgable(  )
	return false
end

function modifier_power_band_passive:DeclareFunctions(  )
	return {MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,MODIFIER_PROPERTY_STATS_AGILITY_BONUS,MODIFIER_PROPERTY_STATS_STRENGTH_BONUS}
end

function modifier_power_band_passive:GetModifierBonusStats_Strength(  )
	return self:GetAbility():GetSpecialValueFor("all")
end

function modifier_power_band_passive:GetModifierBonusStats_Agility(  )
	return self:GetAbility():GetSpecialValueFor("all")
end

function modifier_power_band_passive:GetModifierBonusStats_Intellect(  )
	return self:GetAbility():GetSpecialValueFor("all")
end