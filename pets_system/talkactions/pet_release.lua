-- <talkaction words="!petrelease" script="pet_release.lua" />
function onSay(player, words, param, channel)
    local petUid = player:getPetUid()
    if petUid >= 0 or petUid == PETS.CONSTANS.STATUS_DEAD then
        player:doRemovePet()
        player:doResetPet()
        player:petSystemMessage("You released your pet!")
    elseif petUid == -1 then
        player:petSystemMessage("You don't have a pet!")
    end
    return true
end

