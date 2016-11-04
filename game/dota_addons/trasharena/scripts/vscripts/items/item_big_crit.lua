if item_big_crit == nil then
    item_big_crit = class({})
end

LinkLuaModifier("modifier_big_crit_passive","items/item_big_crit.lua",LUA_MODIFIER_MOTION_NONE)

function item_big_crit:GetIntrinsicModifierName(  )
	return "modifier_big_crit_passive"
end

--------------------------

if modifier_big_crit_passive == nil then
    modifier_big_crit_passive = class({})
end

function modifier_big_crit_passive:IsPurgable(  )
	return false
end

function modifier_big_crit_passive:GetAttributes(  )
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_big_crit_passive:IsHidden(  )
	return true
end

function modifier_big_crit_passive:DeclareFunctions(  )
	local funcs = { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE, MODIFIER_EVENT_ON_ATTACK_LANDED, MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE, MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
	return funcs
end

function modifier_big_crit_passive:OnAttackLanded(  )
	if RollPercentage(32) then
		self.apply = 1
	else
		self.apply = 0
	end
end

function modifier_big_crit_passive:GetModifierPreAttack_BonusDamage(  )
	return 189
end

function modifier_big_crit_passive:GetModifierAttackSpeedBonus_Constant(  )
	return 200
end

function modifier_big_crit_passive:GetModifierTotalDamageOutgoing_Percentage(  )
	return 1.6
end

function modifier_big_crit_passive:GetModifierPreAttack_CriticalStrike(  )
	local crit = 252

	if self.apply == 1 then
		crit = 252
	else
		return nil
	end
	return crit
end