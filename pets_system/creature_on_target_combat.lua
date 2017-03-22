function Creature:onTargetCombat(target)
    if PETS and PETS.SYSTEM.DUELS_ONLY then
        if self:isPet() and target:isPlayer() or target:isPet() and self:isPlayer() then
            return false
        end
    end
    return true
end
