-- Slap Battle Games --
local ws, plrs, rls, rs, core, stat
ws = game:GetService("Workspace")
plrs = game:GetService("Players")
rls = game:GetService("ReplicatedStorage")
rs = game:GetService("RunService")
core = game:GetService("CoreGui")
stat = game:GetService("StarterGui")

local plr, cam, zap, combat
plr = plrs.LocalPlayer
cam = ws.Camera
zap = rls:WaitForChild("ZAP")
combat = zap:WaitForChild("COMBAT_RELIABLE")

local target_incombat = ""
local is_checking = false
local is_notify = false

local screenui, displaytarget, findtarget, loopcheck
screenui = Instance.new("ScreenGui", core)
displaytarget = Instance.new("TextBox", screenui)
findtarget = Instance.new("TextButton", screenui)
loopcheck = Instance.new("TextButton", screenui)

screenui.Name = "SLAP-BattleUI"
displaytarget.Name = "ShowCurrent_Enemy"
findtarget.Name = "Get_Enemy"
loopcheck.Name = "CheckAction"

local anims_track = {
    "rbxassetid://78039768731258",
    "rbxassetid://137023753042303"
}

local prop_list, color = {
  "BackgroundTransparency", "BackgroundColor3", "Position", "Size",
  "TextScaled", "TextSize", "TextColor3", "Text", "Font", "Visible",
  "ClearTextOnFocus", "PlaceholderText"
}, {
  black = Color3.new(0, 0, 0),
  white = Color3.new(1, 1, 1),
  green = Color3.new(0, 1, 0),
  yellow = Color3.new(1, 1, 0),
  customfunc = {
    mb1c = function(t, s) t.MouseButton1Click:Connect(s) end,
    dodge = {buffer.fromstring("\001Q\018\248\254\186L\218A"), {}}
  }
}

displaytarget[prop_list[1]] = 0.5
displaytarget[prop_list[2]] = color.black
displaytarget[prop_list[3]] = UDim2.new(0.35, 0, -0.10, 0)
displaytarget[prop_list[4]] = UDim2.new(0.3, 0, -0.05, 0)
displaytarget[prop_list[5]] = true
displaytarget[prop_list[6]] = 9
displaytarget[prop_list[7]] = color.white
displaytarget[prop_list[9]] = Enum.Font.Code
displaytarget[prop_list[8]] = ""
displaytarget[prop_list[12]] = "-- Target --"
displaytarget[prop_list[10]] = true

findtarget[prop_list[1]] = 0.5
findtarget[prop_list[2]] = color.black
findtarget[prop_list[3]] = UDim2.new(0.75, 0, -0.15, 0)
findtarget[prop_list[4]] = UDim2.new(0.05, 0, 0.1, 0)
findtarget[prop_list[5]] = true
findtarget[prop_list[6]] = 9
findtarget[prop_list[7]] = color.white
findtarget[prop_list[9]] = Enum.Font.Code
findtarget[prop_list[8]] = "GET"
findtarget[prop_list[10]] = true

loopcheck[prop_list[1]] = 0.5
loopcheck[prop_list[2]] = color.black
loopcheck[prop_list[3]] = UDim2.new(0.82, 0, -0.15, 0)
loopcheck[prop_list[4]] = UDim2.new(0.05, 0, 0.1, 0)
loopcheck[prop_list[5]] = true
loopcheck[prop_list[6]] = 9
loopcheck[prop_list[7]] = color.green
loopcheck[prop_list[9]] = Enum.Font.Code
loopcheck[prop_list[8]] = "CHECK"
loopcheck[prop_list[10]] = true

function notification(msg)
  stat:SetCore("SendNotification", {
    Title = "NOTIFICATION",
    Text = msg,
    Duration = 0.5,
  })
end

function check_realslap()
  for _, user in ipairs(plrs:GetPlayers()) do
    if user ~= plr and user and user.Character and user.Character:FindFirstChildOfClass("Humanoid") then
      for _, track in pairs(user.Character.Humanoid:GetPlayingAnimationTracks()) do
        if table.find(anims_track, track.Animation.AnimationId) then
          return tostring(user.Name)
        end
      end
    end
  end return ""
end

function head_visible(user)
  local head = user.Character and user.Character:FindFirstChild("Head")
  if head then
    local _, on = cam:WorldToScreenPoint(head.Position)
    if on then return true end
  end return false
end

function return_name()
    local near, best, range = nil, math.huge, 200
    for _, user in pairs(plrs:GetPlayers()) do
        if user and user.Character and user.Character:FindFirstChild("HumanoidRootPart") then
            local pos = user.Character.HumanoidRootPart.Position
            local dist = (pos - plr.Character.HumanoidRootPart.Position).magnitude
            if dist < best and dist <= range and head_visible(user) then
                best = dist
                near = user
            end
        end
    end if near ~= nil then
        return tostring(near.Name)
    end return nil
end

local arm = color.customfunc
arm.mb1c(findtarget, function()
  local targetfound = return_name()
  if targetfound ~= nil then
    target_incombat = targetfound
  else
    target_incombat = ""
  end displaytarget[prop_list[8]] = target_incombat
end)

arm.mb1c(loopcheck, function()
  if not is_checking then
    is_checking = true
    loopcheck[prop_list[7]] = color.yellow
  else
    is_checking = false
    loopcheck[prop_list[7]] = color.green
  end
end)

rs.RenderStepped:Connect(function()
  if is_checking then
    local targetname = check_realslap()
    if targetname ~= "" and targetname == target_incombat then
      combat:FireServer(unpack(color.customfunc.dodge))
      if not is_notify then is_notify = true
        notification(target_incombat .. " has slapped!")
      end
    else
      if is_notify then is_notify = false end
    end
  end
end)
