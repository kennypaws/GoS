local myHero = GetMyHero()
if GetObjectName(myHero) ~= "Jhin" then return end
require('Inspired')
require('DamageLib')
PrintChat("High Noon Jhin v1.0.0 Loaded.")
PrintChat("by OnlyKatarina Have Fun:  " ..GetObjectBaseName(myHero))
local mainMenu = Menu("High Noon Jhin", "High Noon Jhin")
mainMenu:Menu("Combo", "Combo")
mainMenu.Combo:Boolean("useQ", "Use Q", true)
mainMenu.Combo:Boolean("useW", "Use W If Enemy Is Marked", true)
mainMenu.Combo:Boolean("useE", "Use E", true)
mainMenu.Combo:Key("Combo1", "Combo", string.byte(" "))
------------------------------------------------------
mainMenu:Menu("Killsteal", "Killsteal")
mainMenu.Killsteal:Boolean("ksQ", "Use Q - KS", true)
mainMenu.Killsteal:Boolean("ksW", "Use W - KS", true)
------------------------------------------------------
mainMenu:Menu("Items", "Items")
mainMenu.Items:Boolean("useCut", "Bilgewater Cutlass", true)
mainMenu.Items:Boolean("useBork", "Blade of the Ruined King", true)
mainMenu.Items:Boolean("useGhost", "Youmuu's Ghostblade", true)
mainMenu.Items:Boolean("useRedPot", "Elixir of Wrath", true)
------------------------------------------------------
mainMenu:Menu("Drawings", "Drawings")
mainMenu.Drawings:Boolean("drawQ", "Draw Q", true)
mainMenu.Drawings:Boolean("drawW", "Draw W", true)
mainMenu.Drawings:Boolean("drawE", "Draw E", true)

local IsMarked = false

OnUpdateBuff(function(Object,buff) 
if buff.Name == "jhinespotteddebuff" then
IsMarked = true
else
	IsMarked = false
end
	end)

OnDraw(function(myHero) 
local pos = GetOrigin(myHero)
if mainMenu.Drawings.drawQ:Value() then DrawCircle(pos,550,1,25,GoS.Pink) end
if mainMenu.Drawings.drawW:Value() then DrawCircle(pos,3000,1,25,GoS.Red) end
if mainMenu.Drawings.drawE:Value() then DrawCircle(pos,750,1,25,GoS.Black) end
	end)


OnTick(function(myHero) 
local target = GetCurrentTarget()
local CutBlade = GetItemSlot(myHero,3144)
local bork = GetItemSlot(myHero,3153)
local ghost = GetItemSlot(myHero,3142)
local useQ = mainMenu.Combo.useQ:Value()
local useW = mainMenu.Combo.useW:Value()
local useE = mainMenu.Combo.useE:Value()
local ksQ = mainMenu.Killsteal.ksQ:Value()
local ksW = mainMenu.Killsteal.ksW:Value()
local myHeroPos = GetOrigin(myHero)
if ksQ and CanUseSpell(myHero,_Q) == READY and GetHP(target) < getdmg("Q", target) and ValidTarget(target, 550) then
CastTargetSpell(target, _Q)
	end
if ksW and CanUseSpell(myHero,_W) == READY and GetHP(target) < getdmg("W", target) and ValidTarget(target, 3000) then
CastTargetSpell(target, _W)
	end
if mainMenu.Combo.Combo1:Value() then
if CutBlade >= 1 and ValidTarget(target,550+50) and mainMenu.Items.useCut:Value() then
		if CanUseSpell(myHero,GetItemSlot(myHero,3144)) == READY then
			CastTargetSpell(target, GetItemSlot(myHero,3144))
		end	
	elseif bork >= 1 and ValidTarget(target,550+50) and mainMenu.Items.useBork:Value() then 
		if CanUseSpell(myHero,GetItemSlot(myHero,3153)) == READY then
			CastTargetSpell(target,GetItemSlot(myHero,3153))
		end
	end

	if ghost >= 1 and ValidTarget(target,GetRange(myHero)+50) and mainMenu.Items.useGhost:Value() then
		if CanUseSpell(myHero,GetItemSlot(myHero,3142)) == READY then
			CastSpell(GetItemSlot(myHero,3142))
		end
	end
if useQ and CanUseSpell(myHero,_Q) == READY and GetBuffData(myHero, "JhinPassiveReload") and ValidTarget(target, 550) then
CastTargetSpell(target, _Q)
end
if useW and CanUseSpell(myHero,_E) == READY and GetBuffData(myHero, "JhinPassiveReload") and ValidTarget(target, 750) then
CastTargetSpell(target, _E)
end
if mainMenu.Combo.useW:Value() then
if IsMarked == true and CanUseSpell(myHero,_W) == READY and ValidTarget(target, 3000) then
local WPred = GetPredictionForPlayer(myHeroPos,target,GetMoveSpeed(target),1400,250,940,220,false,true)
		if WPred.HitChance == 1 then
			CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
	end
elseif CanUseSpell(myHero,_W) == READY and ValidTarget(target, 3000) then
local WPred = GetPredictionForPlayer(myHeroPos,target,GetMoveSpeed(target),1400,250,940,220,false,true)
		if WPred.HitChance == 1 then
			CastSkillShot(_W,WPred.PredPos.x,WPred.PredPos.y,WPred.PredPos.z)
		end
end
end
	end)