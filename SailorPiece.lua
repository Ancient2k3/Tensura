local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/HoangHienXScripts/Scripts/refs/heads/main/modules/quickbuttons.lua"))()
ui.set_configs({
  saving_state = false
})

local ws, plrs, reps
ws = game:GetService("Workspace")
plrs = game:GetService("Players")
reps = game:GetService("ReplicatedStorage")

local plr, npcs, rq_hit
plr = plrs.LocalPlayer
npcs = ws.NPCs
rq_hit = reps.CombatSystem.Remotes.RequestHit

function receive_enm_pos()
  local t = {}
  local hrp = plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
  if hrp then
    for _, npc in pairs(npcs:GetChildren()) do
      if npc and npc:FindFirstChild("Humanoid") then
        local dist = (npc:GetBoundingBox().Position - hrp.Position).magnitude
        if dist <= 200 and npc.Humanoid.Health > 0 then
          table.insert(t, npc:GetBoundingBox().Position)
        end
      end
    end
  end return t
end

function atk_enm()
  local enm = receive_enm_pos()
  if #enm > 0 and plr and plr.Character and plr.Character:FindFirstChildOfClass("Tool") then
    rq_hit:FireServer(enm[math.random(1, #enm)])
  end
end

local btn = ui.add_toggle("Attack", "Arcade", {255, 255, 255}, {0, 455, 0, 209}, 0.15, atk_enm, "_KILL_AURA")
btn.Size = UDim2.new(0, 47, 0, 24)
