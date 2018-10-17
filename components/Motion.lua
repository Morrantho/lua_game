local Vector2 = require("vector/Vector2")
Motion = require("components/Component"):Register()

setmetatable(Motion,{
    __call=function(s,vel)
        local this = {}
        this.acceleration = Vector2(0,0)
        this.velocity = vel or Vector2(0,0)
        this.mass = 2
        this.jumpHeight=.75
        this.speed = 3
        this.friction = 4
        this.maxSpeed = .3
        -- this.ground = 0;
        return this
    end
})

return Motion