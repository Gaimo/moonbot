local ping = {}

function ping.ping(message)
    print(message)
    message:reply("pong")
end

return ping
