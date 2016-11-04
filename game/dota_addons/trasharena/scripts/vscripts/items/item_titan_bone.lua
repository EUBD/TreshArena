if item_titan_bone == nil then
	item_titan_bone = class({})
end

LinkLuaModifier("modifier_titan_bone_passive","items/item_titan_bone.lua",LUA_MODIFIER_MOTION_NONE)

function item_titan_bone:GetIntrinsicModifierName(  )
	return "modifier_titan_bone_passive"
end

--------------------

if modifier_titan_bone_passive == nil then
	modifier_titan_bone_passive = class({})
end

function modifier_titan_bone_passive:IsHidden(  )
	return true
end

function modifier_titan_bone_passive:GetAttribute(  )
	return MODIFIER_ATTRIBUTE_MULTIPLE 
end

function modifier_titan_bone_passive:IsPurgable(  )
	return false
end

function modifier_titan_bone_passive:DeclareFunctions(  )
	local hFuncs = { MODIFIER_PROPERTY_STATS_AGILITY_BONUS,MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,MODIFIER_EVENT_ON_ATTACK_LANDED }
	return hFuncs
end

function modifier_titan_bone_passive:OnCreated(  )
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	self.chance = ability:GetSpecialValueFor("chance")
	self.all = ability:GetSpecialValueFor("all")
	self.damage = ability:GetSpecialValueFor("damage")
	self.atk = ability:GetSpecialValueFor("atk")
end

function modifier_titan_bone_passive:OnAttackLanded( params )
	local caster = self:GetCaster()
	local ability = self:GetAbility()
	if caster:HasModifier("modifier_echotic_sabre_slow") or caster:HasModifier("modifier_alebard_traum") or caster:HasModifier("modifier_item_handed_sword_maim") or caster:HasModifier("modifier_katana_and_handed_maim") or caster:HasModifier("modifier_sange_maim") then
		caster:EmitSound("DOTA_Item.DiffusalBlade.Activate")
	end
		caster:RemoveModifierByName("modifier_echotic_sabre_slow")
		caster:RemoveModifierByName("modifier_alebard_traum")
		caster:RemoveModifierByName("modifier_item_handed_sword_maim")
		caster:RemoveModifierByName("modifier_katana_and_handed_maim")
		caster:RemoveModifierByName("modifier_sange_maim")
	end
end

function modifier_titan_bone_passive:GetModifierPreAttack_BonusDamage(  )
	return self.damage
end

function modifier_titan_bone_passive:GetModifierAttackSpeedBonus_Constant(  )
	return self.atk
end

function modifier_titan_bone_passive:GetModifierBonusStats_Strength(  )
	return self.all
end

function modifier_titan_bone_passive:GetModifierBonusStats_Intellect(  )
	return self.all
end

function modifier_titan_bone_passive:GetModifierBonusStats_Agility(  )
	return self.all
end