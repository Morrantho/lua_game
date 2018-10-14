local SpriteSheet = require("components/SpriteSheet")
local Input       = require("components/Input")
local Transform   = require("components/Transform");
local Animation   = require("components/Animation");
local Vector2     = require("vector/Vector2")

AnimationSystem = require("systems/BaseSystem"):Register(
    bit.bor(
        SpriteSheet.id,
        Input.id,
        Animation.id,
        Transform.id
    )
)

function AnimationSystem:Init()
end

function AnimationSystem:Update(dt)
    for k,v in pairs(self.entities) do
        local input     = World.components[Input.id][k];
        local anim      = World.components[Animation.id][k];
        local transform = World.components[Transform.id][k];

        if input.direction == -1 then -- Left
            self:Play(anim,0,7,1,1,0,0,transform.size.x,transform.size.y,anim.delay);
        elseif input.direction == 1 then -- Right
            self:Play(anim,0,7,3,3,0,0,transform.size.x,transform.size.y,anim.delay);
        else -- Idle
            self:Play(anim,0,0,0,0,0,0,transform.size.x,transform.size.y,anim.delay);
        end
    end
end

function AnimationSystem:Play(anim,sX,eX,sY,eY,xOff,yOff,w,h,delay)
    if not anim.curTime then anim.curTime = love.timer.getTime(); end

    if love.timer.getTime()-anim.curTime >= delay then
        anim.curTime = love.timer.getTime();
        anim.w = w;
        anim.h = h;
        anim.delay = delay;
        anim.xOff = xOff;
        anim.yOff = yOff;

        if anim.x < eX then
            anim.x = anim.x+1;
        else
            anim.x = sX;
        end

        if anim.y < eY then
            anim.y = anim.y+1;
        else
            anim.y = sY;
        end

        anim.cropX = anim.x*anim.w+anim.xOff;
        anim.cropY = anim.y*anim.h+anim.yOff;

        print(anim.cropX,anim.cropY);
    end
end

function AnimationSystem:Draw() 
    for k,v in pairs(self.entities) do
        local input     = World.components[Input.id][k];
        local transform = World.components[Transform.id][k];
        local anim      = World.components[Animation.id][k];
        local img       = World.components[SpriteSheet.id][k].img;
        local x,y       = transform.position.x,transform.position.y;
        local w,h       = img:getWidth(),img:getHeight();

        local quad = love.graphics.newQuad(anim.cropX,anim.cropY,transform.size.x,transform.size.y,w,h)
        love.graphics.draw(img,quad,x,y)
    end
end

return AnimationSystem