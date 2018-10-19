local Vector2   = require("vector/Vector2")
Camera = require("components/Component"):Register()

setmetatable(Camera,{
    __call=function(s,entity)
        local this = {}
        this.ent = nil;
        return this
    end
})

return Camera