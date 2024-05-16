--// Utils.lua
local Utils = {}

function Utils.shallow_copy(t)
    local t2 = {}
    for k,v in pairs(t) do
      t2[k] = v
    end
    return t2
end

function Utils.BusyWait(wait)
    local Time = os.time()
    local End = Time + wait
    while Time < End do
        Time = os.time()
    end
end

function Utils.Init()
    return true
end

return Utils