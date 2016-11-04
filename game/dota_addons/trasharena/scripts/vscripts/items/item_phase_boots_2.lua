if item_phase_boots_2 == nil then
	item_phase_boots_2 = class({})
end

LinkLuaModifier("modifier_phase_boots_2","items/item_phase_boots_2.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_phase_boots_2_active","items/item_phase_boots_2.lua",LUA_MODIFIER_MOTION_NONE)

function item_phase_boots_2:GetIntrinsicModifierName(  )
	return "modifier_phase_boots_2"
end

function item_phase_boots_2:OnSpellStart(  )
	self:GetCaster():EmitSound("DOTA_Item.PhaseBoots.Activate")
	self:GetCaster():AddNewModifier(self:GetCaster(),self,"modifier_phase_boots_2_active",{duration = self:GetSpecialValueFor("duration")})
end

--------------------------------

if modifier_phase_boots_2 == nil then
	modifier_phase_boots_2 = class({})
end

function modifier_phase_boots_2:IsPurgable(  )
	return false
end

function modifier_phase_boots_2:GetAttributes(  )
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_phase_boots_2:OnCreated(  )
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.movespeed_pas = self:GetAbility():GetSpecialValueFor("movespeed")
end

function modifier_phase_boots_2:OnRefresh(  )
	self.damage = self:GetAbility():GetSpecialValueFor("damage")
	self.movespeed_pas = self:GetAbility():GetSpecialValueFor("movespeed")
end

function modifier_phase_boots_2:IsHidden(  )
	return true
end

function modifier_phase_boots_2:DeclareFunctions(  )
	local funcs = { MODIFIER_PROPERTY_MOVESPEED_BONUS_UNIQUE, MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE }
	return funcs
end

function modifier_phase_boots_2:GetModifierPreAttack_BonusDamage(  )
	return self.damage
end

function modifier_phase_boots_2:GetModifierMoveSpeedBonus_Special_Boots(  )
	return self.movespeed_pas
end

-------------------------------

if modifier_phase_boots_2_active == nil then
	modifier_phase_boots_2_active = class({})
end

function modifier_phase_boots_2_active:DeclareFunctions(  )
	local funcs = { MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE_UNIQUE }
	return funcs 
end

function modifier_phase_boots_2_active:OnCreated(  )
	local caster = self:GetParent()

	self.movespeed_active 		= self:GetAbility():GetSpecialValueFor("movespeed_active")
	self.movespeed_active_range	= self:GetAbility():GetSpecialValueFor("movespeed_active_range")

	caster:SetMoveCapability(DOTA_UNIT_CAP_MOVE_FLY)
end

function modifier_phase_boots_2_active:OnRefresh(  )
	local caster = self:GetParent()

	caster:SetMoveCapability(DOTA_UNIT_CAP_MOVE_FLY)
end

function modifier_phase_boots_2_active:OnDestroy(  )
	local caster = self:GetParent()
	caster:SetMoveCapability(DOTA_UNIT_CAP_MOVE_GROUND)

	if IsClient() then ClientLoadGridNav() end
	GridNav:DestroyTreesAroundPoint(caster:GetAbsOrigin(), 192, true)
	if IsServer() then FindClearSpaceForUnit(caster, caster:GetAbsOrigin(), true) end
end

function modifier_phase_boots_2_active:GetTexture(  )
	return "item_phase_boots_2"
end

function modifier_phase_boots_2_active:GetEffectName(  )
	return "particles/items2_fx/phase_boots.vpcf"
end

function modifier_phase_boots_2_active:GetModifierMoveSpeedBonus_Percentage_Unique(  )
	if IsServer() then
		if self:GetParent():GetAttackCapability() == DOTA_UNIT_CAP_MELEE_ATTACK then
			return self.movespeed_active
		elseif self:GetParent():GetAttackCapability() == DOTA_UNIT_CAP_RANGED_ATTACK then
			return self.movespeed_active_range
		end
	end
end