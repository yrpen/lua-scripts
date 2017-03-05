-- <event type="login" name="PetOwnerLogin" script="pet_owner_creaturescripts.lua" />
-- <event type="logout" name="PetOwnerLogout" script="pet_owner_creaturescripts.lua" />
-- <event type="preparedeath" name="PetOwnerDeath" script="pet_owner_creaturescripts.lua" />

function onLogin(player)
    for _, event in pairs({"PetOwnerLogout", "PetOwnerDeath"}) do
        player:registerEvent(event)
    end
    player:openChannel(PETS.CHANNELID)
    return true
end

function onLogout(player)
    return player:doRemovePet()
end

function onPrepareDeath(creature, killer)
    local petUid = creature:getPetUid()
    local pet = Creature(petUid)
    if pet and pet:isCreature() then
        creature:doKillPet(true)
    end
    return true
end

