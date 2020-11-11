--[[
This Script is made by Instinkt https://steamcommunity.com/id/InstinktServers and is under GPL-3.0 License.
--]]

AddCSLuaFile()

usermessage.Hook("colorQuakeMessage", function(msg)
	local txt = msg:ReadString()
	local winner = msg:ReadString()

	chat.AddText(Color(204,65,65), "[Instinkt Servers Quake Sounds]:", Color(150,204,204), " " .. winner .. txt)
end)
