SpriteSheet = require("components/Component"):Register()

setmetatable(SpriteSheet,{
    __call=function(s,src)
        local this = {}
        this.src = "res/images/"..src
        this.img = love.graphics.newImage(this.src)
        return this
    end
})

return SpriteSheet