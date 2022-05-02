local profile = {}
local language = {
    invalidUserID = {
        EN = "Enter a valid userID",
        BR = "Digite um id de usuário válido."
    }
}

function profile.getImage(message, lang)
    local client = message.client
    local content = message.content:split(" ")[2] or nil

    if not content then message:reply(language.invalidUserID[lang]) end

    local user = client:getUser(content)

    if user then 
        local profileImage = user:getAvatarURL(256)
        message:reply(profileImage)
    else
        message:reply(language.invalidUserID[lang])
    end
end

return profile