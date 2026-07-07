local a = {"hello...", "world...", "is this working?"}
for i = 1, #a do
  print(a[i])
end

local b = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ancient2k3/Tensura/refs/heads/slime/TestCode_1.lua"))()
repeat task.wait()
until b and type(b) == "table"

for i = 1, #b do
  print(b[i])
end

print("Test Success...")
