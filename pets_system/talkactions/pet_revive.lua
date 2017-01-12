-- <talkaction words="!petrevive" script="pet_revive.lua" />
function onSay(player, words, param, channel)
	local petUid = player:getPetUid()
	if petUid == -1 then
		player:petSystemMessage("You don't have a pet!")

	elseif petUid >= 0 then
		player:petSystemMessage("Your pet is live!")

	elseif petUid == -2 then
		local petLevel = player:getPetLevel()
		local soulNeded = petLevel * PETS.CONFIG.reviveSoulLevelCost + PETS.CONFIG.reviveSoulBaseCost --PETS.SOULPERLVL
		soulNeded = soulNeded > 100 and 100 or soulNeded

		if player:getSoul() >= soulNeded then
			player:addSoul(-soulNeded)
			player:setPetUid(0)
			player:setPetLostHealth(0)
			local playerPosition = player:getPosition()
			playerPosition:sendMagicEffect(CONST_ME_HOLYAREA)
			player:petSystemMessage("Your pet is revived!")

		else
			player:petSystemMessage("You don't have enought souul points!")
		end
	end
	return true
end

