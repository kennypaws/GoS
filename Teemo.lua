-- Menu -- 
if GetObjectName(myHero) ~= "Teemo" then return end

TeemoMenu = Menu("Polish Satan Teemo", "Polish Satan Teemo")
TeemoMenu:SubMenu("Combo", "Combo")
TeemoMenu.Combo:Boolean("Q", "Use Q", true)
TeemoMenu.Combo:Boolean("E", "Use E ", true)

TeemoMenu:SubMenu("Autolevel", "Auto Level")
TeemoMenu.Autolevel:Boolean("Autolvl", "Auto level", false)

TeemoMenu:SubMenu("Drawing", "Drawings")
TeemoMenu.Drawing:Boolean("Q", "Draw Q Range", true)

TeemoMenu:SubMenu("Killsteal", "Killsteal")
TeemoMenu.Killsteal:Boolean("Q", "Killsteal Q", true)

TeemoMenu:SubMenu("JungleSteal", "JungleSteal")
TeemoMenu.JungleSteal:Boolean("Q", "Use Q to Steal Dragon/Baron", true)


-- Start
PrintChat("Polish Satan Teemo Loaded")
PrintChat("Give Like or Teemo KILL YOU <hahaha>")
PrintChat("If you find any bugs, make sure to report them no topic")
PrintChat("by PureOfEnginer (old Krystian1)")
PrintChat("Have fun")

OnLoop(function(myHero)

    if IOW:Mode() == "Combo" then
    -- Locals --

    local myHero = GetMyHero()
    local target = GetCurrentTarget()
    local rangeQ = GetCastRange(myHero,_Q)
    local rangeE = GetCastRange(myHero,_E)
    local mouse = GetMousePos()

    -- end Local -- 

-- Teemo Q combo
    if TeemoMenu.Combo.Q:Value() then
        if CanUseSpell(myHero,_Q) == READY and GoS:IsInDistance(target, rangeQ) then
            CastTargetSpell(target,_Q)
        end
    end
-- Teemo E combo
    if TeemoMenu.Combo.E:Value() then
        if CanUseSpell(myHero,_E) == READY and GoS:IsInDistance(target, rangeE) then
            AttackUnit(target)
        end
    end
-- end Combo
-- Autolevel
    if TeemoMenu.Autolevel.Autolvl:Value() then

    if GetLevel(myHero) >= 1 and GetLevel(myHero) < 2 then
    LevelSpell(_E)
elseif GetLevel(myHero) >= 2 and GetLevel(myHero) < 3 then
    LevelSpell(_Q)
elseif GetLevel(myHero) >= 3 and GetLevel(myHero) < 4 then
    LevelSpell(_W)
elseif GetLevel(myHero) >= 4 and GetLevel(myHero) < 5 then
        LevelSpell(_E)
elseif GetLevel(myHero) >= 5 and GetLevel(myHero) < 6 then
        LevelSpell(_E)
elseif GetLevel(myHero) >= 6 and GetLevel(myHero) < 7 then
    LevelSpell(_R)
elseif GetLevel(myHero) >= 7 and GetLevel(myHero) < 8 then
    LevelSpell(_E)
elseif GetLevel(myHero) >= 8 and GetLevel(myHero) < 9 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 9 and GetLevel(myHero) < 10 then
        LevelSpell(_E)
elseif GetLevel(myHero) >= 10 and GetLevel(myHero) < 11 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 11 and GetLevel(myHero) < 12 then
        LevelSpell(_R)
elseif GetLevel(myHero) >= 12 and GetLevel(myHero) < 13 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 13 and GetLevel(myHero) < 14 then
        LevelSpell(_Q)
elseif GetLevel(myHero) >= 14 and GetLevel(myHero) < 15 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 15 and GetLevel(myHero) < 16 then
        LevelSpell(_W)
elseif GetLevel(myHero) >= 16 and GetLevel(myHero) < 17 then
        LevelSpell(_R)
elseif GetLevel(myHero) >= 17 and GetLevel(myHero) < 18 then
        LevelSpell(_W)
elseif GetLevel(myHero) == 18 then
        LevelSpell(_W)
    end
end
-- Misc 
-- Drawing 
   if TeemoMenu.Drawing.Q:Value() then
                       
        DrawCircle(GoS:myHeroPos().x,GoS:myHeroPos().y,GoS:myHeroPos().z,GetCastRange(myHero,_Q),3,100,0xff00ff00)                    
    end
end
-- Killsteal local
    for i,enemy in pairs(GoS:GetEnemyHeroes()) do

    local QKill = 45 + 45*GetCastLevel(myHero,_Q) + 0.8*GetBonusAP(myHero) 

-- Ludens Echo Bonus DMG -- (code Rakli thanks)

    local Ludens = 0
        if GotBuff(myHero, "itemmagicshankcharge") > 99 then
            Ludens = Ludens + 0.1*GetBonusAP(myHero) + 100
        end 
-- Killsteal code
    if IsObjectAlive(enemy) and not IsImmune(enemy) and IsTargetable(enemy) then
    if CanUseSpell(myHero,_Q) == READY and TeemoMenu.Killsteal.Q:Value() and GoS:ValidTarget (enemy, GetCastRange(myHero, _Q)) and GoS:CalcDamage (myHero, enemy, 0, QKill + Ludens) > GetCurrentHP(enemy) + GetHPRegen(enemy) + GetMagicShield(enemy) + GetDmgShield(enemy) then
        CastTargetSpell(enemy,_Q)
    end
-- JungleSteal
    for i,bigmobs in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
    local BigMobPos = GetOrigin(bigmobs)

        if GoS:ValidTarget(bigmobs, rangeQ) and GoS:GetDistance(bigmobs) < rangeQ then 
            if CanUseSpell(myHero, _Q) == READY and  GoS:CalcDamage(myHero, bigmobs, 0, myDamage + Ludens) > GetCurrentHP(bigmobs) and GetObjectName(bigmobs) == "SRU_Baron" and TeemoMenu.JungleSteal.Q:Value() then
                CastSkillShot(_Q,BigMobPos.x,BigMobPos.y,BigMobPos.z)
            elseif CanUseSpell(myHero, _Q) == READY and  GoS:CalcDamage(myHero, bigmobs, 0, myDamage + Ludens) > GetCurrentHP(bigmobs) and GetObjectName(bigmobs) == "SRU_Dragon" and TeemoMenu.JungleSteal.Q:Value() then
                CastSkillShot(_Q,BigMobPos.x,BigMobPos.y,BigMobPos.z)
            end
        end
-- Ready Spells ;3
    SpellQREADY = CanUseSpell(myHero,_Q) == READY
    SpellWREADY = CanUseSpell(myHero,_W) == READY
    SpellEREADY = CanUseSpell(myHero,_E) == READY
    SpellRREADY = CanUseSpell(myHero,_R) == READY
    SpellIREADY = CanUseSpell(myHero,Ignite) == READY
end
end
end
end)
