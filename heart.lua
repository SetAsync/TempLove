--// Heart.lua
--// Handles global Love events.
local Game
local Heart = {
    Events = {
        load = {};
        draw = {};
        update = {};
        keypressed = {};
    };

    KeyDownBinds = {
        --[Name] = {Key, Function, CooldownActive}
     };
}

function Heart.BindEvent(Name, Event, Callback)
    Heart.Events[Event][Name] = Callback
    print("Binded ", Name, Event, Callback)
end

function Heart.UnBindEvent(Event, Name)
    Heart.Events[Event][Name] = nil;
end

function Heart.HandleEvent(EventName, ...)
    for _, v in pairs(Heart.Events[EventName]) do
        v = coroutine.wrap(v)
        v(...)
    end
end

function Heart.BindToKey(Name, Key, Callback)
    Heart.KeyDownBinds[Name] = {Key, Callback}
end

function Heart.Init(LoadedGame)
    Game = LoadedGame

    for loveEvent, _ in pairs(Heart.Events) do
        love[loveEvent] = function(...)
            Heart.HandleEvent(loveEvent, ...)
        end
    end

    Heart.Events.update["BindToKey"] = function()
        for BindName, BindData in pairs(Heart.KeyDownBinds) do
            local Key, Callback = BindData[1], BindData[2]
            if love.keyboard.isDown(Key) then
                Callback = coroutine.wrap(Callback)
                Callback()
            end
        end
    end
end


return Heart