Animation = require("components/Component"):Register()

setmetatable(Animation,{
    __call=function(s,src)
        local this = {}
        this.x = 0; -- XIndex in SpriteSheet
        this.y = 0; -- YIndex in SpriteSheet
        this.w = 32; -- The width of each sprite in SpriteSheet
        this.h = 32; -- The height of each sprite in SpriteSheet
        this.cropX = 0; -- The width of the crop region
        this.cropY = 0; -- The height of the crop region
        this.delay = .125;
        this.time  = nil;
        this.xOff  = 0;
        this.yOff  = 0;
        return this
    end
})

return Animation