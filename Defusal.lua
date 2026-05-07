-- SimpleAimLock:HHxScripts --
local _ws, _plrs, _rs, _core, _stater
_ws = game:GetService("Workspace")
_plrs = game:GetService("Players")
_rs = game:GetService("RunService")
_core = game:GetService("CoreGui")
_starter = game:GetService("StarterGui")

local _plr, _camera, _team
_plr = _plrs.LocalPlayer
_camera = _ws.CurrentCamera
_team = nil

_G.AimingBodyPart = _G.AimingBodyPart or "HumanoidRootPart"
local _somedata = {
    owner = "HHxScripts",
    axis = {
        Head = {0, 0.95, 0},
        HumanoidRootPart = {0, 0, 0},
        LowerTorso = {0, -0.5, 0}
    },
    button = {
        trans = 0.5,
        color = {0, 0, 0},
        position = {0.85, 0, -0.15, 0},
        size = {0.05, 0, 0.1, 0},
        txtscaled = true,
        txtsize = 9,
        txtcolor = {255, 255, 255},
        font = "Code",
        deftxt = "¤",
        visibility = true,
        corner = {0.05, 0},
        triggered = false,
        triggercolorchange = {255, 255, 0}
    }
}

local _screenui, _button, _uic
_screenui = Instance.new("ScreenGui", _core)
_button = Instance.new("TextButton", _screenui)
_uic = Instance.new("UICorner", _button)

_screenui.Name = "AimLockUI_SCRIPT_" .. _somedata.owner
_button.Name = "TOGGLER_SCRIPT_" .. _somedata.owner
_uic.Name = "Smooth_UICORNER"
_button.BackgroundTransparency = _somedata.button.trans
_button.BackgroundColor3 = Color3.fromRGB(unpack(_somedata.button.color))
_button.Position = UDim2.new(unpack(_somedata.button.position))
_button.Size = UDim2.new(unpack(_somedata.button.size))
_button.TextScaled = _somedata.button.txtscaled
_button.TextSize = _somedata.button.txtsize
_button.TextColor3 = Color3.fromRGB(unpack(_somedata.button.txtcolor))
_button.Font = Enum.Font[_somedata.button.font]
_button.Text = _somedata.button.deftxt
_button.Visible = _somedata.button.visibility
_uic.CornerRadius = UDim.new(unpack(_somedata.button.corner))

local _Special_UI = Instance.new("Folder", _core)
_Special_UI.Name = "Crosshair_UI"

local _billboard = Instance.new("BillboardGui", _Special_UI)
_billboard.Name = "Crosshair_Container"
_billboard.AlwaysOnTop = true
_billboard.Adornee = nil
_billboard.Size = UDim2.new(0, 200, 0, 200)

local _Crh = Instance.new("ImageLabel", _billboard)
_Crh.Name = "Crosshair"
_Crh.BackgroundTransparency = 1
_Crh.BackgroundColor3 = Color3.new(0, 0, 0)
_Crh.Position = UDim2.new(0.365, 0, 0.4, 0)
_Crh.Size = UDim2.new(0.25, 0, 0.25, 0)
_Crh.Image = getcustomasset("HHxScripts/Assets/Images/lock_in.png")
_Crh.ImageColor3 = Color3.new(1, 1, 0)
_Crh.ImageTransparency = 0.25
_Crh.ScaleType = Enum.ScaleType.Fit

function mb1c(t, s) t.MouseButton1Click:Connect(s) end
function sendntf(str) _starter:SetCore("SendNotification", {Title = "NOTIFY", Text = str, Duration = 1.25,}) end

function is_enemy_visible(enemy)
    local start_pos = _plr.Character and _plr.Character:FindFirstChild("HumanoidRootPart")
    local end_pos = enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart")
    if not start_pos or not end_pos then return false end
    local direction = end_pos.Position - start_pos.Position
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = { _plr.Character }
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    local result = _ws:Raycast(start_pos.Position, direction, raycastParams)
    if result and result.Instance and not result.Instance:IsDescendantOf(enemy.Character) then
        return false
    end
    return true
end

function getcurrent_team()
     local team = nil
     team = _ws.Players[_plr.Name]:GetAttribute("Appearance")
     return team
end

function team_check(t)
    if _team ~= nil then
        if t and t.Character and t.Character:FindFirstChildOfClass("Humanoid") then
             local enm_team = _ws.Players[t.Name]:GetAttribute("Appearance")
             if enm_team == _team and _team ~= nil then
                 return false
             end
        end
    end
    return true
end

function nearest_user_character(r_ranGe)
    local t, mh, ir = nil, math.huge, r_ranGe
    for i, v in ipairs(_plrs:GetPlayers()) do
        if v ~= _plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local rG = (_plr.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
            if rG < mh and rG <= ir and team_check(v) and is_enemy_visible(v) then
                mh = rG
                t = v
            end
        end
    end return t
end

function lockon_nearest()
    local t, mh, ir = nil, math.huge, 2000
    for i, v in ipairs(_plrs:GetPlayers()) do
        if v ~= _plr and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 then
            local rG = (_plr.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
            if rG < mh and rG <= ir and team_check(v) and is_enemy_visible(v) then
                mh = rG
                t = v
            end
        end
    end if _team ~= nil and t and t.Character and t.Character:FindFirstChildOfClass("Humanoid") then
        if t.Character.Humanoid.Health > 0 then
            _billboard.Adornee = t.Character.Head
        end
    end
end

function tboolean(b) return not b end

function lookat_nearest_character(t_data)
    local target = nearest_user_character(1000)
    local position_data = t_data or {0, 0, 0}
    if type(position_data) == "table" and target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = target.Character.Head
        local hmo = target.Character.Humanoid
        if hmo.Health > 0 then
            _camera.CFrame = CFrame.new(_camera.CFrame.Position, hrp.Position + Vector3.new(unpack(position_data)))
        end
    end
end

mb1c(_button, function()
    if not _somedata.button.triggered then
        _button.TextColor3 = Color3.fromRGB(unpack(_somedata.button.triggercolorchange))
    else
        _team = nil
        _button.TextColor3 = Color3.fromRGB(unpack(_somedata.button.txtcolor))
    end 
    _somedata.button.triggered = tboolean(_somedata.button.triggered)
end)

_rs.RenderStepped:Connect(function(deltaTime)
    if deltaTime and _somedata.button.triggered == true then
        lookat_nearest_character(_somedata.axis[_G.AimingBodyPart])
        lockon_nearest()
    end
end)

_rs.RenderStepped:Connect(function(dt)
  if _somedata.button.triggered and _team ~= getcurrent_team() then
    _team = getcurrent_team()
    _sendntf(tostring(_team))
  end
end)
