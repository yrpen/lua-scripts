-- <talkaction words="!petheal" script="pet_heal.lua" />
function onSay(player, words, param, channel)
	local petUid = player:getPetUid()
	if petUid == -1 then
		player:petSystemMessage("You don't have a pet!")

	elseif petUid == -2 then
		player:petSystemMessage("Your pet is death!")

	elseif petUid == 0 then
		local lostHealth = player:getPetLostHealth()
		local soulNeded = PETS.CONFIG.healSoulBase + lostHealth * PETS.CONFIG.healSoulCost

		if lostHealth == 0 then
			player:petSystemMessage("Your don't need healing!")

		elseif player:getSoul() >= soulNeded then
			player:addSoul(-soulNeded)
			player:setPetLostHealth(0)

			player:petSystemMessage("You healed pet ".. lostHealth .. " health, it cost " .. soulNeded .." soul points.")
		else
			player:petSystemMessage("You don't have ".. soulNeded .." soul points!")

		end

	elseif petUid >= 0 then
		local pet = Creature(petUid)

		local lostHealth = pet:getMaxHealth() - pet:getHealth()
		local soulNeded = PETS.CONFIG.healSoulBase + lostHealth * PETS.CONFIG.healSoulCost

		if lostHealth == 0 then
			player:petSystemMessage("Your don't need healing!")

		elseif player:getSoul() >= soulNeded then
			player:addSoul(-soulNeded)
			pet:addHealth(lostHealth)

			player:petSystemMessage("You healed pet ".. lostHealth .. " health, it cost " .. soulNeded .." soul points.")
		else
			player:petSystemMessage("You don't have ".. soulNeded .." soul points!")

		end
	end
	return true
end
