-- HoangHien_XScripts --
-- Avatar: ... --
local _Workspace, _Players, _RunService
_Workspace = game:GetService("Workspace")
_Players = game:GetService("Players")
_RunService = game:GetService("RunService")

local _Player, _Animation, _HasDied, _CurrentOutfits, _Id, _Stuff
_Player = _Players.LocalPlayer
_Animation = _Player.Character.Animate
_HasDied = false
_CurrentOutfits, _Id, _Stuff = {
    ["Shirt"] = function()
        return _Player.Character and _Player.Character:FindFirstChild("Shirt")
    end,
    ["Pants"] = function()
        return _Player.Character and _Player.Character:FindFirstChild("Pants")
    end
}, {
    ["Shirt"] = {"http://www.roblox.com/asset/?id=6553589915"},
    ["Pants"] = {"http://www.roblox.com/asset/?id=6555797749"},
    ["Type"] = {"http://www.roblox.com/asset/?id=", "rbxassetid://"}
}, {
    ["FluffyEars"] = {
        ["Head"] = {
            ["MeshId"] = {"rbxassetid://17618202202"},
            ["TextureId"] = {"rbxassetid://17411092404"},
            ["CF_1"] = {CFrame.new(0.05, -0.8, 0)},
            ["CF_2"] = {CFrame.Angles(0, 0, 0)},
            ["V3"] = {Vector3.new(0.78, 0.78, 0.78)}
        }
    },
    ["AdventurerGirlHair"] = {
        ["Head"] = {
            ["MeshId"] = {"rbxassetid://108201659362088"},
            ["TextureId"] = {"http://www.roblox.com/asset/?id=108333087618129"},
            ["CF_1"] = {CFrame.new(-0.08, 0.4, 0)},
            ["CF_2"] = {CFrame.Angles(0, 89.6, 0)},
            ["V3"] = {Vector3.new(0.8, 0.8, 0.8)}
        }
    },
    ["RimuruTempest"] = {
        ["Head"] = {
            ["MeshId"] = {"rbxassetid://6750850554"},
            ["TextureId"] = {"http://www.roblox.com/asset/?id=6783058251"},
            ["CF_1"] = {CFrame.new(0.229, -0.169, 0.340)},
            ["CF_2"] = {CFrame.Angles(0.570, 0.590, -0.370)},
            ["V3"] = {Vector3.new(0.9, 0.9, 0.9)}
        }
    },
    ["CuteSkirt"] = {
        ["LowerTorso"] = {
            ["MeshId"] = {"rbxassetid://11802794103"},
            ["TextureId"] = {"rbxassetid://11802945511"},
            ["CF_1"] = {CFrame.new(-0.01, 0.18, 0)},
            ["CF_2"] = {CFrame.Angles(0, 380, 0)},
            ["V3"] = {Vector3.new(0.8, 0.8, 0.8)}
        }
    }
}

function _ClassicOutfitInstance(_item, _name, _id, _type)
    local _s = Instance.new(_item, _Player.Character)
    _s.Name = _name
    if _type == "Shirt" then
        _s.ShirtTemplate = _id
    elseif _type == "Pants" then
        _s.PantsTemplate = _id
    end
end

function _ClassicOutfitChange(_type, _num)
    if _CurrentOutfits[_type]() ~= nil then
        if _type == "Shirt" then
            _CurrentOutfits[_type]().ShirtTemplate = _Id[_type][_num]
        elseif _type == "Pants" then
            _CurrentOutfits[_type]().PantsTemplate = _Id[_type][_num]
        end
    else
        _ClassicOutfitInstance(_type, _type, _Id[_type][_num], _type)
    end
end

function _PartInstance(_name, pr, _body, _MeshId, _TextureId, cf, cfa, v3)
    local p, w, s
    p = Instance.new("Part", pr)
    w = Instance.new("Weld", pr)
    s = Instance.new("SpecialMesh", p)
    -- Properties[1] --
    p.Transparency = 0
    p.Anchored = false
    p.CanCollide = false
    p.Size = Vector3.new(1, 1, 1)
    p.Color = Color3.new(0, 0, 0)
    p.Name = _name
    w.C1 = cf * cfa
    w.Part0 = pr[_body]
    w.Part1 = p
    s.MeshId = _MeshId
    s.TextureId = _TextureId
    s.Scale = v3
end

function _BasedInTable(_table)
    for a, b in pairs(_table) do
        for c, d in pairs(b) do
            if type(d) == "table" then
                _PartInstance(a, _Player.Character, c, d["MeshId"][1], d["TextureId"][1], d["CF_1"][1], d["CF_2"][1], d["V3"][1])
            end
        end
    end
end

function _ChangedAnimations(...)
    local _x = {...}
    _Animation = _Player.Character.Animate
    _Animation.idle.Animation1.AnimationId = _Id["Type"][1] .. _x[1]
    _Animation.idle.Animation2.AnimationId = _Id["Type"][1] .. _x[2]
    _Animation.walk.WalkAnim.AnimationId = _Id["Type"][1] .. _x[3]
    _Animation.run.RunAnim.AnimationId = _Id["Type"][1] .. _x[4]
    _Animation.jump.JumpAnim.AnimationId = _Id["Type"][1] .. _x[5]
    _Animation.climb.ClimbAnim.AnimationId = _Id["Type"][1] .. _x[6]
    _Animation.fall.FallAnim.AnimationId = _Id["Type"][1] .. _x[7]
    _Animation.swim.Swim.AnimationId = _Id["Type"][1] .. _x[8]
    if _Player.Character.Humanoid.Sit == true then
        _Player.Character.Humanoid.Jump = true
    else
        _Player.Character.Humanoid.Jump = false
    end
end

function _Avatar(...)
    local _a = {...}
    _Player:ClearCharacterAppearance()
    task.wait(_a[1])
    _ClassicOutfitChange("Shirt", 1)
    _ClassicOutfitChange("Pants", 1)
    --_PartInstance()
    _BasedInTable(_Stuff)
    _ChangedAnimations("10921288909", "10921290167", "92072849924640", "72301599441680", "104325245285198", "507765644", "18537367238", "913384386")
end

_Avatar(0.01)
print(">> Loaded Outfit <<")

_RunService.RenderStepped:Connect(function()
    if _Player.Character and _Player.Character:FindFirstChild("Humanoid") then
        if _Player.Character.Humanoid.Health <= 0 then
            _HasDied = true
        else
            if _HasDied then _HasDied = false
                local name = _Player.DisplayName
                wait(0.2)
                _Avatar(0.01)
                print("<< Reloaded " .. name .. " Outfit >>")
            end
        end
    end
end)
