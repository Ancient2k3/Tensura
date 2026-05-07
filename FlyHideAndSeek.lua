local rmt = game.ReplicatedStorage.Shared.Remotes.Tools.WebGunShootEvent
local plrs = game:GetService("Players")
local mode = false

local plr = plrs.LocalPlayer

function webbed_all()
local shooter
for _, enm in next, plrs:GetPlayers() do
  if tostring(enm.Team) == "Seeker" then
    for _, usr in next, plrs:GetPlayers() do
      if usr ~= enm and usr and usr.Character then
        if not mode then
          shooter = model_pos(usr.Character) + Vector3.new(0, 200, 0)
        else
          shooter = model_pos(enm.Character)
        end
        rmt:FireServer(model_pos(usr.Character), Vector3.new(0, 5, 0), workspace, shooter) task.wait(0.2)
      end
    end
  end
end end

function destroy_build(b)
  for _, p in pairs(workspace.GameZones.ZonesCreated:GetDescendants()) do
    if p:IsA("Part") and p.Parent.Name:lower() == b then
      rmt:FireServer(p.Position, p.Position, workspace, model_pos(plr.Character) + Vector3.new(0, 25, 0))
      task.wait(0.05)
    end
  end
end

function free_coin()
  for _, c in next, workspace.Debris:GetChildren() do
    local touch = c:FindFirstChild("Collider")
    if touch then
      touch.CanCollide = false
      touch.CFrame = CFrame.new(model_pos(plr.Character))
    end
  end
end

plr.Chatted:Connect(function(str)
  local word = string.split(str, " ")
  if word[1] == "/skip" then
    webbed_all()
  elseif word[1] == "/coins" then
    free_coin()
  elseif word[1] == "/break" then
    if word[2] then
      destroy_build(word[2])
    end
  end
end)
