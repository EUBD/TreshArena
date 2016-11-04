if item_doebalus == nil then
    item_doebalus = class({})
end

LinkLuaModifier("modifier_doebalus_passive","items/item_doebalus.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_doebalus_bash","items/item_doebalus.lua",LUA_MODIFIER_MOTION_NONE)

function item_doebalus:GetIntrinsicModifierName(  )
	return "modifier_doebalus_passive"
end

--------------------------

if modifier_doebalus_passive == nil then
    modifier_doebalus_passive = class({})
end

function modifier_doebalus_passive:IsPurgable(  )
	return false
end

function modifier_doebalus_passive:GetAttributes(  )
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_doebalus_passive:IsHidden(  )
	return true
end

function modifier_doebalus_passive:DeclareFunctions(  )
	local funcs = { MODIFIER_PROPERTY_TOTALDAMAGEOUTGOING_PERCENTAGE, MODIFIER_EVENT_ON_ATTACK_LANDED, MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE, MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE, MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT }
	return funcs
end

function modifier_doebalus_passive:OnAttackLanded( params )
	if IsServer() then
		if RollPercentage(32) and params.attacker == self:GetParent() then
			self.apply = 1
		else
			self.apply = 0
		end

		if RollPercentage(35) and params.attacker == self:GetParent() then
			local target = self:GetParent():GetAttackTarget()
			target:AddNewModifier(self:GetParent(),self:GetAbility(),"modifier_doebalus_bash",{duration = 0.02})
			ApplyDamage({victim = target, attacker = self:GetParent(), damage = 180, damage_type = DAMAGE_TYPE_PHYSICAL})
		end
	end
end

function modifier_doebalus_passive:GetModifierPreAttack_BonusDamage(  )
	return 605
end

function modifier_doebalus_passive:GetModifierAttackSpeedBonus_Constant(  )
	return 220
end

function modifier_doebalus_passive:GetModifierTotalDamageOutgoing_Percentage(  )
	return 2.6
end

function modifier_doebalus_passive:GetModifierPreAttack_CriticalStrike(  )
	local crit = 302

	if self.apply == 1 then
		crit = 302
	else
		return nil
	end
	return crit
end

------------------------------

if modifier_doebalus_bash == nil then
	modifier_doebalus_bash = class({})
end

function modifier_doebalus_bash:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end
 
function modifier_doebalus_bash:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_doebalus_bash:IsDebuff()
	return true
end

function modifier_doebalus_bash:IsStunDebuff()
	return true
end

function modifier_doebalus_bash:GetTexture()
	return "item_doebalus"
end

function modifier_doebalus_bash:CheckState()
	local states = { [MODIFIER_STATE_STUNNED] = true }
	return states
end

function modifier_doebalus_bash:DeclareFunctions()
	local funcs = { MODIFIER_PROPERTY_OVERRIDE_ANIMATION }
	return funcs
end

function modifier_doebalus_bash:GetOverrideAnimation( params )
	return ACT_DOTA_DISABLED
end