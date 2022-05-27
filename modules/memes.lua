local memes = {}

local ut = require("./modules/utils")

memes.list = {
	-- meme_name = "meme_path"
}

function memes.isValidMeme(message, voice)
    if ut.isPrivateMessage(message) then return end
    local meme = memes.list[message.content..".mp3"]

    if meme then 
        local guild = message.guild.id
        voice.playSound(meme, guild)
    end
end

function memes.update(fs)
    local files = fs.readdirSync("./memes")
    for key, value in ipairs(files) do 
        local meme = value
        local path = "./memes/"..meme
        memes.list[meme] = path
    end
    --print("memes atualizados.")
end

function memes.show(message)
    local reply = "```"
    for meme, path in pairs(memes.list) do 
        local meme = string.gsub(meme, ".mp3", "")
        reply = reply.."\n"..meme
    end
    reply = reply.."```"
    message:reply(reply)        
end

return memes