local Vector2   = require("vector/Vector2")
Player = require("components/Component"):Register()

setmetatable(Player,{
    __call=function(s)
        local this = {}
        return this
    end
})

return Player