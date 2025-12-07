-- Last Letter Script --
local plr, starter, core, quickload
plr = game:GetService("Players").LocalPlayer
starter = game:GetService("StarterGui")
core = game:GetService("CoreGui")
quickload = loadstring

_G.Typespeed = _G.Typespeed or 0.01

local keyword_lib, used = quickload(game:HttpGet("https://raw.githubusercontent.com/HoangHienXScripts/W/refs/heads/garbage/c/library/Words.lua"))(), {}
if type(keyword_lib) == "table" then
    print("[No error: Keywords Library or Wiki.]\n[Loaded...]\n[ Successfully ]")
    print("[Total keywords existance: " .. tostring(#keyword_lib) .. " different word!]")
else
    plr:Kick("[Failed: Keywords Library has been deleted or something!]")
end

local keymap = {
    ["1"] = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"},
    ["2"] = {"A", "S", "D", "F", "G", "H", "J", "K", "L"},
    ["3"] = {"Z", "X", "C", "V", "B", "N", "M"}
}

local screenui, insertkey, newmatch, lastletter, uic, uiz, uix
screenui = Instance.new("ScreenGui", core)
insertkey = Instance.new("TextBox", screenui)
newmatch = Instance.new("TextButton", screenui)
lastletter = Instance.new("TextButton", screenui)
uic = Instance.new("UICorner", insertkey)
uiz = Instance.new("UICorner", newmatch)
uix = Instance.new("UICorner", lastletter)

screenui.Name = "LastLetter_#" .. math.random(1, 9999)
insertkey.Name = "Created_by_HHxScripts"
newmatch.Name = "Use_for_FREE"
lastletter.Name = "IF_YOURE_LAZY_TO_TYPING"

insertkey.BackgroundTransparency = 0.5
insertkey.BackgroundColor3 = Color3.new(0, 0, 0)
insertkey.Position = UDim2.new(0.45, 0, 0, 0)
insertkey.Size = UDim2.new(0.05, 0, 0.1, 0)
insertkey.TextScaled = true
insertkey.TextSize = 9
insertkey.TextColor3 = Color3.new(1, 1, 1)
insertkey.Text = ""
insertkey.PlaceholderText = "?"
insertkey.Font = Enum.Font.Arcade
insertkey.Visible = false --true
uic.CornerRadius = UDim.new(0.1, 0)

newmatch.BackgroundTransparency = 0.5
newmatch.BackgroundColor3 = Color3.new(0, 0, 0)
newmatch.Position = UDim2.new(0.52, 0, 0, 0)
newmatch.Size = UDim2.new(0.05, 0, 0.1, 0)
newmatch.TextScaled = true
newmatch.TextSize = 9
newmatch.TextColor3 = Color3.new(0, 1, 0)
newmatch.Text = "RESET"
newmatch.Font = Enum.Font.Arcade
newmatch.Visible = true
uiz.CornerRadius = UDim.new(0.1, 0)

lastletter.BackgroundTransparency = 0.5
lastletter.BackgroundColor3 = Color3.new(0, 0, 0)
lastletter.Position = UDim2.new(0.59, 0, 0, 0)
lastletter.Size = UDim2.new(0.05, 0, 0.1, 0)
lastletter.TextScaled = true
lastletter.TextSize = 9
lastletter.TextColor3 = Color3.new(0, 1, 0)
lastletter.Text = "GET"
lastletter.Font = Enum.Font.Arcade
lastletter.Visible = true
uix.CornerRadius = UDim.new(0.1, 0)

function notify(message)
    starter:SetCore("SendNotification", {
        Title = "💠 Notification 💠",
        Text = message .. ".",
        Duration = 1.25,
    })
end

function complete_word(keyword, wait_time)
    local choosen = nil
    for index, tab in pairs(keymap) do
        for key = 1, #keymap[index] do
            if keymap[index][key] == keyword then
                choosen = index
            end
        end
    end firesignal(plr.PlayerGui.Overbar.Frame.Keyboard[choosen][keyword].MouseButton1Click)
    print("Typed: " .. keyword) task.wait(wait_time)
end

function custom_match(word, letter)
    return word:match("^" .. letter)
end

function input_here(letter)
    local word_founded = ""
    for _, word in ipairs(keyword_lib) do
        if custom_match(word, letter) and not used[word] then
            word_founded = word
            used[word] = true
            break
        end
    end if word_founded ~= "" then
        return word_founded
    else
        return "IDONTKNOWN"
    end
end

function run(word)
    local result = input_here(word)
    local start_point = #word + 1
    for index = start_point, #result do
        complete_word(result:sub(index, index), _G.Typespeed)
    end firesignal(plr.PlayerGui.Overbar.Frame.Keyboard.Done.MouseButton1Click)
end

function findlast_letter()
    local letters_holder = plr.PlayerGui.InGame.Frame.CurrentWord
    local letters = letters_holder:GetChildren()
    local lastletter_keys = {}
    local lastletter_result = ""
    for index = 1, #letters do
        if letters[index].Name:match("%d+") then
            table.insert(lastletter_keys, tonumber(letters[index].Name))
        end
    end table.sort(lastletter_keys)
    for index = 1, #lastletter_keys do
        lastletter_result = lastletter_result .. tostring(letters_holder[tostring(lastletter_keys[index])]:FindFirstChildOfClass("TextLabel").Text)
    end run(lastletter_result)
    notify("It's you're last letters: " .. lastletter_result .. "?")
end

insertkey.FocusLost:Connect(function(ep)
    if ep and string.find(insertkey.Text, "%w+") then
        if insertkey.Text ~= "" then
            run(tostring(insertkey.Text))
        end
    else
        notify("You're not typed anything")
    end
end)

local is_refreshing = false
newmatch.MouseButton1Click:Connect(function()
    if not is_refreshing then
        is_refreshing = true
        newmatch.TextColor3 = Color3.new(1, 1, 0)
        used = {}
        notify("Refreshing script... completed")
        wait(0.5)
        is_refreshing = false
        newmatch.TextColor3 = Color3.new(0, 1, 0)
    else
        notify("I having some funny cooldown... don't press it to quickly")
    end
end)

local is_finding_letters = false
lastletter.MouseButton1Click:Connect(function()
    if not is_finding_letters then
        is_finding_letters = true
        lastletter.TextColor3 = Color3.new(0, 1, 1)
        findlast_letter()
        wait(0.5)
        is_finding_letters = false
        lastletter.TextColor3 = Color3.new(0, 1, 0)
    else
        notify("Can't you wait... until cooldown finishing?")
    end
end)

notify("Designed by HoangHien\n(facebook)")
notify("Type any last letter, I will automatically resolve it... 😆")
