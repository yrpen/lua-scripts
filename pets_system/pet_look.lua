function Player:onLook(thing, position, distance)
    if thing:isCreature() and thing:isMonster() then
        local owner = thing:getMaster()

        if owner ~= nil and owner:isPlayer() and thing:getId() == owner:getPetUid() then
            local playerName = (owner:getId() == self:getId()) and "you" or owner:getName()
            local description = "You see a ".. thing:getName() ..", it's belongs to "..playerName.."."

            if self:getGroup():getAccess() or playerName == 'you' then
                description = string.format("%s\nHealth: %d / %d", description, thing:getHealth(), thing:getMaxHealth()) .. "."
                description = string.format("%s\nLvl: %d, Exp: %d", description, owner:getPetLevel(), owner:getPetExperience()) .. "."

                if PETS.SYSTEM.MOUNTS then
                    local mountId = self:getPetMountId()
                    if mountId ~= nil and mountId ~= 0 then
                        description = string.format("%s\nHe can serve as mount.", description)
                    end
                end
            end

            if self:getGroup():getAccess() then
                local position = thing:getPosition()
                description = string.format("%s\nPosition: %d, %d, %d", description, position.x, position.y, position.z)
            end
            self:sendTextMessage(MESSAGE_INFO_DESCR, description)
            return false
        end
    end

    ---- ... rest part of onLook script
end
