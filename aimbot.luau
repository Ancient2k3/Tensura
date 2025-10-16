-- AimbotUI:HHxScripts --
local _ws, _plrs, _rs, _core
_ws = game:GetService("Workspace")
_plrs = game:GetService("Players")
_rs = game:GetService("RunService")
_core = game:GetService("CoreGui")

local _plr, _camera
_plr = _plrs.LocalPlayer
_camera = _ws.CurrentCamera

_G.AimingBodyPart = _G.AimingBodyPart or "HumanoidRootPart"
local _somedata = {
    owner = "HHxScripts",
    axis = {
        HumanoidRootPart = {0, 0, 0}
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
        corner = {0.15, 0},
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

function mb1c(t, s) t.MouseButton1Click:Connect(s) end
function nearest_user_character()
    local t, mh, ir = nil, math.huge, 1000
    for i, v in ipairs(_plrs:GetPlayers()) do
        if v ~= _plr and v.Character:FindFirstChild("HumanoidRootPart") then
            local rG = (_plr.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).magnitude
            if rG < mh and rG <= ir then
                mh = rG
                t = v
            end
        end
    end if t then return t end
end

function tboolean(b) return not b end
function lookat_nearest_character(t_data)
    local target = nearest_user_character()
    local position_data = t_data or {0, 0, 0}
    if type(position_data) == "table" and target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = target.Character.HumanoidRootPart
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
        _button.TextColor3 = Color3.fromRGB(unpack(_somedata.button.txtcolor))
    end _somedata.button.triggered = tboolean(_somedata.button.triggered)
end)

_rs.RenderStepped:Connect(function(deltaTime)
    local hmo = _plr.Character:FindFirstChild("Humanoid")
    if deltaTime and hmo.Health > 0 and _somedata.button.triggered == true then
        lookat_nearest_character(_somedata.axis[_G.AimingBodyPart])
    end
end)
