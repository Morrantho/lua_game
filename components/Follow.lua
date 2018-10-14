local Vector2   = require("vector/Vector2")
Follow = require("components/Component"):Register()

setmetatable(Follow,{
    __call=function(s,entity)
        local this = {}
        this.entity = entity
        return this
    end
})

return Follow