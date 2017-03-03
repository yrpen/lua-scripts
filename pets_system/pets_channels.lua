
function onJoin(player)
	player:petSystemMessage("Type '!petcommands' to see pet commands list.")
	local petUid = player:getPetUid()
	if petUid == 0 then
		player:summonPet( player:getPosition() )

	elseif petUid == -1 then
		player:petSystemMessage("You don't have pet.")
		
	elseif petUid == -2 then
		player:petSystemMessage("Your pet is dead.")
		
	end
	return true
end

function onLeave(player)
	player:doRemovePet()
	return true
end

function onSpeak(player, type, message)
	return type
end
