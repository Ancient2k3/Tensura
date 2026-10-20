function service(name) return game:GetService(name) end
local ws, plrs, reps, statui, txcs, rs
ws = service"Workspace"
plrs = service"Players"
reps = service"ReplicatedStorage"
statui = service"StarterGui"
txcs = service"TextChatService"
rs = service"RunService"

local plr, rmt, tools, legacy, cons, atra, last_cmd, aura_mode
plr = plrs.LocalPlayer
rmt = reps.RemoteEvents.mapManagerRemote
tools = ws.Givers.ToolGivers
legacy = txcs.ChatVersion == Enum.ChatVersion.LegacyChatService
cons = {}
atra = false
last_cmd = ""
aura_mode = "speed"

repeat task.wait()
until game:IsLoaded() and plr and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")

function mdpos(t) return t.Character:GetBoundingBox().Position end
function is_slowed(t)
  local body = t and t.Character and t.Character:FindFirstChild("Head")
  local out = false
  if body and body:GetAttribute("SLOWED_1") then
    out = true
  end return out
end

function tag_slowed(t)
  local body = t and t.Character and t.Character:FindFirstChild("Head")
  if body and not is_slowed(t) then
    body:SetAttribute("SLOWED_1", true)
  end
end

function nearby()
  local t = {n = nil, m = math.huge, r = 60}
  for _, us in pairs(plrs:GetPlayers()) do
    if us ~= plr and us and us.Character then
      local dst = (mdpos(us) - mdpos(plr)).magnitude
      if dst < t.m and dst <= t.r and not is_slowed(us) then
        t.m = dst
        t.n = us
      end
    end
  end return t.n
end

function notify(msg)
  statui:SetCore("SendNotification", {Title = "Command!", Text = msg, Duration = 1.25})
end

function send_cmd(msg)
  msg = tostring(msg)
  if msg ~= last_cmd then last_cmd = msg
    if not legacy then
      txcs.TextChannels.RBXGeneral:SendAsync(msg)
    else
      reps.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
    end
  end
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
  elseif str[1] == "aura" then
    if not atra then atra = true
      table.insert(cons, rs.RenderStepped:Connect(function()
        local enm = nearby()
        if enm and enm.Character and not is_slowed(enm) then
          send_cmd("/w x /"..aura_mode.." "..enm.Name.." 0")
          tag_slowed(enm)
        end
      end))
    else atra = false
      if #cons > 0 then
        for i = 1, #cons do cons[i]:Disconnect() cons[i] = nil end
      end
    end
  elseif str[1] == "mode" then
    aura_mode = str[2]
    print(aura_mode.." selected.")
  end
end) print("cmds: claim, bomb, aura.")
