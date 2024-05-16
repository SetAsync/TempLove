--// Core.lua
local Game
local Core = {}

Core.GameAudio = {
    BackgroundMusic = love.audio.newSource("assets/audio/background.mp3", "stream");
    BulletFire = love.audio.newSource("assets/audio/bullet.mp3", "static");
}

function Core.setupWindow()
    Core.GameAudio.BackgroundMusic:play()
    love.window.setMode(500, 500)
end

function Core.Init(LoadedGame)
    Game = LoadedGame

    Core.setupWindow()
end

return Core