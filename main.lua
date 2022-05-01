-- DISCORDIA
local discordia = require('discordia')
local client = discordia.Client()

-- Commands
local ping = require("ping")

-- IMPORT
discordia.extensions.string() -- load the discordia extensions

-- Moonbot vars
local commands = {}
local prefix = "!" -- default prefix.

-- [[ commands ]]
commands[prefix.."ping"] = ping.ping

-- checks if the user has entered a valid command.
local function isValidCommand(message)
	local content = message.content
	local arguments = content:split(" ")
    local command = table.remove(arguments, 1)
    if not command then return end

	if commands[command:lower()] then
        commands[command:lower()](message)
    end
end

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
	isValidCommand(message)
end)

client:run('Bot '..io.open("./token.txt"):read()) -- read token 