--// Bullet.py
local Game
local Bullet = {
    Debris = {};
}

local DebrisItem = {
    bulletSpeed = 10;

    Size = {
        x = 2;
        y = 10;
        color = 255, 255, 255;
    };

    Position = {
        x = math.huge;
        y = math.huge;
    }
}
DebrisItem.__index = DebrisItem
DebrisItem.new = function()
    local newDebrisItem = setmetatable({}, DebrisItem)

    newDebrisItem.Position = {
        x = math.huge;
        y = math.huge;
    }

    return newDebrisItem
end

function DebrisItem:update()
    self.Position.y = self.Position.y - self.bulletSpeed;
    return self.Position.y < 0
end

function DebrisItem:draw()
    love.graphics.rectangle("fill", self.Position.x, self.Position.y, self.Size.x, self.Size.y)
end

function Bullet.Init(LoadedGame)
    Game = LoadedGame

    Game.heart.BindToKey("Shoot", "space", function()
        Game.core.GameAudio.BulletFire:play()
        local newBullet = DebrisItem.new()

        local bulletStartPosition = {
            x = Game.player.position.x + (Game.player.Image:getWidth()/2);
            y = 435;
        }

        newBullet.Position = bulletStartPosition
        table.insert(Bullet.Debris, newBullet)
    end)

    --// Render Bullets
    Game.heart.BindEvent("RenderBullets", "draw", function()
        for i, v in pairs(Bullet.Debris) do
            v:draw()
        end
    end)

    Game.heart.BindEvent("HandleBullets", "update", function()
        for i, v in pairs(Bullet.Debris) do
            local Inactive = v:update()
            if Inactive then
                Bullet.Debris[i] = nil
            end
        end
    end)
end

return Bullet