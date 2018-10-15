Animation = require("components/Component"):Register()

setmetatable(Animation,{
    __call=function(this,delay)
        local this     = {}
        this.delay     = delay or .0625
        this.time      = nil;
        this.x         = 0; -- x index of spritesheet.
        this.y         = 0; -- y index of spritesheet.
        
        return this
    end
})

return Animation