local ui = loadstring(game:HttpGet("https://raw.githubusercontent.com/HoangHienXScripts/Scripts/refs/heads/main/modules/quickbuttons.lua"))()
ui.set_configs({saving_state=false})

local reps = game:GetService("ReplicatedStorage")
local status = {
  damage = 1000000,
  health = 1000000,
  speed = 15,
  jump = 20,
  ff = false
}

ui.add_button("GOD MODE", "Code", {255, 255, 255}, {0.65, 0, 0, 0}, 0.2, function()
  reps.Game.Events.RemoteEvent.ClientToServer.Character.RequestAddBuff:FireServer({["HealthPercent"] = 0, ["Strength"] = status.damage, ["StrengthPercent"] = 0, ["SpeedPercent"] = 0, ["MaxHealthPercent"] = 0, ["Time"] = 9999, ["JumpPowerPercent"] = 0, ["Speed"] = status.speed, ["JumpPower"] = status.jump, ["MaxHealth"] = status.health, ["Health"] = 0})
end)

ui.add_button("FF", "Code", {255, 255, 255}, {0.72, 0, 0, 0}, 0.2, function()
  local remote = reps.Game.Events.RemoteEvent.ClientToServer.Character
  if not status.ff then
    remote["RequestProtectedPlayer"]:FireServer()
  else
    remote["RequestDeProtectedPlayer"]:FireServer()
  end status.ff = not status.ff
end)
