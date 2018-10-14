local Vector2   = require("vector/Vector2")
Health = require("components/Component"):Register()

setmetatable(Health,{
    __call=function(s,health)
        local this = {}
        this.health = health
        return this
    end
})

return Health