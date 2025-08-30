-- FruitRandomize Timer --
local _coreui, _rs, _rls, _screen, _txtlb, _txtlb1, _uic, _uic1, _type
_coreui = game:GetService("CoreGui")
_rs = game:GetService("RunService")
_rls = game:GetService("ReplicatedStorage")
_type = type or typeof
local _variables = {
    re_updatetimer = 0
}

local _currentColor = Color3.fromRGB(255, 255, 255)
local _tweening = false

function _fadingcolor(targetColor)
    if _tweening or _currentColor == targetColor then return end
    _tweening = true
    local step = 0
    local duration = 0.15
    local steps = 20
    local startColor = _currentColor
    while step < steps do
        step += 1
        local alpha = step / steps
        local r = startColor.R + (targetColor.R - startColor.R) * alpha
        local g = startColor.G + (targetColor.G - startColor.G) * alpha
        local b = startColor.B + (targetColor.B - startColor.B) * alpha
        _txtlb1.TextColor3 = Color3.new(r, g, b)
        _currentColor = _txtlb1.TextColor3
        task.wait(duration / steps)
    end
    _tweening = false
end

function _updatetimer(t, btn)
    _variables.re_updatetimer += 1
    if _variables.re_updatetimer >= 1000 then _variables.re_updatetimer = 0
        local _GETCOUNTDOWN = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "CheckTimeSummer")
        if _type(_GETCOUNTDOWN) ~= "boolean" then
            t.Text = "Gacha: " .. _GETCOUNTDOWN:match("(%d+:%d+)")
            t.TextColor3 = Color3.fromRGB(255, 0, 255)
        else
            t.Text = "Random Fruit"
            t.TextColor3 = Color3.fromRGB(0, 255, 0)
        end
    elseif _variables.re_updatetimer > 0 and _variables.re_updatetimer < 250 then
        _fadingcolor(Color3.fromRGB(200, 0, 190))
    elseif _variables.re_updatetimer >= 250 and _variables.re_updatetimer < 500 then
        _fadingcolor(Color3.fromRGB(255, 0, 0))
    elseif _variables.re_updatetimer >= 500 and _variables.re_updatetimer < 750 then
        _fadingcolor(Color3.fromRGB(255, 255, 0))
    elseif _variables.re_updatetimer >= 750 and _variables.re_updatetimer < 900 then
        _fadingcolor(Color3.fromRGB(0, 255, 0))
    elseif _variables.re_updatetimer >= 900 and _variables.re_updatetimer < 999 then
        _fadingcolor(Color3.fromRGB(255, 255, 255))
    end
    btn.Text = "Update : " .. _variables.re_updatetimer
end

_screen = Instance.new("ScreenGui", _coreui)
_screen.Name = "__RandomFruitTimerCheck"

_txtlb = Instance.new("TextButton", _screen)
_txtlb.Name = "__GetCurrentTimer"
_txtlb.BackgroundTransparency = 0.65
_txtlb.BackgroundColor3 = Color3.new(0, 0, 0)
_txtlb.Position = UDim2.new(0.24, 0, -0.15, 0)
_txtlb.Size = UDim2.new(0.1, 0, 0.05, 0)
_txtlb.TextScaled = true
_txtlb.TextSize = 9
_txtlb.Font = Enum.Font.Code
_txtlb.Text = ""
_txtlb.Visible = true
_uic = Instance.new("UICorner", _txtlb)
_uic.CornerRadius = UDim.new(0.15, 0)

_txtlb1 = Instance.new("TextLabel", _screen)
_txtlb1.Name = "__GetReUpdateTimer"
_txtlb1.BackgroundTransparency = 0.65
_txtlb1.BackgroundColor3 = Color3.new(0, 0, 0)
_txtlb1.Position = UDim2.new(0.24, 0, -0.095, 0)
_txtlb1.Size = UDim2.new(0.1, 0, 0.05, 0)
_txtlb1.TextScaled = true
_txtlb1.TextSize = 9
_txtlb1.Font = Enum.Font.Code
_txtlb1.Text = ""
_txtlb1.Visible = true
_uic1 = Instance.new("UICorner", _txtlb1)
_uic1.CornerRadius = UDim.new(0.15, 0)

_txtlb.MouseButton1Click:Connect(function()
    if _txtlb.Text == "Random Fruit" then
        _rls.Remotes.CommF_:InvokeServer("Cousin", "BuySummer")
        task.wait(0.5)
        _rls.Remotes.CommF_:InvokeServer("Cousin", "Buy")
    else
        if not _variables._IsClicked then
            _variables._IsClicked = true
            _txtlb.TextColor3 = Color3.fromRGB(255, 255, 0)
            _txtlb.Text = "Please Wait..."
            task.wait(2.5)
            _txtlb.TextColor3 = Color3.fromRGB(255, 0, 255)
            _txtlb.Text = "Gacha: ?"
            _variables._IsClicked = false
        end
    end
end)

_rs.RenderStepped:Connect(function()
    _updatetimer(_txtlb, _txtlb1)
end)
