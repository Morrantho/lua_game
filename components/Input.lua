Input = require("components/Component"):Register()

setmetatable(Input,{
    __call=function(s)
        local this = {}
        this.direction = 0
        this.lastDirection = 0
        this.lastXDirection = 0
        this.lastYDirection = 0
        this.fire = false
        this.use  = false
        this.jump = false
        this.crouch = false
        this.fall   = false
        return this
    end
})

return Input