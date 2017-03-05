-- <talkaction words="!petheal" script="pet_heal.lua" />
function onSay(player, words, param, channel)
    local petUid = player:getPetUid()
    if petUid == PETS.CONSTANS.STATUS_DOESNT_EXIST then
        player:petSystemMessage("You don't have a pet!")

    elseif petUid == PETS.CONSTANS.STATUS_DEAD then
        player:petSystemMessage("Your pet is dead!")

    elseif petUid == PETS.CONSTANS.STATUS_OK then
        local lostHealth = player:getPetLostHealth()
        local soulNeded = PETS.CONFIG.healSoulBase + lostHealth * PETS.CONFIG.healSoulCost

        if lostHealth == 0 then
            player:petSystemMessage("Your pet doesn't need healing!")

        elseif player:getSoul() >= soulNeded then
            player:addSoul(-soulNeded)
            player:setPetLostHealth(0)

            player:petSystemMessage("You healed your pet ".. lostHealth .. " health, it cost you " .. soulNeded .." soul points.")
        else
            player:petSystemMessage("You need ".. soulNeded .." soul points!")

        end

    elseif petUid >= 0 then
        local pet = Creature(petUid)

        local lostHealth = pet:getMaxHealth() - pet:getHealth()
        local soulNeded = PETS.CONFIG.healSoulBase + lostHealth * PETS.CONFIG.healSoulCost

        if lostHealth == 0 then
            player:petSystemMessage("Your pet doesn't need healing!")

        elseif player:getSoul() >= soulNeded then
            player:addSoul(-soulNeded)
            pet:addHealth(lostHealth)

            player:petSystemMessage("You healed your pet ".. lostHealth .. " health, it cost " .. soulNeded .." soul points!")
        else
            player:petSystemMessage("You need ".. soulNeded .." soul points!")

        end
    end
    return true
end
