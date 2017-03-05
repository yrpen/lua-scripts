-- <talkaction words="!petrevive" script="pet_revive.lua" />
function onSay(player, words, param, channel)
    local petUid = player:getPetUid()
    if petUid == PETS.CONSTANS.STATUS_DOESNT_EXIST then
        player:petSystemMessage("You don't have a pet!")

    elseif petUid >= 0 then
        player:petSystemMessage("Your pet is still alive!")

    elseif petUid == PETS.CONSTANS.STATUS_DEAD then
        local petLevel = player:getPetLevel()
        local soulNeded = petLevel * PETS.CONFIG.reviveSoulLevelCost + PETS.CONFIG.reviveSoulBaseCost --PETS.SOULPERLVL
        soulNeded = soulNeded > 100 and 100 or soulNeded

        if player:getSoul() >= soulNeded then
            player:addSoul(-soulNeded)
            player:setPetUid(PETS.CONSTANS.STATUS_OK)
            player:setPetLostHealth(0)
            local playerPosition = player:getPosition()
            playerPosition:sendMagicEffect(CONST_ME_HOLYAREA)
            player:petSystemMessage("Your pet has been revived!")

        else
            player:petSystemMessage("You don't have enough soul points!")
        end
    end
    return true
end

