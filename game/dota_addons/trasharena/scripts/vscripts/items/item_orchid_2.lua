if item_orchid_2 == nil then
	item_orchid_2 = class({})
end

LinkLuaModifier("modifier_orchid_passive","items/item_orchid_2.lua",LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_orchid_silence","items/item_orchid_2.lua",LUA_MODIFIER_MOTION_NONE)

function item_orchid_2:GetIntrinsicModifierName(  )
	return "modifier_orchid_passive"
end

function item_orchid_2:OnSpellStart(  )
	local target = self:GetCursorTarget()
	local caster = self:GetCaster()

	target:AddNewModifier(caster,self,"modifier_orchid_silence",{duration = self:GetLevelSpecialValueFor("duration",self:GetLevel())})
end

-------------------------

if modifier_orchid_passive == nil then
	modifier_orchid_passive = class({})
end

function modifier_orchid_passive:IsPurgable(  )
	return false
end

function modifier_orchid_passive:IsHidden(  )
	return true
end

function modifier_orchid_passive:GetAttributes(  )
	return MODIFIER_ATTRIBUTE_MULTIPLE
end

function modifier_orchid_passive:OnCreated(  )
	self.damage = self:GetAbility():GetLevelSpecialValueFor("damage",self:GetAbility():GetLevel())
	self.atk = self:GetAbility():GetLevelSpecialValueFor("atk",self:GetAbility():GetLevel())
	self.int = self:GetAbility():GetLevelSpecialValueFor("int",self:GetAbility():GetLevel())
	self.mana_regen = self:GetAbility():GetLevelSpecialValueFor("mana_regen",self:GetAbility():GetLevel())
end

function modifier_orchid_passive:OnRefresh(  )
	self.damage = self:GetAbility():GetLevelSpecialValueFor("damage",self:GetAbility():GetLevel())
	self.atk = self:GetAbility():GetLevelSpecialValueFor("atk",self:GetAbility():GetLevel())
	self.int = self:GetAbility():GetLevelSpecialValueFor("int",self:GetAbility():GetLevel())
	self.mana_regen = self:GetAbility():GetLevelSpecialValueFor("mana_regen",self:GetAbility():GetLevel())
end

function modifier_orchid_passive:DeclareFunctions(  )
	local funcs = { MODIFIER_PROPERTY_STATS_INTELLECT_BONUS, MODIFIER_PROPERTY_MANA_REGEN_PERCENTAGE, MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT, MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE }
	return funcs
end

function modifier_orchid_passive:GetModifierPreAttack_BonusDamage(  )
	return self.damage
end

function modifier_orchid_passive:GetModifierAttackSpeedBonus_Constant(  )
	return self.atk
end

function modifier_orchid_passive:GetModifierPercentageManaRegen(  )
	return self.mana_regen
end

function modifier_orchid_passive:GetModifierBonusStats_Intellect(  )
	return self.int
end

----------------------------

if modifier_orchid_silence == nil then
	modifier_orchid_silence = class({})
end

function modifier_orchid_silence:OnCreated(  )
	self.damage_burn = self:GetAbility():GetLevelSpecialValueFor("damage_s",self:GetAbility():GetLevel())
end

function modifier_orchid_silence:OnRefresh(  )
	self.damage_burn = self:GetAbility():GetLevelSpecialValueFor("damage_s",self:GetAbility():GetLevel())
end

function modifier_orchid_silence:IsDebuff(  )
	return true
end

function modifier_orchid_silence:GetTexture(  )
	return "item_orchid_2"
end

function modifier_orchid_silence:DeclareFunctions()
	local funcs = { MODIFIER_EVENT_ON_TAKEDAMAGE, MODIFIER_PROPERTY_TOOLTIP }
	return funcs
end

function modifier_orchid_silence:OnTakeDamage(event)
	local damage = event.damage
	local attacker = self:GetParent()
	local ability = self:GetAbility()
	local caster = ability:GetCaster()

	self.soul_damage = self.soul_damage or 0
	self.soul_damage = self.soul_damage + damage
end

function modifier_orchid_silence:OnDestroy()
	if IsServer() then
		local ability = self:GetAbility()
		local caster = ability:GetCaster()

		ApplyDamage({ victim = self:GetParent(), attacker = self:GetAbility():GetCaster(), damage = self.soul_damage * 0.4, damage_type = DAMAGE_TYPE_MAGICAL }) 
	end
end

function modifier_orchid_silence:OnTooltip()
	return self.soul_damage
end

function modifier_orchid_silence:IsDebuff()
	return true
end

function modifier_orchid_silence:IsPurgable()
	return false
end

function modifier_orchid_silence:GetEffectName()
	return "particles/econ/items/silencer/silencer_ti6/silencer_last_word_ti6_silence.vpcf"
end

function modifier_orchid_silence:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end

function modifier_orchid_silence:CheckState()
	local states = { [MODIFIER_STATE_SILENCED] = true }
	return states
end