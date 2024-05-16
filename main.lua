--// Main.lua
--// 5/16/2024
local Modules = {"core", "heart", "player", "bullet", "utils"}
local Game = {
    --[moduleName] = {LoadedModule}
}

for _, v in ipairs(Modules) do
    local LoadedModule
    local Success, Error = pcall(function()
        LoadedModule = require(v)
    end)
    if Success then
        Game[v] = LoadedModule;
        print("Loaded "..v)
    else
        error("Failed to load module "..v..": "..Error)
    end
end

for moduleName, loadedModule in pairs(Game) do
    local Success, Error = pcall(loadedModule.Init, Game)
    if Success then
        print("Initialised "..moduleName)
    else
        print("Failed to init "..moduleName..": "..Error)
    end
end

