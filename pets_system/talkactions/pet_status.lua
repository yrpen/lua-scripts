-- <talkaction words="!petinfo" script="pet_status.lua" />
function onSay(player, words, param, channel)
	local petUid = player:getPetUid()
	local text = ''
	if petUid == nil or petUid == -1 then
		text = "You don't have pet."
	elseif petUid == -2 then
		text = "Your pet is dead."
	else
		local pet = Creature(petUid)
		if pet ~= nil and pet:isCreature() then
			text = "\n Type: "..pet:getName()..
			" \n Health: "..pet:getHealth().."/"..pet:getMaxHealth()..
			" \n Exp: "..player:getPetExperience()..
			"\n Lvl: "..player:getPetLevel()
		else
			text = "Your's pet is offline."
		end
	end
	player:petSystemMessage(text)
	return true
end
	
