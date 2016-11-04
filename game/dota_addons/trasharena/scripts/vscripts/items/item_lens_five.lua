if item_lens_five == nil then item_lens_five = class({}) end

LinkLuaModifier("modifier_lens_five_passive","items/item_lens_five.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_lens_five_act","items/item_lens_five.lua",LUA_MODIFIER_MOTION_NONE)

function item_lens_five:GetIntrinsicModifierName(  )
	return "modifier_lens_five_passive"
end

function item_lens_five:OnSpellStart(  )
	caster = self:GetCaster()
	if not caster:IsMagicImmune() then
		caster:AddNewModifier(caster,self,"modifier_lens_five_act",{duration = self:GetSpecialValueFor("duration")})
		caster:EmitSound("Hero_FacelessVoid.TimeLockImpact")
	end
end

if modifier_lens_five_passive == nil then modifier_lens_five_passive = class({}) end

function modifier_lens_five_passive:IsPurgable(  )
	return false
end

function modifier_lens_five_passive:IsHidden(  )
	return true
end

function modifier_lens_five_passive:GetAttributes(  )
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_lens_five_passive:OnDestroy(  )
	self:GetCaster():RemoveModifierByName("modifier_lens_five_act")
end

function modifier_lens_five_passive:OnCreated(  )
	_G.modifier_lens_five_passive_chance = self:GetAbility():GetSpecialValueFor("chance")
	_G.modifier_lens_five_passive_mult = self:GetAbility():GetSpecialValueFor("mult")
	_G.modifier_lens_five_passive_amp = self:GetAbility():GetSpecialValueFor("spell_amp")
end

function modifier_lens_five_passive:DeclareFunctions(  )
	return {MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,MODIFIER_PROPERTY_CAST_RANGE_BONUS,MODIFIER_PROPERTY_MANA_BONUS,MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT}
end

function modifier_lens_five_passive:GetModifierManaBonus(  )
	return self:GetAbility():GetSpecialValueFor("bonus_mana")
end

function modifier_lens_five_passive:GetModifierBonusStats_Intellect(  )
	return self:GetAbility():GetSpecialValueFor("int")
end

function modifier_lens_five_passive:GetModifierConstantHealthRegen(  )
	return self:GetAbility():GetSpecialValueFor("bonus_health_regen")
end

function modifier_lens_five_passive:GetModifierCastRangeBonus(  )
	return self:GetAbility():GetSpecialValueFor("cast_range_bonus")
end

if modifier_lens_five_act == nil then modifier_lens_five_act = class({}) end

function modifier_lens_five_act:GetTexture(  )
	return "item_lens_five"
end

function modifier_lens_five_act:IsPurgable(  )
	return false
end

function modifier_lens_five_act:DeclareFunctions(  )
	return {MODIFIER_PROPERTY_MANA_REGEN_CONSTANT,MODIFIER_PROPERTY_STATS_INTELLECT_BONUS}
end

function modifier_lens_five_act:GetModifierBonusStats_Intellect(  )
	return self:GetAbility():GetSpecialValueFor("int_act")
end

function modifier_lens_five_act:GetModifierConstantManaRegen(  )
	return self:GetAbility():GetSpecialValueFor("mana_regen")
end