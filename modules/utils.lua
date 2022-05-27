local utils = {}

function utils.isPrivateMessage(message)
    if message.guild then return false end
    return true
end

return utils