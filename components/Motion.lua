local Vector2 = require("vector/Vector2")
Motion = require("components/Component"):Register()

setmetatable(Motion,{
    __call=function(s)
        local this = {}
        this.acceleration = Vector2(0,0)
        this.velocity = Vector2(0,0)
        this.mass = 5
        this.jumpHeight=1.5
        this.speed = 2
        this.friction = 4
        this.maxSpeed = .5
        return this
    end
})

return Motion