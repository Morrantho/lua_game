local Vector2   = require("vector/Vector2")
CanCollide = require("components/Component"):Register()

setmetatable(CanCollide,{
    __call=function(s,entity)
        local this = {}
        return this
    end
})

return CanCollide