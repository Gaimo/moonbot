local ut = require("./modules/utils")

local voice = {}
voice.connections = {}

function voice.join(message, lang)
    if ut.isPrivateMessage(message) then
        local reply = {
        ["EN"] = "",
        ["BR"] = "Qual canal você quer que eu entre? Existem muitos XD."
        }
        message:reply(reply[lang])
        return
    end

    local guild = message.guild.id
    if not voice.connections[guild] then 
        voice.connections[guild] = message.member.voiceChannel:join()
        voice.connections[guild]:playFFmpeg("./memes/yah.mp3")
    end
end

function voice.leave(channel, guild)
    channel:leave()

    if voice.connections[guild] then 
        voice.connections[guild] = nil
    end
end

function voice.disconnect(member, channel)
    if member.user.id == "879025506870231121" then
		local guild = channel.guild.id
        voice.leave(channel, guild)        
	end
end

function voice.playSound(soundPath, guild)
    if voice.connections[guild] then
         voice.connections[guild]:playFFmpeg(soundPath)
    end
end

return voice