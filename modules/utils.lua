local utils = {}

function utils.isPrivateMessage(message)
    if message.guild then return true else return false end
end

return utils