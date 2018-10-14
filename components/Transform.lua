local Vector2   = require("vector/Vector2")
Transform = require("components/Component"):Register()

setmetatable(Transform,{
    __call=function(s,x,y,w,h)
        local this = {}
        this.position = Vector2(x or 0,y or 0)
        this.size     = Vector2(w or 0,h or 0)
        this.lastPosition = this.position
        return this
    end
})

return Transform