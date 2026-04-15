repeat task.wait() until game:IsLoaded() and workspace:FindFirstChild("Cutscenes") and workspace.Cutscenes:FindFirstChild("Death Cutscene")

print("[ Found the box, now doing setup... ]")
local box = workspace.Cutscenes["Death Cutscene"]
if #box:GetChildren() > 0 then
  for _, obj in next, box:GetChildren() do
    obj:Destroy() task.wait(0.05)
  end
end print("[ Removed Death Counter Box Objects... ]")

if workspace:FindFirstChild("xSafe") then return end

local s = Instance.new("Part", workspace)
s.Name = "xSafe"
s.Anchored = true
s.CanCollide = true
s.Material = "Grass"
s.Position = Vector3.new(-80, 25.7, 20347.7)
s.Size = Vector3.new(223, 1.2, 212)
s.Color = Color3.fromRGB(0, 100, 0)

local p = s:Clone()
p.Parent = s
p.Name = "xPoint"
p.Material = "Foil"
p.CanCollide = false
p.Transparency = 1
p.Size = Vector3.new(0.5, 0.5, 0.5)
p.Position = Vector3.new(-77.5, 32.7, 20358.7)

print("[Death Counter Box Successfully Setup!]")