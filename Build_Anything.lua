-- Build Anything Script --
-- SavingCubes/DeletingCubes --

local ws, plrs, rls, core, stat, htps
ws = game:GetService("Workspace")
plrs = game:GetService("Players")
rls = game:GetService("ReplicatedStorage")
core = game:GetService("CoreGui")
stat = game:GetService("StarterGui")
htps = game:GetService("HttpService")

local plr
plr = plrs.LocalPlayer

local custom_structures = {
  ["Mossy Structure"] = "https://raw.githubusercontent.com/Ancient2k3/Tensura/refs/heads/main/Data/Build_Anything/Rune.json"
}

local cubes_data = {}
local actions = {
  delcubes = "none",
  file_selected = "none",
  text_display = "",
  deleting_save = false,
  re_name = false
}

local screenui, pbar_background, pbar, display_index_object, list_save, list_save_layout, rename_textholder, accpect_change
screenui = Instance.new("ScreenGui", core)
screenui.Name = "Funniest_XScript"

pbar_background = Instance.new("Frame", screenui)
pbar_background.Name = "Loader_BG"
pbar_background.BackgroundTransparency = 0.5
pbar_background.BackgroundColor3 = Color3.new(0, 0, 0)
pbar_background.Position = UDim2.new(0.8, 0, -0.02, 0)
pbar_background.Size = UDim2.new(0.19, 0, 0.05, 0)
pbar_background.Active = true
pbar_background.Draggable = false
pbar_background.Visible = false

pbar = Instance.new("Frame", pbar_background)
pbar.Name = "Loader_Visualizer"
pbar.BackgroundTransparency = 0.5
pbar.BackgroundColor3 = Color3.new(0, 1, 0)
pbar.Position = UDim2.new(0, 0, 0, 0)
pbar.Size = UDim2.new(0.01, 0, 1, 0)
pbar.Active = true
pbar.Draggable = false
pbar.Visible = true
pbar.ZIndex = 1

display_index_object = Instance.new("TextLabel", pbar_background)
display_index_object.Name = "Index_Loader_Visualizer"
display_index_object.BackgroundTransparency = 0.5
display_index_object.BackgroundColor3 = Color3.new(0, 0, 0)
display_index_object.Position = UDim2.new(0, 0, 1.15, 0)
display_index_object.Size = UDim2.new(1, 0, 1, 0)
display_index_object.TextScaled = true
display_index_object.TextSize = 12
display_index_object.TextColor3 = Color3.new(0, 1, 0)
display_index_object.Font = Enum.Font.Code
display_index_object.Text = actions.text_display
display_index_object.Visible = true
display_index_object.ZIndex = 1

list_save = Instance.new("ScrollingFrame", screenui)
list_save.Name = "Storing_SavedFiles"
list_save.BackgroundTransparency = 0.5
list_save.BackgroundColor3 = Color3.new(0, 0, 0)
list_save.Position = UDim2.new(0.8, 0, -0.02, 0)
list_save.Size = UDim2.new(0.19, 0, 0.4, 0)
list_save.CanvasSize = UDim2.new(0, 0, 4, 0)
list_save.ScrollBarThickness = 2
list_save.Visible = false

list_save_layout = Instance.new("UIListLayout", list_save)
list_save_layout.Padding = UDim.new(0.003, 0)

rename_textholder = Instance.new("TextBox", screenui)
rename_textholder.Name = "SetFileName"
rename_textholder.BackgroundTransparency = 0.5
rename_textholder.BackgroundColor3 = Color3.new(0, 0, 0)
rename_textholder.Position = UDim2.new(0.8, 0, 0.39, 0)
rename_textholder.Size = UDim2.new(0.15, 0, 0.05, 0)
rename_textholder.TextScaled = true
rename_textholder.TextSize = 4
rename_textholder.TextColor3 = Color3.new(1, 1, 1)
rename_textholder.Font = Enum.Font.Code
rename_textholder.Text = ""
rename_textholder.PlaceholderText = "name... ?"
rename_textholder.Visible = false
rename_textholder.ZIndex = 1

accpect_change = Instance.new("TextButton", screenui)
accpect_change.Name = "LockChange"
accpect_change.BackgroundTransparency = 0.5
accpect_change.BackgroundColor3 = Color3.new(0, 0, 0)
accpect_change.Position = UDim2.new(0.955, 0, 0.39, 0)
accpect_change.Size = UDim2.new(0.035, 0, 0.05, 0)
accpect_change.TextScaled = true
accpect_change.TextSize = 4
accpect_change.TextColor3 = Color3.new(1, 1, 1)
accpect_change.Font = Enum.Font.Code
accpect_change.Text = "+"
accpect_change.Visible = false
accpect_change.ZIndex = 1

function ntf(str) stat:SetCore("SendNotification", {Title = "SCRIPT NOTIFY", Text = str, Duration = 1.25,}) end
function randomstring()
  local str = "qwertyuiopasdfghjklzxcvbnm"
  local _output = ""
  for i = 1, #str do
    local point = math.random(1, #str)
    _output = _output .. str:sub(point, point)
  end return _output
end

function create_foldersave()
  if not isfolder("HHxScripts") then
    makefolder("HHxScripts")
  end print("[Checked Files!]")
  if not isfile("HHxScripts/UsedCheck.txt") then
    writefile("HHxScripts/UsedCheck.txt", "Hello it's this your first time uses this script... right?") task.wait(0.05)
    for build_name, build_url in pairs(custom_structures) do
      writefile("HHxScripts/" .. build_name .. ".json", game:HttpGet(build_url))
    end
  else
    ntf("Welcome back " .. plr.Name .. ", :D!")
  end
end create_foldersave()

function readsize_file(str)
  local bytes = #str
  local units, unit_index = {"B", "kB", "MB", "GB", "TB"}, 1
  while bytes >= 1000 and unit_index < #units do
    bytes /= 1000
    unit_index += 1
  end return string.format("%.2f %s", bytes, units[unit_index])
end

function updatesize_visualizer(user_save)
  for _, btn in pairs(list_save:GetChildren()) do
    if btn:IsA("TextButton") and btn.Text == user_save:upper() .. "_CUBES_DATA" then
      local label = btn:FindFirstChildOfClass("TextLabel")
      if label then
        label.Text = readsize_file(readfile("HHxScripts/" .. user_save:upper() .. "_CUBES_DATA.json"))
      else
        ntf("Somehow!? It's failed to update the size of file content... ")
      end
    end
  end
end

function change_btn_color(name, color)
  local btn_founded = nil
  if type(color) ~= "table" then print("Script Error... ") return end
  for _, btn in pairs(list_save:GetChildren()) do
    if btn:IsA("TextButton") and btn.Text == name then
      btn_founded = btn
      btn.BackgroundColor3 = Color3.new(unpack(color))
    end
  end return btn_founded
end

function get_original_name()
  local original_name = ""
  for _, btn in pairs(list_save:GetChildren()) do
    if btn:IsA("TextButton") and btn.BackgroundColor3.G >= 1 then
      original_name = btn.Text
    end
  end return original_name
end

function remove_key(t, key)
  local key_removed = ""
  for index = 1, #t do
    if t[index] == key then
      key_removed = table.remove(t, index)
    end
  end return key_removed
end

function savefile(user_inputed)
  local content = htps:JSONEncode(cubes_data)
  if not isfolder("HHxScripts") then
    makefolder("HHxScripts")
  end writefile("HHxScripts/" .. user_inputed:upper() .. "_CUBES_DATA.json", content)
  --print("Check content: " .. content)
end

function delete_file(file_name)
  local all_files = listfiles("HHxScripts")
  for _, file in ipairs(all_files) do
    local extract_name = string.gsub(string.gsub(file, "HHxScripts/", ""), ".json", "")
    if extract_name == file_name then
      delfile("HHxScripts/" .. file_name .. ".json")
    end
  end print("File deleted: " .. file_name)
end

function renaming_file(original_name, new_name)
  local all_files = listfiles("HHxScripts")
  local file_content = ""
  for _, file in ipairs(all_files) do
    if isfile("HHxScripts/" .. original_name .. ".json") then
      file_content = readfile("HHxScripts/" .. original_name .. ".json")
      if type(file_content) ~= "string" and file_content == "" then print("Failed to receiving file data... ") return end
      writefile("HHxScripts/" .. new_name .. ".json", file_content) task.wait(0.05)
      delfile("HHxScripts/" .. original_name .. ".json") task.wait(0.05)
      ntf("File named: " .. original_name .. " has changed to " .. new_name .. ", successfully!")
    end
  end
end

local existing_files = {}
function remove_loader_button(name)
  for _, btn in pairs(list_save:GetChildren()) do
    if btn:IsA("TextButton") and btn.Text == name then
      remove_key(existing_files, name)
      btn:Destroy()
    end
  end
end

function add_loader_button(name, file_content, script)
  if table.find(existing_files, name) then return end
  local btn = Instance.new("TextButton", list_save)
  btn.Name = randomstring()
  btn.BackgroundTransparency = 0.5
  btn.BackgroundColor3 = Color3.new(0, 0, 0)
  btn.Position = UDim2.new(0.02, 0, 0, 0)
  btn.Size = UDim2.new(0.79, 0, 0.02, 0)
  btn.TextScaled = true
  btn.TextSize = 12
  btn.TextColor3 = Color3.new(1, 1, 1)
  btn.Font = Enum.Font.Code
  btn.Visible = true
  btn.Text = name
  
  local csize = Instance.new("TextLabel", btn)
  csize.Name = randomstring()
  csize.BackgroundTransparency = 0.5
  csize.BackgroundColor3 = Color3.new(0, 0, 0)
  csize.Position = UDim2.new(1.02, 0, 0, 0)
  csize.Size = UDim2.new(0.24, 0, 1, 0)
  csize.TextScaled = true
  csize.TextSize = 9
  csize.TextColor3 = Color3.new(1, 1, 1)
  csize.Font = Enum.Font.Code
  csize.Visible = true
  if type(file_content) == "string" then
    csize.Text = readsize_file(file_content)
  else
    csize.Text = "Failed."
  end
  
  table.insert(existing_files, name)
  btn.MouseButton1Click:Connect(script)
end

function makebutton(pos, name, script)
  local btn = Instance.new("TextButton", screenui)
  btn.Name = randomstring()
  btn.BackgroundTransparency = 0.5
  btn.BackgroundColor3 = Color3.new(0, 0, 0)
  btn.Position = UDim2.new(unpack(pos))
  btn.Size = UDim2.new(0.05, 0, 0.1, 0)
  btn.TextScaled = true
  btn.TextSize = 12
  btn.TextColor3 = Color3.new(1, 1, 1)
  btn.Font = Enum.Font.Code
  btn.Visible = true
  btn.Text = name
  local uic = Instance.new("UICorner", btn)
  uic.CornerRadius = UDim.new(0.1, 0)
  btn.MouseButton1Click:Connect(script)
  return btn
end

function placing(name, pos)
  if not type(pos) == "table" then ntf("It's not table, script errored!") return end
  rls.Events.Place:InvokeServer(name, CFrame.new(unpack(pos)) * CFrame.Angles(0, 0, 0), workspace.Baseplate)
end

function Get_nearby_player()
  local nearest = nil
  local best_distance = math.huge
  for index, value in pairs(plrs:GetPlayers()) do
    if value ~= plr and value and value.Character and value.Character:FindFirstChildOfClass("Humanoid") then
       if not value.Character:FindFirstChild("HumanoidRootPart") then print("Founded: Character Glitching.") return end
       local current_distance = (value.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude
       if current_distance < best_distance then
          best_distance = current_distance
          nearest = value
       end
    end
  end
  if nearest ~= nil then
    print("Founded: " .. tostring(nearest.Name))
    return nearest
  else
    print("Founded: " .. tostring(nearest))
  end
end

function getcount()
  local count = 0
  for i, v in pairs(cubes_data) do
    count += 1
  end return count
end

function update_listsfile_position()
  if pbar_background.Visible == true then
    list_save.Position = UDim2.new(0.8, 0, 0.1, 0)
    rename_textholder.Position = UDim2.new(0.8, 0, 0.51, 0)
    accpect_change.Position = UDim2.new(0.955, 0, 0.51, 0)
  else
    list_save.Position = UDim2.new(0.8, 0, -0.02, 0)
    rename_textholder.Position = UDim2.new(0.8, 0, 0.39, 0)
    accpect_change.Position = UDim2.new(0.955, 0, 0.39, 0)
  end
end

function update_visualizer(current_value, max_value, object_name)
  if pbar_background.Visible == false then
    pbar_background.Visible = true
  end update_listsfile_position()
  local value_resulted = current_value / max_value
  pbar.Size = UDim2.new(value_resulted, 0, 1, 0)
  display_index_object.Text = actions.text_display .. tostring(object_name):upper() .. "\n" .. tostring(current_value) .. "/" .. tostring(max_value)
end

function reset_visualizer()
  actions.text_display = ""
  pbar.Size = UDim2.new(0.001, 0, 1, 0)
  display_index_object.Text = actions.text_display
end

function delete_all()
  local targeted = Get_nearby_player()
  if targeted == nil then return end
  actions.delcubes = targeted.DisplayName
  local target_objects = ws.Built[targeted.Name]:GetChildren()
  if #target_objects == 0 then
    ntf(actions.delcubes .. " having not any cube been placed before!")
    actions.delcubes = "none"
    return
  end
  pbar_background.Visible = true
  local target_object_index = 0
  for _, obj in pairs(target_objects) do
    target_object_index += 1
    if obj:IsA("Part") then
      rls.Events.DestroyBlock:InvokeServer(obj)
      update_visualizer(target_object_index, #target_objects, obj.Name)
    end
  end ntf("Removed all " .. actions.delcubes .. " cubes!")
  display_index_object.Text = "Finished!"
  task.wait(1.25)
  pbar_background.Visible = false
  update_listsfile_position()
  actions.delcubes = "none"
end

function savebuilt(user_inputed)
  local _path = ws.Built[user_inputed]
  local cubes = #_path:GetChildren()
  pbar_background.Visible = true
  for index = 1, cubes do
    local founded = _path:GetChildren()[index]
    update_visualizer(index, cubes, founded.Name)
    cubes_data["object_" .. tostring(index)] = {
      name = founded.Name,
      position = {founded.Position.X, founded.Position.Y, founded.Position.Z}
    } if cubes >= 1500 then task.wait(0.02) end
  end ntf("Built Saved!")
  display_index_object.Text = "Finished!"
  task.wait(1.25)
  pbar_background.Visible = false
  update_listsfile_position()
end

function reloadbuilt()
  cubes_data = htps:JSONDecode(readfile("HHxScripts/" .. plr.Name:upper() .. "_CUBES_DATA.json"))
  pbar_background.Visible = true
  local total_objects = getcount()
  for i = 1, total_objects do
    placing(cubes_data["object_" .. tostring(i)].name, cubes_data["object_" .. tostring(i)].position)
    update_visualizer(i, total_objects, cubes_data["object_" .. tostring(i)].name)
  end display_index_object.Text = "Finished!"
  task.wait(1.25)
  pbar_background.Visible = false
  update_listsfile_position()
end

local is_reloading_built_2 = false
function reloadbuilt_2(name)
  if not is_reloading_built_2 then
    is_reloading_built_2 = true
    cubes_data = htps:JSONDecode(readfile("HHxScripts/" .. name .. ".json"))
    pbar_background.Visible = true
    local total_objects = getcount()
    for i = 1, total_objects do
      placing(cubes_data["object_" .. tostring(i)].name, cubes_data["object_" .. tostring(i)].position)
      update_visualizer(i, total_objects, cubes_data["object_" .. tostring(i)].name)
    end display_index_object.Text = "Finished!"
    task.wait(1.25)
    pbar_background.Visible = false
    update_listsfile_position()
    is_reloading_built_2 = false
  else
    ntf(name .. " build is in progressing, please wait... !")
  end
end

-- In progress --
local openfiles, delbuilt, save, reload, save_others, delsave, rename_save

_G.file_actions = {
  renaming_action = false
}

function getfiles_and_update_list()
  if isfolder("HHxScripts") then
    local data_files = listfiles("HHxScripts")
    if #data_files == 0 then ntf("There is no saving files is found!") return end
    for index, value in ipairs(data_files) do
      if value:match("%.json$") then
        local resulting_name = ""
        resulting_name = string.gsub(string.gsub(value, "HHxScripts/", ""), ".json", "")
        add_loader_button(resulting_name, readfile(value), function()
          if _G.file_actions.renaming_action then ntf("File named: " .. actions.file_selected .. " (already been choose)") return end
          if actions.deleting_save == true then
            delete_file(resulting_name)
            remove_loader_button(resulting_name)
            ntf("Deleted File Name: " .. resulting_name:upper() .. " from Save Files.")
            return
          elseif actions.re_name == true then
            _G.file_actions.renaming_action = true
            change_btn_color(resulting_name, {0, 1, 0})
            actions.file_selected = resulting_name
            rename_textholder.Visible = true
            accpect_change.Visible = true
          end
          reloadbuilt_2(resulting_name)
        end)
      end
    end
  else
    print("Error: missing data folder!")
  end update_listsfile_position()
end

function openfiles_extra_button(switch)
  save_others.Visible = switch
  delsave.Visible = switch
  rename_save.Visible = switch
end

getfiles_and_update_list()
local vars = {
  fileslist_opened = false,
  removing = false,
  saving = false,
  reloading = false,
  saving_2 = false,
  removing_2 = false,
  renaming = false
}

openfiles = makebutton({0.73, 0, -0.14, 0}, "Files", function()
  getfiles_and_update_list()
  if not vars.fileslist_opened then
    vars.fileslist_opened = true
    if pbar_background.Visible == true then
      list_save.Position = UDim2.new(0.8, 0, 0.1, 0)
    else
      list_save.Position = UDim2.new(0.8, 0, -0.02, 0)
    end list_save.Visible = true
  else
    vars.fileslist_opened = false
    list_save.Visible = false
  end openfiles_extra_button(vars.fileslist_opened)
end)

delbuilt = makebutton({0.8, 0, -0.14, 0}, "Clear", function()
  if not vars.removing then
    vars.removing = true
    actions.text_display = "Deleted: "
    delete_all()
    reset_visualizer()
    vars.removing = false
  else
    ntf("It's on progression of deleting all " .. actions.delcubes .. " cubes!")
  end
end)

save = makebutton({0.87, 0, -0.14, 0}, "Save", function()
  if not vars.removing and not vars.saving then
    vars.saving = true
    actions.text_display = "Saved: "
    cubes_data = {}
    savebuilt(plr.Name)
    savefile(plr.Name)
    reset_visualizer()
    updatesize_visualizer(plr.Name)
    vars.saving = false
  else
    ntf("Too fast or Deleter is in Progression!")
  end getfiles_and_update_list()
end)

reload = makebutton({0.94, 0, -0.14, 0}, "Reload", function()
  if not vars.removing and not vars.saving and not vars.reloading then
    vars.reloading = true
    actions.text_display = "Loaded: "
    reloadbuilt()
    reset_visualizer()
    vars.reloading = false
  else
    ntf("Too fast or Something is in Progression!")
  end
end)

save_others = makebutton({0.73, 0, -0.02, 0}, "Save Nearby", function()
  if not vars.saving and not vars.saving_2 then
    vars.saving_2 = true
    actions.text_display = "Saved: "
    cubes_data = {}
    local targeted = Get_nearby_player()
    if targeted == nil then vars.saving_2 = false return end
    savebuilt(targeted.Name)
    savefile(targeted.Name)
    reset_visualizer()
    updatesize_visualizer(targeted.Name)
    getfiles_and_update_list()
    vars.saving_2 = false
  else
    ntf("Saving is in progressing, so please wait... !")
  end
end) save_others.Visible = false

delsave = makebutton({0.73, 0, 0.1, 0}, "Remove file", function()
  if not vars.removing_2 then
    vars.removing_2 = true
    actions.deleting_save = true
    delsave.BackgroundColor3 = Color3.new(0, 1, 0)
    -- RESET RENAME-FILE ACTION --
    vars.renaming = false
    actions.re_name = false
    rename_save.BackgroundColor3 = Color3.new(0, 0, 0)
  else
    vars.removing_2 = false
    actions.deleting_save = false
    delsave.BackgroundColor3 = Color3.new(0, 0, 0)
  end
end) delsave.Visible = false

rename_save = makebutton({0.73, 0, 0.22, 0}, "Rename file", function()
  if not vars.renaming then
    vars.renaming = true
    actions.re_name = true
    rename_save.BackgroundColor3 = Color3.new(0, 1, 0)
    -- RESET DEL-SAVE ACTION --
    vars.removing_2 = false
    actions.deleting_save = false
    delsave.BackgroundColor3 = Color3.new(0, 0, 0)
  else
    vars.renaming = false
    actions.re_name = false
    _G.file_actions.renaming_action = false
    change_btn_color(actions.file_selected, {0, 0, 0})
    actions.file_selected = "none"
    rename_textholder.Visible = false
    rename_textholder.Text = ""
    accpect_change.Visible = false
    rename_save.BackgroundColor3 = Color3.new(0, 0, 0)
  end
end) rename_save.Visible = false

local connect_actions = {
  final_name = ""
}

rename_textholder.FocusLost:Connect(function(ep)
  if ep and rename_textholder.Text ~= "" and not table.find(existing_files, rename_textholder.Text) then
    connect_actions.final_name = rename_textholder.Text
    ntf("Hmm... this " .. connect_actions.final_name:upper() .. " is seem good enough!")
  else
    if rename_textholder.Text == "" or rename_textholder.Text:match("^%s*$") then
      ntf("It's empty name... that's not allowed!")
    elseif table.find(existing_files, rename_textholder.Text) then
      ntf("This name " .. rename_textholder.Text:upper() .. " already exist in files.")
    end rename_textholder.Text = ""
  end
end)

accpect_change.MouseButton1Click:Connect(function()
  if connect_actions.final_name ~= "" and rename_textholder.Text ~= "" or not rename_textholder.Text:match("^%s*$") then
    renaming_file(get_original_name(), connect_actions.final_name)
    remove_loader_button(get_original_name())
    connect_actions.final_name = ""
    rename_textholder.Text = ""
    _G.file_actions.renaming_action = false
    actions.file_selected = "none"
    rename_textholder.Visible = false
    accpect_change.Visible = false
    -- RESET RENAME-FILE ACTION --
    vars.renaming = false
    actions.re_name = false
    rename_save.BackgroundColor3 = Color3.new(0, 0, 0)
  else
    connect_actions.final_name = ""
    rename_textholder.Text = ""
    ntf("There is no new file name inside the text box...")
  end getfiles_and_update_list()
end)

ntf("Script developed by HHxScripts!")
