local profile = {}
local language = {
    invalidUserID = {
        EN = "Enter a valid userID!",
        BR = "Digite um id de usuário válido!"
    },

    title = {
        EN = "To see the larger image click here",
        BR = "Para ver a imagem maior clique aqui"
    },
}

function profile.getImage(message, lang)
    local client = message.client
    local userID = message.content:split(" ")[2]

    if not userID then message:reply(language.invalidUserID[lang]) return end

    local user = client:getUser(userID)

    if user then 
        message:reply{
            embed = {
                title = language.title[lang],
                url = user:getAvatarURL(1024),
                image = {url = user:getAvatarURL(256)}
            }
        }
    else
        message:reply(language.invalidUserID[lang])
    end
end

return profile