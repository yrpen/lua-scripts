-- <talkaction words="!petcatch" script="pet_catch.lua" />
function onSay(player, words, param, channel)
	local target = player:getTarget()
	local ropeId = 2120

	if player:getItemCount(ropeId) == 0 then
		player:petSystemMessage('You need rope to catch any monster.')
		return true
	end

	if player:getPetUid() > -1 then
		player:petSystemMessage("You have one pet!")
		return true
	end

	if not target or not target:isMonster() then
		player:petSystemMessage("You can catch only monsters!")
		return true
	end

	local targetMaster = target:getMaster()
	if targetMaster and targetMaster:isPlayer() then
		player:petSystemMessage("You can catch only wild monster.")
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
		player:petSystemMessage("You catched a " .. string.lower(mobName) .."!")
	else
		player:petSystemMessage("Try one more time!")
	end
	return true
end
