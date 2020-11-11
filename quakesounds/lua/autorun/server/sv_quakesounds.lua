--[[
This Script is made by Instinkt https://steamcommunity.com/id/InstinktServers and is under GPL-3.0 License.
--]]

resource.AddFile("sound/quake/female/combowhore.mp3")
resource.AddFile("sound/quake/female/dominating.mp3")
resource.AddFile("sound/quake/female/doublekill.mp3")
resource.AddFile("sound/quake/female/firstblood.mp3")
resource.AddFile("sound/quake/female/godlike.mp3")
resource.AddFile("sound/quake/female/hattrick.mp3")
resource.AddFile("sound/quake/female/headhunter.mp3")
resource.AddFile("sound/quake/female/holyshit.mp3")
resource.AddFile("sound/quake/female/humiliation.mp3")
resource.AddFile("sound/quake/female/impressive.mp3")
resource.AddFile("sound/quake/female/killingspree.mp3")
resource.AddFile("sound/quake/female/ludicrouskill.mp3")
resource.AddFile("sound/quake/female/megakill.mp3")
resource.AddFile("sound/quake/female/monsterkill.mp3")
resource.AddFile("sound/quake/female/multikill.mp3")
resource.AddFile("sound/quake/female/perfect.mp3")
resource.AddFile("sound/quake/female/play.mp3")
resource.AddFile("sound/quake/female/prepare.mp3")
resource.AddFile("sound/quake/female/rampage.mp3")
resource.AddFile("sound/quake/female/teamkiller.mp3")
resource.AddFile("sound/quake/female/triplekill.mp3")
resource.AddFile("sound/quake/female/ultrakill.mp3")
resource.AddFile("sound/quake/female/unstoppable.mp3")
resource.AddFile("sound/quake/female/wickedsick.mp3")

local function decryptToEnglish(path)
	local str = ""

	if path == "humiliation" then
		str = " has been humiliated!"
	elseif path == "dominating" then
		str = " is dominating!"
	elseif path == "rampage" then
		str = " is on a rampage!"
	elseif path == "killingspree" then
		str = " is on a killing spree!"
	elseif path == "monsterkill" then
		str = " is a monster!!"
	elseif path == "unstoppable" then
		str = " is unstoppable!"
	elseif path == "ultrakill" then
		str = " is a machine!!"
	elseif path == "godlike" then
		str = " is godlike!"
	elseif path == "wickedsick" then
		str = " is wicked sick!"
	elseif path == "impressive" then
		str = " is impressive!"
	elseif path == "ludicrouskill" then
		str = " is LUDICROUS!!"
	elseif path == "holyshit" then
		str = " is.... holy shit!!!!"
	elseif path == "doublekill" then
		str = " got a double kill!"
	elseif path == "triplekill" then
		str = " got a triple kill!"
	elseif path == "multikill" then
		str = " got a multi kill!"
	elseif path == "combowhore" then
		str = " is a combo WHORE!!"
	end
	
	return str
end

local function playToAll(path)
	for _, p in pairs(player.GetAll()) do
		p:ConCommand("play quake/female/" .. path .. ".mp3")
	end
end

function quakeInitSpawn(p)
	p._QUAKE = {}
	p._QUAKE.killCount = 0
	p._QUAKE.headCount = 0
	p._QUAKE.lastKillTime = CurTime() - 30
	p._QUAKE.comboStreak = 0
	p._QUAKE.lastHeadshot = CurTime() - 30
	
	p:ConCommand("play quake/female/play.mp3")
end
hook.Add("PlayerInitialSpawn", "quakeInitSpawn", quakeInitSpawn)


hook.Add("ScalePlayerDamage", "quakeCheckHeadshot", function(p, hitGroup, dmgInfo)
	p.lastHitGroup = hitGroup
	p.wasExploded = dmgInfo:IsExplosionDamage()
end)

function quakePlayerDeath(dead, _, alive)
	dead._QUAKE.killCount = 0
	dead._QUAKE.headCount = 0
	
	if IsValid(alive) && alive:IsPlayer() then
		if alive != dead then
			alive._QUAKE.killCount = alive._QUAKE.killCount + 1
			
			if dead.lastHitGroup == HITGROUP_HEAD then
				alive._QUAKE.headCount = alive._QUAKE.headCount + 1
				alive._QUAKE.lastHeadshot = CurTime()
			end
		else
			playToAll("humiliation")
			SendUserMessage("colorQuakeMessage", p, decryptToEnglish("humiliation"), dead:Nick())
		end
		
		if alive._QUAKE.killCount == 4 then
			playToAll("dominating")
			SendUserMessage("colorQuakeMessage", p, decryptToEnglish("dominating"), alive:Nick())
		elseif alive._QUAKE.killCount == 6 then
			playToAll("rampage")
			SendUserMessage("colorQuakeMessage", p, decryptToEnglish("rampage"), alive:Nick())
		elseif alive._QUAKE.killCount == 8 then
			playToAll("killingspree")
			SendUserMessage("colorQuakeMessage", p, decryptToEnglish("killingspree"), alive:Nick())
		elseif alive._QUAKE.killCount == 10 then
			playToAll("monsterkill")
			SendUserMessage("colorQuakeMessage", p, decryptToEnglish("monsterkill"), alive:Nick())
		elseif alive._QUAKE.killCount == 14 then
			playToAll("unstoppable")
			SendUserMessage("colorQuakeMessage", p, decryptToEnglish("unstoppable"), alive:Nick())
		elseif alive._QUAKE.killCount == 16 then
			playToAll("ultrakill")
			SendUserMessage("colorQuakeMessage", p, decryptToEnglish("ultrakill"), alive:Nick())
		elseif alive._QUAKE.killCount == 18 then
			playToAll("godlike")
			SendUserMessage("colorQuakeMessage", p, decryptToEnglish("godlike"), alive:Nick())
		elseif alive._QUAKE.killCount == 20 then
			playToAll("wickedsick")
			SendUserMessage("colorQuakeMessage", p, decryptToEnglish("wickedsick"), alive:Nick())
		elseif alive._QUAKE.killCount == 22 then
			playToAll("impressive")
			SendUserMessage("colorQuakeMessage", p, decryptToEnglish("impressive"), alive:Nick())
		elseif alive._QUAKE.killCount == 24 then
			playToAll("ludicrouskill")
			SendUserMessage("colorQuakeMessage", p, decryptToEnglish("ludicrouskill"), alive:Nick())
		elseif alive._QUAKE.killCount >= 26 then
			playToAll("holyshit")
			SendUserMessage("colorQuakeMessage", p, decryptToEnglish("holyshit"), alive:Nick())
		end
		
		if alive._QUAKE.lastHeadshot == CurTime() then
			if alive._QUAKE.headCount == 1 then
				playToAll("headshot")
			elseif alive._QUAKE.headCount == 3 then
				playToAll("hattrick")
			elseif alive._QUAKE.headCount == 5 then
				playToAll("headhunter")
			end
		end
		
		if (CurTime() - alive._QUAKE.lastKillTime) <= 3 then
			alive._QUAKE.comboStreak = alive._QUAKE.comboStreak + 1
		else
			alive._QUAKE.comboStreak = 0
		end
		
		if alive._QUAKE.comboStreak == 1 then
			playToAll("doublekill")
			SendUserMessage("colorQuakeMessage", p, decryptToEnglish("doublekill"), alive:Nick())
		elseif alive._QUAKE.comboStreak == 2 then
			playToAll("triplekill")
			SendUserMessage("colorQuakeMessage", p, decryptToEnglish("triplekill"), alive:Nick())
		elseif alive._QUAKE.comboStreak == 3 then
			playToAll("multikill")
			SendUserMessage("colorQuakeMessage", p, decryptToEnglish("multikill"), alive:Nick())
		elseif alive._QUAKE.comboStreak == 4 then
			playToAll("combowhore")
			SendUserMessage("colorQuakeMessage", p, decryptToEnglish("combowhore"), alive:Nick())
		end
		
		alive._QUAKE.lastKillTime = CurTime()
		
		if dead.wasExploded then
			playToAll("perfect")
		end
	end
end
hook.Add("PlayerDeath", "quakePlayerDeath", quakePlayerDeath)