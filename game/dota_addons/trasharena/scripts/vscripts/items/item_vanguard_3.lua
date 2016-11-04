if item_vanguard_3 == nil then
	item_vanguard_3 = class({})
end

LinkLuaModifier("modifier_item_vanguard_3", "items/item_vanguard_3.lua", LUA_MODIFIER_MOTION_NONE)

function item_vanguard_3:GetIntrinsicModifierName() 
	return "modifier_item_vanguard_3"
end

-------------------------

if modifier_item_vanguard_3 == nil then
	modifier_item_vanguard_3 = class({})
end

function modifier_item_vanguard_3:GetAttributes() 
	return MODIFIER_ATTRIBUTE_MULTIPLE + MODIFIER_ATTRIBUTE_PERMANENT 
end

function modifier_item_vanguard_3:IsHidden()
	return true 
end

function modifier_item_vanguard_3:IsPurgable(  )
	return false
end

function modifier_item_vanguard_3:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_CONSTANT_BLOCK,
		MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
		MODIFIER_PROPERTY_HEALTH_BONUS,
	}
 
	return funcs
end

function modifier_item_vanguard_3:OnCreated()
	self.blockDamage = self:GetAbility():GetLevelSpecialValueFor("damage_block",self:GetAbility():GetLevel())
	self.healthRegen = self:GetAbility():GetLevelSpecialValueFor("hp_regen",self:GetAbility():GetLevel())
	self.healthBonus = self:GetAbility():GetLevelSpecialValueFor("health",self:GetAbility():GetLevel())
end

function modifier_item_vanguard_3:OnRefresh()
	self.blockDamage = self:GetAbility():GetLevelSpecialValueFor("damage_block",self:GetAbility():GetLevel())
	self.healthRegen = self:GetAbility():GetLevelSpecialValueFor("hp_regen",self:GetAbility():GetLevel())
	self.healthBonus = self:GetAbility():GetLevelSpecialValueFor("health",self:GetAbility():GetLevel())
end

function modifier_item_vanguard_3:GetModifierConstantHealthRegen()
	return self.healthRegen
end

function modifier_item_vanguard_3:GetModifierHealthBonus()
	return self.healthBonus
end

function modifier_item_vanguard_3:GetModifierPhysical_ConstantBlock()
	return self.blockDamage 
end