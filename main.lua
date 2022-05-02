-- DISCORDIA
local discordia = require('discordia')
local client = discordia.Client()

-- Commands
local ping = require("modules/ping")
local profile = require("modules/profile")

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
end)

client:on('messageCreate', function(message)
	isValidCommand(message)
end)

client:run('Bot '..io.open("./token.txt"):read()) -- read token 