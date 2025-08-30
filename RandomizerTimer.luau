-- FruitRandomize Timer --
local _coreui, _rs, _rls, _screen, _txtlb, _txtlb1, _uic, _uic1, _type
_coreui = game:GetService("CoreGui")
_rs = game:GetService("RunService")
_rls = game:GetService("ReplicatedStorage")
_type = type or typeof
local _variables = {
    re_updatetimer = 0
}

function _updatetimer(t, btn)
    _variables.re_updatetimer += 1
    if _variables.re_updatetimer >= 3600 then _variables.re_updatetimer = 0
        local _GETCOUNTDOWN = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "CheckTimeSummer")
        if _type(_GETCOUNTDOWN) ~= "boolean" then
            t.Text = "Gacha: " .. _GETCOUNTDOWN:match("(%d+:%d+)")
            t.TextColor3 = Color3.fromRGB(255, 0, 255)
        else
            t.Text = "Random Fruit"
            t.TextColor3 = Color3.fromRGB(0, 255, 0)
        end
    elseif _variables.re_updatetimer >= 1000 then
        btn.TextColor3 = Color3.fromRGB(255, 0, 0)
    elseif _variables.re_updatetimer >= 2000 then
        btn.TextColor3 = Color3.fromRGB(255, 255, 0)
    elseif _variables.re_updatetimer >= 3000 then
        btn.TextColor3 = Color3.fromRGB(0, 255, 0)
    elseif _variables.re_updatetimer >= 3250 then
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end btn.Text = "Update : " .. _variables.re_updatetimer
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
_txtlb1.Position = UDim2.new(0.24, 0, -0.08, 0)
_txtlb1.Size = UDim2.new(0.1, 0, 0.05, 0)
_txtlb1.TextScaled = true
_txtlb1.TextSize = 9
_txtlb1.Font = Enum.Font.Code
_txtlb1.Text = ""
_txtlb1.Visible = true
_uic1 = Instance.new("uic1orner", _txtlb1)
_uic1.CornerRadius = UDim.new(0.15, 0)

_txtlb.MouseButton1Click:Connect(function()
    if _txtlb.Text == "Random Fruit" then
        _rls.Remotes.CommF_:InvokeServer("Cousin", "BuySummer") wait(0.5)
        _rls.Remotes.CommF_:InvokeServer("Cousin", "Buy")
    else
        if not _variables._IsClicked then _variables._IsClicked = true
            _txtlb.TextColor3 = Color3.fromRGB(255, 255, 0)
            _txtlb.Text = "Please Wait..."
            wait(2.5)
            _txtlb.TextColor3 = Color3.fromRGB(255, 0, 255)
            _txtlb.Text = "Gacha: ?"
            _variables._IsClicked = false
        else
            print("-- ALREADY CLICKED RANDOMIZER --")
        end
    end
end)
_rs.RenderStepped:Connect(function() _updatetimer(_txtlb, _txtlb1) end)
