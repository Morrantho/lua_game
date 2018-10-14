local Vector2   = require("vector/Vector2")
NPC = require("components/Component"):Register()

setmetatable(NPC,{
    __call=function(s)
        local this = {}
        return this
    end
})

return NPC