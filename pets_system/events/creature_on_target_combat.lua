function Creature:onTargetCombat(target)
    if PETS and PETS.SYSTEM.DUELS_ONLY then
        if self:isPet() and target:isPlayer() then
            return false
        end
    end
    return true
end
