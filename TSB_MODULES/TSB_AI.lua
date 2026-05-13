local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/HoangHienXScripts/Scripts/refs/heads/main/modules/quickbuttons.lua"))()
ui.set_configs({saving_state = false})

local ws, plrs
ws = game:GetService("Workspace")
plrs = game:GetService("Players")

local plr 
plr = plrs.LocalPlayer

local vars = {
  retreat_dist = 35
}

local characters = {
  ["Ninja"] = {"Flash Strike", "Whirlwind Kick", "Scatter", "Explosive Shuriken", "Twinblade Rush", "Straight On", "Carnage", "Fourfold Flashstrike"},
  ["Cyborg"] = {"Machine Gun Blows", "Ignition Burst", "Blitz Shot", "Jet Dive", "Incinerate", "Speedblitz Dropkick", "Thunder Kick", "Flamewave Cannon"},
  ["Purple"] = {"Bullet Barrage", "Vanishing Kick", "Whirlwind Drop", "Head First", "Grand Fissure", "Twin Fangs", "Earth Splitting Strike", "Last Breath"},
  ["Batter"] = {"Homerun", "Beatdown", "Grand Slam", "Foul Ball", "Savage Tornado", "Brutal Beatdown", "Strength Difference", "Death Blow"},
  ["Esper"] = {"Crushing Pull", "Windstorm Fury", "Stone Coffin", "Expulsive Push", "Cosmic Strike", "Psychic Ricochet", "Terrible Tornado", "Sky Snatcher"},
  ["Blade"] = {"Quick Slice", "Atmos Cleave", "Pinpoint Cut", "Split Second Counter", "Sunset", "Solar Cleave", "Sunrise", "Atomic Slash"}
}

function _find_plr()
  local t = {n = nil, m = math.huge}
  for _, usr in pairs(plrs:GetPlayers()) do
    if usr ~= plr and usr and usr.Character then
      local dist = (usr.Character:GetBoundingBox().Position - plr.Character:GetBoundingBox().Position).magnitude
      if dist < t.m then
        t.m = dist
        t.n = usr
      end
    end
  end if t.n ~= nil then return t.n
  else return ws.Live["Weakest Dummy"]
  end
end

function _look_at(t)
  local target_hrp = t:FindFirstChild("HumanoidRootPart")
  local hrp = plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
  if hrp and target_hrp then
    plr.Character:SetPrimaryPartCFrame(CFrame.new(hrp.Position, Vector3.new(target_hrp.Position.X, hrp.Position.Y, target_hrp.Position.Z)))
  end
end

function _walkto(pos)
  local hmoid = plr and plr.Character and plr.Character:FindFirstChild("Humanoid")
  if hmoid and hmoid.Health > 0 then
    hmoid.WalkSpeed = 99
    hmoid.WalkToPoint = pos
  end
end

function _use_ability(name, num)
  local comm = plr and plr.Character and plr.Character:FindFirstChild("Communicate")
  local hotbar = plr.PlayerGui.Hotbar.Backpack.Hotbar
  local _bar = nil
  vars.retreat_dist = num
  for i = 1, 13 do
    if hotbar[tostring(i)].Base.ToolName.Text == name then
      _bar = hotbar[tostring(i)].Base
      break
    end
  end if _bar and not _bar:FindFirstChild("Cooldown") then
    if plr and plr.Backpack and plr.Backpack:FindFirstChild(name) then
      comm:FireServer({Goal = "Console Move", Tool = plr.Backpack[name]})
    end return "OK"
  else return "IN-CD"
  end vars.retreat_dist = 35
end

function _use_ult()
  local comm = plr and plr.Character and plr.Character:FindFirstChild("Communicate")
  local ult = tonumber(plr:GetAttribute("Ultimate")) == 100
  if comm and ult then
    comm:FireServer({Goal = "KeyPress", Key = Enum.KeyCode.G})
  end
end

function _dash()
  local comm = plr and plr.Character and plr.Character:FindFirstChild("Communicate")
  if comm then
    comm:FireServer({Dash = Enum.KeyCode.W, Key = Enum.KeyCode.Q, Goal = "KeyPress"})
  end
end

function _main_init()
  local target = ws.Live:FindFirstChild(_find_plr().Name)
  if target then
    local target_hrp = target:FindFirstChild("HumanoidRootPart")
    if target_hrp then _look_at(target)
      local distance = (target_hrp.Position - plr.Character:GetBoundingBox().Position).magnitude
      local direction = (plr.Character:GetBoundingBox().Position - target_hrp.Position).Unit * 60
      local selected_char = tostring(plr:GetAttribute("Character"))
      if distance > 40 then _walkto(target_hrp.Position)
      else
        if distance < vars.retreat_dist then
          _walkto(direction)
        end _use_ult()
        if plr.Backpack:FindFirstChild(characters[selected_char][5]) then
          _use_ability(characters[selected_char][5], 35)
          _use_ability(characters[selected_char][6], 2)
          _use_ability(characters[selected_char][7], 2)
          _use_ability(characters[selected_char][8], 35)
        else
          _use_ability(characters[selected_char][1], 2)
          _use_ability(characters[selected_char][2], 2)
          _use_ability(characters[selected_char][3], 35)
          _use_ability(characters[selected_char][4], 35)
        end
      end
    end
  end
end

ui.add_toggle("AI FIGHT", "Code", {255, 255, 255}, {0.35, 0, 0, 0}, 0.2, _main_init, "AI_Enabled")
