-- <talkaction words="!petcommands" script="pet_commands.lua" />
function onSay(player, words, param, channel)
    player:petSystemMessage("!petinfo")
    player:petSystemMessage("!petcatch") 
    player:petSystemMessage("!petrevive") 
    player:petSystemMessage("!petrelease") 
    player:petSystemMessage("!petheal") 
    return true
end

