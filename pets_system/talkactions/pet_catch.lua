-- <talkaction words="!petcatch" script="pet_catch.lua" />
function onSay(player, words, param, channel)
    local target = player:getTarget()
    local ropeId = 2120
    local petUid = player:getPetUid()

    if player:getItemCount(ropeId) == 0 then
        player:petSystemMessage('You need a rope to catch any monster.')
        return true
    end

    if petUid ~= PETS.CONSTANS.STATUS_DOESNT_EXIST and petUid ~= PETS.CONSTANS.STATUS_DEAD and petUid ~= PETS.CONSTANS.STATUS_MOUNT then
        player:petSystemMessage("You alredy have a pet!")
        return true
    end

    if not target or not target:isMonster() then
        player:petSystemMessage("You may only catch monsters!")
        return true
    end

    local targetMaster = target:getMaster()
    if targetMaster and targetMaster:isPlayer() then
        player:petSystemMessage("You may only catch wild monsters!")
        return true
    end

    -- addPetByName
    local mobName = ''
    local mobNumber = ''
    for number_, name_ in ipairs(PETS.IDENTIFICATION) do
        if name_.name == getCreatureName(target) then
            mobName = name_.name
            mobNumber = number_
            break
        end
    end

    if mobName == '' then
        player:petSystemMessage("You can't catch this monster.")
        return true
    end
    -- / addPetByName

    if not player:canGetPet(mobNumber) then
        player:petSystemMessage(PETS.IDENTIFICATION[mobNumber].info)
        return true
    end

    local catchChance = 1 + (1 - target:getHealth() / target:getMaxHealth() ) *100
    if catchChance >= math.random(100) then
        player:doResetPet()
        player:doAddPet(tonumber(mobNumber))
        player:setPetLostHealth(catchChance * player:getPetMaxHealth() / 100 )
        local targetPosition = target:getPosition()
        target:remove()
        targetPosition:sendMagicEffect(CONST_ME_POFF)
        player:petSystemMessage("You caught a " .. string.lower(mobName) .."!")
    else
        player:petSystemMessage("Try one more time!")
    end
    return true
end
