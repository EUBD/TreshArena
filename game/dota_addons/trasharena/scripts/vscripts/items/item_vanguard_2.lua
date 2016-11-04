if item_vanguard_2 == nil then
	item_vanguard_2 = class({})
end

LinkLuaModifier("modifier_item_vanguard_2", "items/item_vanguard_2.lua", LUA_MODIFIER_MOTION_NONE)

function item_vanguard_2:GetIntrinsicModifierName() 
	return "modifier_item_vanguard_2"
end

-----------------------

if modifier_item_vanguard_2 == nil then
	modifier_item_vanguard_2 = class({})
end

function modifier_item_vanguard_2:GetAttributes() 
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT 
end

function modifier_item_vanguard_2:IsHidden()
	return true 
end

function modifier_item_vanguard_2:IsPurgable(  )
	return false
end

function modifier_item_vanguard_2:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_BONUS
	} 
	return funcs
end

function modifier_item_vanguard_2:OnCreated()
	self.blockDamage = self:GetAbility():GetLevelSpecialValueFor("damage_block",self:GetAbility():GetLevel())
	self.healthRegen = self:GetAbility():GetLevelSpecialValueFor("hp_regen",self:GetAbility():GetLevel())
	self.healthBonus = self:GetAbility():GetLevelSpecialValueFor("health",self:GetAbility():GetLevel())
end

function modifier_item_vanguard_2:OnRefresh()
	self.blockDamage = self:GetAbility():GetLevelSpecialValueFor("damage_block",self:GetAbility():GetLevel())
	self.healthRegen = self:GetAbility():GetLevelSpecialValueFor("hp_regen",self:GetAbility():GetLevel())
	self.healthBonus = self:GetAbility():GetLevelSpecialValueFor("health",self:GetAbility():GetLevel())
end

function modifier_item_vanguard_2:GetModifierConstantHealthRegen()
	return self.healthRegen
end

function modifier_item_vanguard_2:GetModifierHealthBonus()
	return self.healthBonus
end

function modifier_item_vanguard_2:GetModifierPhysical_ConstantBlock()
	return self.blockDamage 
end