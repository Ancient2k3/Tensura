local ws, plrs, rs
ws = game:GetService("Workspace")
plrs = game:GetService("Players")
rs = game:GetService("RunService")

local variables = {
    is_alive = false
}

_G.Script_Accessories = _G.Script_Accessories or {
    ["Cute Ears"] = {
        ["Head"] = {
            ["mesh"] = {"rbxassetid://17618202202"},
            ["texture"] = {"rbxassetid://17411092404"},
            ["cframe"] = {CFrame.new(0, -0.8, 0)},
            ["angles"] = {CFrame.Angles(0, 0, 0)},
            ["vector_theree"] = {Vector3.new(0.78, 0.78, 0.78)}
        }
    }
} _G.EnabledAvt_Script = _G.EnabledAvt_Script or false

function _makemesh(_name, _p, _body, _meshid, _txtid, _cf, _cfa, _v3)
    -- Instance --
    local sf, p, w, sm
    if not _p:FindFirstChild("ScriptAccessories_HHxScripts") then
        sf = Instance.new("Folder", _p)
        sf.Name = "ScriptAccessories_HHxScripts"
    end
    p = Instance.new("Part", sf)
    w = Instance.new("Weld", sf)
    sm = Instance.new("SpecialMesh", p)
    -- Properties --
    p.Transparency = 0
    p.Anchored = false
    p.CanCollide = false
    p.Size = Vector3.new(1, 1, 1)
    p.Color = Color3.new(0, 0, 0)
    p.Name = _name
    w.C1 = _cf * _cfa
    w.Part0 = _p[_body]
    w.Part1 = p
    s.MeshId = _meshid
    s.TextureId = _txtid
    s.Scale = _v3
end

function _make_outfit()
    for a, b in pairs(_G.Script_Accessories) do
        for c, d in pairs(b) do
            if type(d) == "table" then
                _makemesh(a, plrs.LocalPlayer.Character, c, d["mesh"][1], d["texture"][1], d["cframe"][1], d["angles"][1], d["vector_theree"][1])
            end
        end
    end
end

rs.RenderStepped:Connect(function()
    if _G.EnabledAvt_Script ~= false then
        if plrs.LocalPlayer.Character.Humanoid.Health ~= 0 then
            if not variables.is_alive then variables.is_alive = true
                _make_outfit()
            end
        else
            if variables.is_alive then variables.is_alive = false end
        end
    end
end)
