-- Import Utils
local ut = require("./modules/utils")

local voice = {
	connections = {}
}

function voice.join(message, lang)
	if ut.isPrivateMessage(message) then
		local reply = {
			["EN"] = "",
			["BR"] = "Esse comando não funciona no privado!"
		}
		message:reply(reply[lang])
		return
	end

	local guild = message.guild.id
	
	-- Se não estiver conectado a nenhum canal na guild então conecta
	if not voice.connections[guild] then
		-- Se o autor não estiver em um canal de voz
		if not message.member.voiceChannel then 
			local reply = {
				["BR"] = "Você não está em um canal de voz.",
			}

			message:reply(reply[lang])
			return
		end

		voice.connections[guild] = message.member.voiceChannel:join()
		voice.connections[guild]:playFFmpeg("./memes/yah.mp3")
		return 
		
	end

	local reply = {
		["BR"] = "Já estou em um canal de voz!",
	}

	message:reply(reply[lang])
end

function voice.leave(channel, guild)
	channel:leave()

	if voice.connections[guild] then 
		voice.connections[guild] = nil
	end
end

function voice.disconnect(member, channel)
	-- Verifica se o bot saiu da call.
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
