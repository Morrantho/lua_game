local Vector2   = require("vector/Vector2")
Collider = require("components/Component"):Register()

setmetatable(Collider,{
    __call=function(s,entity)
        local this = {}
        this.entity = entity -- Should be an id
        return this
    end
})

return Collider