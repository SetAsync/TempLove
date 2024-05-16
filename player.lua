local Game
local Player = {}

Player.position = {
    x = 10;
    y = 450;
}

function Player.CheckBoundry()
    local maxX = (love.graphics:getWidth() - Player.Image:getWidth()) - 10

    if Player.position.x < 10 then
        Player.position.x = 10
    elseif Player.position.x > maxX then
        Player.position.x = maxX
    end
end

function Player.Init(LoadedGame)
    Game = LoadedGame
    Player.Image = love.graphics.newImage("assets/images/player.png")

    --// Render player.
    Game.heart.BindEvent("RenderPlayer", "draw", function ()
        love.graphics.draw(Player.Image, Player.position.x, Player.position.y)
    end)

    --// Handle key presses.
    Game.heart.BindToKey("move-right", "right", function ()
        Player.position.x = Player.position.x + 5
        Player.CheckBoundry()
    end)

    Game.heart.BindToKey("move-left", "left", function ()
        Player.position.x = Player.position.x - 5
        Player.CheckBoundry()
    end)
        
    
end

return Player