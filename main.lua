-- DISCORDIA
local discordia = require('discordia')
local client = discordia.Client()

--
local fs = require('fs')

-- Modules
local ping = require("./modules/ping")
local profile = require("./modules/profile")
local voice = require("./modules/voice")
local memes = require("./modules/memes")

-- IMPORT
discordia.extensions.string() -- load the discordia extensions

-- Moonbot vars
local commands = {}
local prefix = "!" -- default prefix.
local lang = "BR" -- default language.

local function addCommand(command, func)
	commands[prefix..command] = func
end

-- [[ commands ]]
addCommand("ping", ping.get)
addCommand("profile", profile.getImage)
addCommand("join", voice.join)
addCommand("leave", voice.leave)
addCommand("update", function()memes.update(fs)end)
addCommand("memes", memes.show)

-- checks if the user has entered a valid command.
local function isValidCommand(message)
	local content = message.content
	local arguments = content:split(" ")
    local command = table.remove(arguments, 1)
    if not command then return end

	if commands[command:lower()] then
        commands[command:lower()](message, lang)
    end
end

client:on('ready', function()
	print('Logged in as '.. client.user.username)
	memes.update(fs)
end)

client:on('messageCreate', function(message)
	isValidCommand(message)
	memes.isValidMeme(message, voice)
end)

client:on("voiceChannelLeave", function(member, channel)
	voice.disconnect(member, channel)
end)

client:run('Bot '..io.open("./token.txt"):read()) -- read token 