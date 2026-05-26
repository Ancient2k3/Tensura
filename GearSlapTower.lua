function service(name) return game:GetService(name) end
local ws, plrs, reps, statui
ws = service"Workspace"
plrs = service"Players"
reps = service"ReplicatedStorage"
statui = service"StarterGui"

local plr, rmt, tools
plr = plrs.LocalPlayer
rmt = reps.RemoteEvents.mapManagerRemote
tools = ws.Givers.ToolGivers

repeat task.wait()
until game:IsLoaded() and plr and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")

function notify(msg)
  statui:SetCore("SendNotification", {Title = "Command!", Text = msg, Duration = 1.25})
end

function idk()
  local t = {n = nil, m = math.huge}
  for _, model in next, tools:GetChildren() do
    local uh = (model:GetBoundingBox().Position - plr.Character:GetBoundingBox().Position).magnitude
    if uh < t.m then t.m = uh
      t.n = model
    end
  end return t.n
end

rmt:FireServer("buyAdmin", "Mod") notify("Earned Free_Admin.")
plr.Chatted:Connect(function(msg)
  local str = msg:split(" ")
  if str[1] == "claim" then
    rmt:FireServer("claimTool", idk().Name)
    notify("Earned " .. idk().Name .. ".")
  elseif str[1] == "bomb" then
    rmt:FireServer("claimTool", "Classic Timebomb")
    notify("Earned Time_Bomb_Item.")
  end
end)