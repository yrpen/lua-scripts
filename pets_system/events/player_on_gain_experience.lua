function Player:onGainExperience(source, exp, rawExp)
  if PETS and PETS.SYSTEM.PLAYER_SHARE_EXPERIENCE and self:getPetUid() > 0 and source and source:isMonster() then
    local pet_exp = exp * PETS.CONFIG.shareExpMultipler
    self:addPetExp(pet_exp)
  end

-- [...]
end
