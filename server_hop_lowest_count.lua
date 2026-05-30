local htps = game:GetService("HttpService")
local tps = game:GetService("TeleportService")
local plrs = game:GetService("Players")

local plr = plrs.LocalPlayer
local pid = game.PlaceId
local url = "https://games.roblox.com/v1/games/" .. pid .. "/servers/Public?sortOrder=Asc&limit=100&excludeFullGames=true"

local json_map = game:HttpGet(url)
local map = htps:JSONDecode(json_map)
local counts, target_hop = {}, {}

for _, body in next, map.data do
  if body.playing then
    table.insert(counts, tonumber(body.playing))
  end
end table.sort(counts)

for _, body in next, map.data do
  if body.playing and tonumber(body.playing) == counts[1] then
    table.insert(target_hop, tostring(body.id))
  end
end

tps:TeleportToPlaceInstance(pid, target_hop[1], plr)