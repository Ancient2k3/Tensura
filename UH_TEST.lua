local m = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ancient2k3/Modules/refs/heads/main/Commands.lua"))()
m.addcmd("sky", {"sky", "above"}, "<teleport user to sky...>", function()
  local t = game.Players.LocalPlayer.Character.HumanoidRootPart
  t.CFrame = CFrame.new(t.Position + Vector3.new(0, 5000, 0))
end)
print("[Testing Script... ]")
