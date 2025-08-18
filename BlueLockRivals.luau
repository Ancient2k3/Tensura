-- Blue Lock Rivals Script --
local _ws, _plrs, _tws, _rs, _core = game:GetService("Workspace"), game:GetService("Players"), game:GetService("TweenService"), game:GetService("RunService"), game:GetService("CoreGui")
local _screen, _stealball, _afkmode
local _plr = _plrs.LocalPlayer
local _variables, _uidata = {
    ["UIName"] = {
        "__HoangHienXScripts", "__StealingBall", "__AFKMode"
    },
    ["ObjectName"] = {
        "Football"
    }, _IsRunning = false, _IsChecked = false, _IsAFK = false
}, _G._CustomUIStyle_HHxScripts
_G._RangeChecked = _G._RangeChecked or 20
_uidata = _uidata or {
    Trans = 0.85, Color = Color3.new(0, 0, 0), Pos = UDim2.new(0.65, 0, 0.65, 0),
    Size = UDim2.new(0.05, 0, 0.1, 0), TxtScaled = true, TxtSized = 12,
    TxtColor = Color3.new(1, 1, 1), Font = Enum.Font.Arcade, Txt = "Steal", Enabled = "Activated",
    Disabled = "Deactivated"
}

function _adduic(target, radius)
    local s = Instance.new("UICorner", target)
    s.CornerRadius = UDim.new(radius, 0)
end

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

function check_nearby_players(ball, specificrange)
    local nearest_player, nearest_distance = nil, specificrange
    for _, player in pairs(_plrs:GetPlayers()) do
        if player ~= _plr then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local distance = (char.HumanoidRootPart.Position - ball.Position).magnitude
                if distance <= nearest_distance then
                    nearest_player = player
                    nearest_distance = distance
                end
            end
        end
    end
    
    if nearest_player then
        tpball()
    end
end

function _tweento(target, position, speed)
    if _variables._currenttween then
        _variables._currenttween:Cancel()
    end
    local dist = (target.Position - position).magnitude
    local dur = dist / speed
    local tweenInfo = TweenInfo.new(dur, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)
    local tweenGoal = {Position = position}
    local t = _tws:Create(target, tweenInfo, tweenGoal)
    t:Play()
    _variables._currenttween = t
end

function _nearestplrfound()
    local nearest_player, nearest_distance = nil, 50
    for _, player in pairs(_plrs:GetPlayers()) do
        if player ~= _plr then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local distance = (char.HumanoidRootPart.Position - _plr.Character.HumanoidRootPart.Position).magnitude
                if distance <= nearest_distance then
                    nearest_player = player
                    nearest_distance = distance
                end
            end
        end
    end
    
    if nearest_player then
        local behind_position = nearest_player.Character.HumanoidRootPart.Position - (nearest_player.Character.HumanoidRootPart.CFrame.LookVector * 25)
        _tweento(_plr.Character, behind_position, 150)
    end
end

_screen = Instance.new("ScreenGui", _core)
_stealball = Instance.new("TextButton", _screen)
_afkmode = Instance.new("TextButton", _screen)

function _main(method, debounce)
    if not _variables._IsRunning then
        _variables._IsRunning = true
        _stealball.Text = _uidata.Enabled
    else
        _variables._IsRunning = false
        _stealball.Text = _uidata.Disabled
    end
    local seconds = debounce
    while _variables._IsRunning do wait(seconds)
        if method == "catch" then
            _tpball()
        elseif method == "bring" then
            print("Nothing Yet!")
        end
    end
end

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

_afkmode.Name = _variables["UIName"][3]
_afkmode.BackgroundTransparency = _uidata.Trans
_afkmode.BackgroundColor3 = _uidata.Color
_afkmode.Position = UDim2.new(0.58, 0, 0.65, 0)
_afkmode.Size = _uidata.Size
_afkmode.TextScaled = _uidata.TxtScaled
_afkmode.TextSize = _uidata.TxtSized
_afkmode.TextColor3 = _uidata.TxtColor
_afkmode.Font = _uidata.Font
_afkmode.Text = "AFK"
_afkmode.Visible = true
_adduic(_afkmode, 0.15)

_stealball.MouseButton1Click:Connect(function()
    _main("catch", 0.01)
end)

_afkmode.MouseButton1Click:Connect(function()
    if not _variables._IsAFK then
        _variables._IsAFK = true
        _afkmode.TextColor3 = Color3.new(0, 1, 0)
    else
        _variables._IsAFK = false
        _afkmode.TxtColor3 = _uidata.TxtColor
    end
end)

_rs.RenderStepped:Connect(function(deltaTime)
    if _variables._IsAFK then
        _nearestplrfound()
    end
    
    local ball = _checkball()
    if ball and not _variables._IsChecked then
        _variables._IsChecked = true
        check_nearby_players(ball, _G._RangeChecked)
        _variables._IsChecked = false
    end
end)

print("-- Blue Lock Rivals: Script Executed! -- \n-- by HoangHienXScripts --")
