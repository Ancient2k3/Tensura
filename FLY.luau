-- Fly function by IY but rewrite/clean by HHxScripts --
local ws, rs, plr
ws = game:GetService("Workspace")
rs = game:GetService("RunService")
plr = game:GetService("Players").LocalPlayer
local scriptdata_func, i_respawn, i_loop = {
    V_handler_name = "Handler_V",
    G_handler_name = "Handler_G",
    flyspeed = 1, is_flying = false,
    alr_cancel = false
} _G.Script_FlyingEnabled = _G.Script_FlyingEnabled or false
-- Extra change --
_G.Script_FlyingSpeed = _G.Script_FlyingSpeed or 1
scriptdata_func.flyspeed = _G.Script_FlyingSpeed
-- Close Extra --

function _main_body(c)
    local bone = c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso") or c:FindFirstChild("UpperTorso")
    return bone
end

function _unfly()
    pcall(function()
        local bone = _main_body(plr.Character)
        bone:FindFirstChild(scriptdata_func.V_handler_name):Destroy()
        bone:FindFirstChild(scriptdata_func.G_handler_name):Destroy()
        plr.Character:FindFirstChildWhichIsA("Humanoid").PlatformStand = false
        if i_respawn then i_respawn:Disconnect() end
        if i_loop then i_loop:Disconnect() end
    end)
end

function _fly()
    _unfly()
    local bone, cam, v3n, v3z, v3i = _main_body(plr.Character)
    cam = ws.CurrentCamera
    v3n = Vector3.new() v3z = Vector3.new(0, 0, 0)
    v3i = Vector3.new(9e9, 9e9, 9e9)
    local control_module, bv, bg = require(plr.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
    bv = Instance.new("BodyVelocity", bone)
    bg = Instance.new("BodyGyro", bone)
    bv.Name = scriptdata_func.V_handler_name
    bg.Name = scriptdata_func.G_handler_name
    
    bv.MaxForce = v3z
    bv.Velocity = v3z
    bg.MaxTorque = v3i
    bg.P = 1000
    bg.D = 50
    
    i_respawn = plr.CharacterAdded:Connect(function()
        local bv, bg
        bv = Instance.new("BodyVelocity", bone)
        bg = Instance.new("BodyGyro", bone)
        bv.Name = scriptdata_func.V_handler_name
        bg.Name = scriptdata_func.G_handler_name
        
        bv.MaxForce = v3z
        bv.Velocity = v3z
        bg.MaxTorque = v3i
        bg.P = 1000
        bg.D = 50
    end)
    
    i_loop = rs.RenderStepped:Connect(function()
        bone = _main_body(plr.Character)
        cam = ws.CurrentCamera
        if plr.Character and plr.Character:FindFirstChildWhichIsA("Humanoid") and bone and bone:FindFirstChild(scriptdata_func.V_handler_name) and bone:FindFirstChild(scriptdata_func.G_handler_name) then
            local is_humanoid, V_handler, G_handler = plr.Character:FindFirstChildWhichIsA("Humanoid"), bone:FindFirstChild(scriptdata_func.V_handler_name), bone:FindFirstChild(scriptdata_func.G_handler_name)
            V_handler.MaxForce = v3i
            G_handler.MaxTorque = v3i
            is_humanoid.PlatformStand = true
            G_handler.CFrame = cam.CoordinateFrame
            V_handler.Velocity = v3n
            local direction = control_module:GetMoveVector()
            if direction.X > 0 then
                V_handler.Velocity = V_handler.Velocity + cam.CFrame.RightVector * (direction.X * (scriptdata_func.flyspeed * 50))
            end
            if direction.X < 0 then
                V_handler.Velocity = V_handler.Velocity + cam.CFrame.RightVector * (direction.X * (scriptdata_func.flyspeed * 50))
            end
            if direction.Z > 0 then
                V_handler.Velocity = V_handler.Velocity - cam.CFrame.LookVector * (direction.Z * (scriptdata_func.flyspeed * 50))
            end
            if direction.Z < 0 then
                V_handler.Velocity = V_handler.Velocity - cam.CFrame.LookVector * (direction.Z * (scriptdata_func.flyspeed * 50))
            end
        end
    end)
end

rs.RenderStepped:Connect(function()
    if _G.Script_FlyingEnabled == true then scriptdata_func.alr_cancel = false
        if plr.Character and plr.Character:FindFirstChildWhichIsA("Humanoid") then
            if plr.Character.Humanoid.Health > 0 and not scriptdata_func.is_flying then scriptdata_func.is_flying = true
                _fly()
            elseif plr.Character.Humanoid.Health <= 0 then
                _unfly()
                scriptdata_func.is_flying = false
            end
        end
    elseif _G.Script_FlyingEnabled == false and not scriptdata_func.alr_cancel then
        if not scriptdata_func.alr_cancel then scriptdata_func.alr_cancel = true
            _unfly()
            scriptdata_func.is_flying = false
        end
    end
end)
