-- Only works for exploits with the 'mouse1click' function.
-- If your exploit doesn't have that function, you can look through the docs if you know what you're doing.
-- Dont touch any of this code below, unless you know what you're doing :)

local click1 = mouse1click or nil
local click2 = mouse2click or nil
local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()
if click1 == nil or click2 == nil then error("Exploit not supported") end

local settings = {
    Click = false;
    Enabled = false;
    Delay = 75;
    Keybind = Enum.KeyCode.F1;
    Method = "Left Click";
}

local Window = library:CreateWindow("Incessal's Autoclicker")
local Autoclicker = Window:CreateFolder("Clicker")
local Settings = Window:CreateFolder("Settings")


Autoclicker:Toggle("Enabled", function(bool) settings.Enabled = bool end)
Autoclicker:Bind("Keybind", Enum.KeyCode.F1, function()
    settings.Click = settings.Click == false
end)
Autoclicker:Dropdown("Dropdown", {"Left Click" ; "Right Click"}, true, function(choice)
    settings.Method = choice
end)
Settings:Slider("Delay (ms)", {min = 1 ; max = 100 ; precise = true;},function(int)
    settings.Delay = int
end)

while true do
    if settings.Click == true and settings.Enabled == true then
        if settings.Method == "Left Click" then click1() else click2() end
    end
    task.wait(settings.Delay/100)
end
