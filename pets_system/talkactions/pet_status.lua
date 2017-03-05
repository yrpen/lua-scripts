-- <talkaction words="!petinfo" script="pet_status.lua" />
function onSay(player, words, param, channel)
    local petUid = player:getPetUid()
    local text = ''
    if petUid == nil or petUid == PETS.CONSTANS.STATUS_DOESNT_EXIST then
        text = "You don't have a pet."
    elseif petUid == PETS.CONSTANS.STATUS_DEAD then
        text = "Your pet is dead."
    else
        local pet = Creature(petUid)
        if pet ~= nil and pet:isCreature() then
            text = "\n Type: "..pet:getName()..
            " \n Health: "..pet:getHealth().."/"..pet:getMaxHealth()..
            " \n Exp: "..player:getPetExperience()..
            "\n Lvl: "..player:getPetLevel()
        else
            text = "Your pet is offline."
        end
    end
    player:petSystemMessage(text)
    return true
end
    
