local direction =
{
    ["north"] = DIRECTION_NORTH,
    ["east"] = DIRECTION_EAST,
    ["south"] = DIRECTION_SOUTH,
    ["west"] = DIRECTION_WEST,
    ["southwest"] = DIRECTION_SOUTHWEST,
    ["southeast"] = DIRECTION_SOUTHEAST,
    ["northwest"] = DIRECTION_NORTHWEST,
    ["northeast"] = DIRECTION_NORTHEAST
}

-- -- creature:teleportTo(Position(), false)
-- -- :getMana() getMaxMana() addMana()
-- -- player:setMaxMana(maxMana)

if param[1]:lower() == "move" then
  local pet = getPlayerPet(cid)
  if not pet then
    return doPlayerSendCancel(cid, "Please call your pet first.")
  end
  if not param[2] or param[2] == "" then
    return doPlayerSendCancel(cid, "Command param required.")
  end
 
  if exhaustion.get(cid, petStorages.moveExhaust) then
    return doPlayerSendCancel(cid, "You are exhausted.") and doSendMagicEffect(getCreaturePosition(getCreatureSummons(cid)[1]), CONST_ME_POFF)
  end
 
  local dir
  if l[param[2]:lower()] then
    dir = l[param[2]:lower()]
    local toPos = getPosByDir(getCreaturePosition(pet), dir, 1)
    local ret = queryTileAddThing(pet, toPos)
    if ret == RETURNVALUE_NOERROR then
      doMoveCreature(pet, dir)
      exhaustion.set(cid, petStorages.moveExhaust, petExhaust)
    else
      return doPlayerSendCancel(cid, "There is not enough room.") and doSendMagicEffect(getCreaturePosition(pet), CONST_ME_POFF)
    end
  else
    return doPlayerSendCancel(cid, "No direction specified.")
  end
end
