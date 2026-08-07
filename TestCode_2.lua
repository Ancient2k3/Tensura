local ws = game:GetService("Workspace")
local plrs = game:GetService("Players")
local txcs = game:GetService("TextChatService")
local reps = game:GetService("ReplicatedStorage")
local plr = plrs.LocalPlayer
local old_cmt, lgxchat, played_s = "", txcs.ChatVersion == Enum.ChatVersion.LegacyChatService, false

function cstr(str)
  str = tostring(str)
  if str ~= old_cmt then old_cmt = str
    if not lgxchat then
      txcs.TextChannels.RBXGeneral:SendAsync(str)
    else
      reps.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(str, "All")
    end
  end
end function isc(t, idx, name) if t[idx]==name then return true end return false end

function xc_cmds(t, data_t)
  local hrp = plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
  local hmoid = plr and plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
  if hrp and hmoid and #data_t > 0 then
    if isc(data_t, 1, "/br") then
      hrp.CFrame = CFrame.new(t.Character:GetBoundingBox().Position)
      cstr("Dịch chuyển tức thời!")
    elseif isc(data_t, 1, "/rs") then
      hmoid.Health = 0
      cstr("Reset nhân vật!")
    elseif isc(data_t, 1, "/fz") then
      hrp.Anchored = not hrp.Anchored
      cstr(({["true"] = "Đông cứng ", ["false"] = "Rã đông "})[tostring(hrp.Anchored)] .. "nhân vật!")
    elseif isc(data_t, 1, "/kc") then
      plr:Kick(data_t[2] or "nil")
    elseif isc(data_t, 1, "/ms") then
      local my_files = ws:FindFirstChild("HHxScripts")
      if my_files then
        for _, v in next, my_files:GetDescendants() do
          if v:IsA("Sound") and v.Name:lower():match(data_t[2]) then
            v:Play()
            played_s = true
          end
        end if played_s then
          cstr("Đã mở nhạc: " .. data_t[2])
          played_s = false
        end
      end
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

print("[Troll CMDS: Loaded]\n[/br, /rs, /fz, /kc, /ms]")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Ancient2k3/Status/refs/heads/main/Events/Notification.lua"))()
local context = game:HttpGet("https://raw.githubusercontent.com/Ancient2k3/Tensura/refs/heads/slime/announcement")
context = context:split("[+]")
if context[1]:match("%d+") then
  local time_end = tonumber(context[1])
  if tick() < time_end then
    _G.ntf_content = tostring(context[2]) or "Failed to receive Notification..."
  end
end
