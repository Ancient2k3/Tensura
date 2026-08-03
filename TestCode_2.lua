local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer

function xc_cmds(t, name)
  local hrp = plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
  local hmoid = plr and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
  if hrp and name == "/br" then
    local enm = t and t.Character and t.Character:FindFirstChild("HumanoidRootPart")
    if enm then
      hrp.CFrame = CFrame.new(enm.Position)
    end
  elseif hmoid and name == "/rs" then
    hmoid.Health = 0
  elseif name == "/fz" then
    hrp.Anchored = true
  end
end

for _, usr in next, plrs:GetPlayers() do
  if usr then
    usr.Chatted:Connect(function(str)
      xc_cmds(usr, str:lower())
    end)
  end
end

plrs.PlayerAdded:Connect(function(t)
  if t then
    t.Chatted:Connect(function(str)
      xc_cmds(t, str:lower())
    end)
  end
end)

print("[Troll CMDS: Loaded]")
