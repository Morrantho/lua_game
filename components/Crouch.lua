local Vector2   = require("vector/Vector2")
Crouch = require("components/Component"):Register()

setmetatable(Crouch,{
    __call=function(s,entity)
        local this = {}
        this.standingHeight = nil;
        this.crouchHeight   = nil;
        this.crouchPos      = nil;
        return this
    end
})

return Crouch