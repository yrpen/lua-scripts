-- <talkaction words="!petrelease" script="pet_release.lua" />
function onSay(player, words, param, channel)
	local petUid = player:getPetUid()
	if petUid >= 0 or petUid == -2 then
		player:doRemovePet()
		player:doResetPet()
		player:petSystemMessage("Pet released!")
	elseif petUid == -1 then
		player:petSystemMessage("You don't have pet!")
	end
	return true
end

