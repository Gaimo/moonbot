local discordia = require('discordia')
local client = discordia.Client()

local commands = {}
local prefix = ! -- default prefix.

-- checks if the user has entered a valid command.
local function isValidCommand(message)
	local content = message.content
	local arguments = content:split(" ")
    local firstWord = table.remove(arguments, 1)
    if not firstWord then return end

	if commands[prefix..firstWord:lower()] then
        commands[prefix..firstWord:lower()](message)
    end
end

client:on('ready', function()
	print('Logged in as '.. client.user.username)
end)

client:on('messageCreate', function(message)
	isValidCommand(message)
end)

client:run('Bot '..io.open("./token.txt"):read())