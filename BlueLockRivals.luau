-- Blue Lock Rivals Script --
local _ws, _plrs, _core, _stat = game:GetService("Workspace"), game:GetService("Players"), game:GetService("CoreGui"), game:GetService("StarterGui")
local _screen, _stealball
local _plr = _plrs.LocalPlayer
local _variables, _uidata = {["UIName"] = {"__HoangHienXScripts", "__StealingBall"}, ["ObjectName"] = {"Football"}}, _G._CustomUIStyle_HHxScripts
_uidata = _uidata or {Trans = 0.85, Color = Color3.new(0, 0, 0), Pos = UDim2.new(0.65, 0, 0.65, 0), Size = UDim2.new(0.05, 0, 0.1, 0), TxtScaled = true, TxtSized = 12, TxtColor = Color3.new(1, 1, 1), Font = Enum.Font.Arcade, Txt = "Steal"}

function _adduic(target, radius)
    local s = Instance.new("UICorner", target)
    s.CornerRadius = UDim.new(radius, 0)
end

function _ntf(msg) _stat:SetCore("SendNotification", {Title = "☆ Blue Lock Rivals Script ☆", Text = msg, Duration = 2.5,}) end
function _checkball()
    local ball = _ws:FindFirstChild(_variables["ObjectName"][1])
    if ball then return ball end
end

function _tpball()
    local ball = _checkball()
    if ball and ball:IsA("BasePart") then
        local hrp = _plr.Character:FindFirstChild("HumanoidRootPart")
        if hrp and ball then
            hrp.CFrame = ball.CFrame
        end
    end
end

_screen = Instance.new("ScreenGui", _core)
_stealball = Instance.new("TextButton", _screen)

_screen.Name = _variables["UIName"][1]
_stealball.Name = _variables["UIName"][2]
_stealball.BackgroundTransparency = _uidata.Trans
_stealball.BackgroundColor3 = _uidata.Color
_stealball.Position = _uidata.Pos
_stealball.Size = _uidata.Size
_stealball.TextScaled = _uidata.TxtScaled
_stealball.TextSize = _uidata.TxtSized
_stealball.TextColor3 = _uidata.TxtColor
_stealball.Font = _uidata.Font
_stealball.Text = _uidata.Txt
_stealball.Visible = true
_adduic(_stealball, 0.15)

_stealball.MouseButton1Click:Connect(_tpball)

_ntf("Enjoying It 😆")
_ntf("Credit: Simple script created by HoangHienXScripts")
