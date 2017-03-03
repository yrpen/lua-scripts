-- <event type="preparedeath" name="PetDeath" script="pet_creaturescript.lua" />
-- <event type="kill" name="PetKill" script="pet_creaturescript.lua" />

function onPrepareDeath(creature, killer)
	local player = creature:getMaster()
	if player then
		player:setPetUid(-2)
		player:setPetLostHealth(0)
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


