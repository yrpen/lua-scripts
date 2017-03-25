-- <event type="preparedeath" name="PetDeath" script="pet_creaturescript.lua" />
-- <event type="kill" name="PetKill" script="pet_creaturescript.lua" />
-- <event type="think" name="PetTeleport" script="pet_creaturescript.lua" />
-- <event type="healthchange" name="PetHealthChange" script="pet_creaturescript.lua" />

function onPrepareDeath(creature, killer)
    local player = creature:getMaster()
    if player then
        player:doKillPet(false)
        player:petSystemMessage("Your pet has died.")
    end
    return true
end

function onKill(creature, target)
    if target:isMonster() then
        local player = creature:getMaster()
        local experience = (target:getType()):getExperience()
        player:addPetExp(experience)
    end
    return true
end

function onThink(creature, interval)
    local maxDistance = 7
    local owner = creature:getMaster()

    local petPosition = creature:getPosition()
    local ownerPosition = owner:getPosition()

    local tile = owner:getTile()

    if tile:hasFlag(TILESTATE_PROTECTIONZONE) then
        owner:doRemovePet()
    else
        if petPosition.z ~= ownerPosition.z or ownerPosition:getDistance(petPosition) >= maxDistance then
            petPosition:sendMagicEffect(CONST_ME_TELEPORT)
            creature:teleportTo(ownerPosition)
            creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
        end

    end
    return true
end

function onHealthChange(creature, attacker, primaryDamage, primaryType, secondaryDamage, secondaryType, origin)
    if attacker and attacker:isPlayer() then
        return 0, primaryType, 0, secondaryType
    end

    return primaryDamage, primaryType, secondaryDamage, secondaryType
end
