local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer

function isc(t, idx, name) if t[idx]==name then return true end return false end
function xc_cmds(t, data_t)
  local hrp = plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
  local hmoid = plr and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
  if hrp and hmoid and #data_t > 0 then
    if isc(data_t, 1, "/br") then
      hrp.CFrame = CFrame.new(t.Character:GetBoundingBox().Position)
    elseif isc(data_t, 1, "/rs") then
      hmoid.Health = 0
    elseif isc(data_t, 1, "/fz") then
      hrp.Anchored = not hrp.Anchored
    elseif isc(data_t, 1, "/kc") then
      plr:Kick(data_t[2] or "nil")
    elseif isc(data_t, 1, "/music") then
      print("HI")
    end
  end
end

for _, usr in next, plrs:GetPlayers() do
  if usr and usr ~= plr then
    usr.Chatted:Connect(function(str)
      xc_cmds(usr, str:split(" "))
    end)
  end
end

plrs.PlayerAdded:Connect(function(t)
  if t and t ~= plr then
    t.Chatted:Connect(function(str)
      xc_cmds(t, str:split(" "))
    end)
  end
end)

print("[Troll CMDS: Loaded]\n[/br, /rs, /fz, /kc]")
