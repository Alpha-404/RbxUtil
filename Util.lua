local Util = {}

--More coming soon

function Util.Weld(p1, p2, c0)
	local w = Instance.new("Weld", p1)
	w.Name = "Weld" .. p1.Name
	w.Part0 = p1
	w.Part1 = p2
	w.C0 = c0
	return w
end

function Util.CreateTween(obj, speed, prop, mod)
	game:GetService("TweenService"):Create(obj, TweenInfo.new(speed), {[prop] = mod}):Play()
end

function Util.Lerp(speed, obj, cf)
	spawn(function()
		for i = 0,1 , speed  do
			obj.C0 = obj.C0:Lerp(cf, i)
			game:GetService("RunService").RenderStepped:Wait()
		end
	end)
end

function Util.TypeWrite(object,text)
	for i = 1,#text do
		object.Text = string.sub(text,1,i)
		wait(0.05)
	end
end

function Util.RandomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

function Util.r15(plr)
	if plr.Character:FindFirstChildOfClass('Humanoid').RigType == Enum.HumanoidRigType.R15 then
		return true
	end
end

function Util.r6(plr)
	if plr.Character:FindFirstChildOfClass('Humanoid').RigType == Enum.HumanoidRigType.R6 then
		return true
	end
end

function Util.findroot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

function Util.IsString(lol)
	if tostring(lol) and not tonumber(lol) then
		return true
	else
		return false
	end
end

function Util.IsNumber(num)
	if tonumber(num) or num == 'inf' then
		return true
	else
		return false
	end
end

function Util.Joint(P1,P2, CF)
	local AlignP = Instance.new('AlignPosition', P2);
	AlignP.ApplyAtCenterOfMass = true;
	AlignP.MaxForce = 67752;
	AlignP.MaxVelocity = math.huge/9e110;
	AlignP.ReactionForceEnabled = false;
	AlignP.Responsiveness = 200;
	AlignP.RigidityEnabled = true;
	local AlignO = Instance.new('AlignOrientation', P2);
	AlignO.MaxAngularVelocity = math.huge/9e110;
	AlignO.MaxTorque = 67752;
	AlignO.PrimaryAxisOnly = false;
	AlignO.ReactionTorqueEnabled = false;
	AlignO.Responsiveness = 200;
	AlignO.RigidityEnabled = true;
	local AttA=Instance.new('Attachment',P2);
	local AttB=Instance.new('Attachment',P1);
	AlignP.Attachment1 = AttA;
	AlignP.Attachment0 = AttB;
	AlignO.Attachment1 = AttA;
	AlignO.Attachment0 = AttB;
	AttA.Name = "Align" .. P1.Name
	AttA.CFrame = CF
	AttB.Name = "Align" .. P1.Name
end

function Util.findplayer(thing)
	if thing == "me" then
		return p
	else
		for i,c in pairs(game:GetService("Players"):GetPlayers()) do
			if string.match(string.lower(c.Name),string.lower('^' .. thing)) then
				return c
			end
		end
	end
end

Util.Bypass = function(obj, prop, val)
	local GameMt = getrawmetatable(game)
	local OldIndex = GameMt.__index

	setreadonly(GameMt, false)

	GameMt.__index = newcclosure(function(Self, Key)
		if not checkcaller() and Self == obj and Key == prop then
			return val
		end

		return OldIndex(Self, Key)
	end)

	setreadonly(GameMt, true)
end

return Util
