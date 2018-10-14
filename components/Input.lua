Input = require("components/Component"):Register()

setmetatable(Input,{
    __call=function(s)
        local this = {}
        this.direction = 0
        this.fire = false
        this.use  = false
        this.jump = false
        return this
    end
})

return Input