SpriteSheet = require("components/Component"):Register()

local function Parse(self,img,spritesX,spritesY,xOff,yOff)
    local sprites = {};
    local imgW,imgH = img:getWidth(),img:getHeight();
    local spriteW,spriteH = imgW/spritesX,imgH/spritesY;
    xOff = xOff or 0;
    yOff = yOff or 0;

    spriteW = spriteW - xOff;
    spriteH = spriteH - yOff;

    self.spriteW = spriteW;
    self.spriteH = spriteH;

    local i,j = 0,0
    for y=0,spritesY*spriteH-spriteH,spriteH do
        for x=0,spritesX*spriteW-spriteW,spriteW do
            if not sprites[i] then sprites[i] = {} end

            if not sprites[i][j] then 
                sprites[i][j] = love.graphics.newQuad(x-xOff,y-yOff,spriteW,spriteH,img:getDimensions());
            end

            j = j+1
        end

        i = i+1
        j = 0
    end

    return sprites;
end

setmetatable(SpriteSheet,{
    __call=function(s,src,spritesX,spritesY,xOff,yOff)
        local this   = {}
        this.src     = "res/images/"..src
        this.img     = love.graphics.newImage(this.src)
        this.sprites = Parse(this,this.img,spritesX,spritesY,xOff,yOff);
        return this
    end
})

return SpriteSheet