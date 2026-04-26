function svr(name) return game:GetService(name) end
local ws, plrs, rls
ws = svr("Workspace")
plrs = svr("Players")
rls = svr("ReplicatedStorage")

local plr, chests, ignore_items, tycoons, slap, mobs
plr = plrs.LocalPlayer
chests = ws.Treasure.Chests
ignore_items = ws.Ignore
tycoons = ws.Tycoons
slap = rls.Slap.RemoteEvent
mobs = ws.Characters.Enemies

local mdl = {}

local vars = {
  in_progress = false,
  current_object = "",
  blacklist_weapons = {"Poison Serpent", "Sonar"},
  hand_weapons = {
    ["Lava"] = "Lava Katana",
    ["Darkness"] = "Shadow Sword",
    ["Bone"] = "Bone Scythe",
    ["Space"] = "Space Gun",
    ["Devil"] = "Devil Sword",
    ["Venom"] = "Venom Blade",
    ["Crystal"] = "Crystal Cleaver",
    ["Time"] = "Time Scepter",
    ["Gravity"] = "Gravity Katana",
    ["Technology"] = "Hyper Sword",
    ["Fire"] = "Fire Sword",
    ["Earth"] = "Tectonic Hammer",
    ["Thunder"] = "Thunder Staff",
    ["Ice"] = "Frost Staff",
    ["Nature"] = "Christmas Tree Sword",
    ["Light"] = "Light Saber",
    ["Super Sonic"] = "Sonic Blaster"
  }
}

mdl.collect_money = function()
  local hrp = plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
  if hrp then
    if chests and #chests:GetChildren() > 0 then
      local chest = chests:GetChildren()[1]
      if chest and #chest:GetChildren() > 0 then
        local dist = (chest.Position - hrp.Position).magnitude
        hrp.CFrame = CFrame.new(chest.Position + Vector3.new(0, chest.Size.Y, 0))
        if dist <= 5 then
          fireproximityprompt(chest.ProximityPrompt)
        end
      end
    else
      if #mobs:GetChildren() > 0 then
        slap:FireServer(mobs:GetChildren()[1], 5000, 0, 0, "Jay")
      end
      local dlr = ws:FindFirstChild("Dollar") or ignore_items:FindFirstChild("Dollar")
      if dlr and dlr.Position.Y > 5 then
        dlr.CanCollide = false
        dlr.Transparency = 1
        dlr.CFrame = CFrame.new(hrp.Position)
      else
        local crate = ws:FindFirstChild("BalloonCrate")
        if crate and crate:GetBoundingBox().Position.Y <= 15 then
          local box = crate:GetBoundingBox().Position
          local dist = (box - hrp.Position).magnitude
          hrp.CFrame = CFrame.new(box)
          if dist <= 5 then
            fireproximityprompt(crate.Crate.ProximityPrompt)
          end
        else
          local base = tycoons:FindFirstChild(plr.Name)
          if base then
            local collector = base.Auxiliary.Collector.Collect
            hrp.CFrame = CFrame.new(collector.Position + Vector3.new(0, 5, 0))
          end
        end
      end
    end
  end
end

function check_money(amount)
  local money = plr.leaderstats.Money.Value
  if money >= amount then return true end
  return false
end

function check_object(name)
  local base = tycoons:FindFirstChild(plr.Name)
  if base and base:FindFirstChild("Assets") then
    local object = base.Assets:FindFirstChild(name) or base.Buttons:FindFirstChild(name)
    if object then return true end
  end return false
end

function to_button(name)
  local hrp = plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
  local base = tycoons:FindFirstChild(plr.Name)
  if hrp and base then
    local object = base.Buttons:FindFirstChild(name)
    if object then
      hrp.CFrame = CFrame.new(object:GetBoundingBox().Position)
    end
  end
end

function star(name_1, name_2, point, script)
  if check_object(name_1) then
    script()
    vars.current_object = name_1:upper()
  else
    if check_object(name_2) and check_money(point) then
      to_button(name_2)
    else
      mdl.collect_money()
    end
  end
end

mdl.do_progress = function()
  if not vars.in_progress then
    vars.in_progress = true
    star("Dropper2","Dropper2Dropper 2",250,function()
    star("Dropper3","Dropper3Dropper 3",1500,function()
    star("Dropper4","Dropper4Dropper 4",3000,function()
    star("Dropper5","Dropper5Dropper 5",6500,function()
    star("Walls","WallsWalls",150,function()
    star("Walls 2","Walls 2Walls 2",500,function()
    star("Walls 3","Walls 3Walls 3",1500,function()
    star("SecondFloor","SecondFloorSecond Floor",8000,function()
    star("Stairs","StairsStairs",1100,function()
    star("Track2","Track2Big Track",1200,function()
    star("BigDropper1","BigDropper1Big Dropper 1",10000,function()
    star("BigDropper2","BigDropper2Big Dropper 2",35000,function()
    star("BigDropper3","BigDropper3Big Dropper 3",80000,function()
    star("Walls 4","Walls 4Walls",1000,function()
    star("Walls 5","Walls 5Walls 2",2500,function()
    star("Walls 6","Walls 6Walls 3",3000,function()
    star("ThirdFloor","ThirdFloorThird Floor",200000,function()
    star("Stairs2","Stairs2Stairs",11000,function()
    star("Track3","Track3Super Track",12000,function()
    star("SuperDropper","SuperDropperSuper Dropper",250000,function()
    star("Walls 7","Walls 7Walls 7",10000,function()
    star("Walls 8","Walls 8Walls 8",25000,function()
    star("Walls 9","Walls 9Walls 9",30000,function()
    star("Roof","RoofRoof",40000,function()
    star("Security Guns","Security GunsSecurity Guns",400000,function()
    star("Stairs3","Stairs3Stairs",12000,function()
    star("Turret","TurretEnergy Turret",150000,function()
    star("BoostPad","BoostPadPotion Pad",10000,function()
    star("Boost1","Boost1Boost 1",30000,function()
    star("Boost2","Boost2Boost 2",40000,function()
    star("Boost3","Boost3Boost 3",60000,function()
    star("UltraPad","UltraPadBig Ability Pad",1000,function()
    star("Ability4","Ability4Ability 3",23000,function()
    star("Ability5","Ability5Ability 4",55000,function()
    star("Ability6","Ability6Ability 5",125000,function()
    star("Ability7","Ability7Ability 6",150000,function()
    star("PowerPad","PowerPadAbility Pad",250,function()
    star("Ability1","Ability1" .. vars.hand_weapons[plr.Team.Name],550,function()
    star("Ability2","Ability2Ability 1",1500,function()
    star("Ability3","Ability3Ability 2",5000,function()
    star("Lasers","LasersDoor Lasers",550,function()
    star("Pet","PetElemental Pet",3000,function()
    star("Heal","HealHealing Pad",6000,function()
    star("Suit","SuitElemental Body",12000,function()
    star("Air Strike","Air StrikeAir Strike",1550000,function()
    star("MysteryBlock","MysteryBlockMystery Block",3500000,function()
      vars.current_object = "Finished!"
    end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)
    end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)end)
    end)end)end)end)end)end)end)end)end)end)
    vars.in_progress = false
  end
end

mdl.magnet = function(mode)
  local target = plrs:GetPlayers()[math.random(1, #plrs:GetPlayers())]
  local magnet_mode = mode or nil
  if target ~= plr and target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
    if magnet_mode == "push" then
      slap:FireServer(target.Character, 0, 0, 999999, "Jay")
    elseif magnet_mode == "pull" then
      local distance = (target.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude > 80
      if distance then
        slap:FireServer(target.Character, 0, 0, -99, "Jay")
      end
    else
      return magnet_mode
    end
  end
end

return mdl