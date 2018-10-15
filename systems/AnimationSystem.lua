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
        local motion    = World.components[Motion.id][k];
        local sheet     = World.components[SpriteSheet.id][k];

        if input.direction == -1 then -- Left
            self:Play(anim,anim.left,true);
        elseif input.direction == 1 then -- Right
            self:Play(anim,anim.right,true);
        else -- Idle
            self:Play(anim,anim.idle,true);
        end
    end
end

function AnimationSystem:Play(anim,seq,loop)
    if not anim.time then anim.time = love.timer.getTime(); end

    if love.timer.getTime()-anim.time >= anim.delay then
        anim.time = love.timer.getTime();

        if anim.x < seq[2] then -- 2 = endX 
            anim.x = anim.x+1;
        else
            if loop then
                anim.x = seq[1]; -- Restart x sequence
            end
        end

        if anim.y < seq[4] then -- 4 = endY
            anim.y = anim.y+1;
        else
            if loop then
                anim.y = seq[3]; -- Restart y sequence.
            end
        end      
    end
end

function AnimationSystem:Draw() 
    for k,v in pairs(self.entities) do
        local input     = World.components[Input.id][k];
        local transform = World.components[Transform.id][k];
        local sheet     = World.components[SpriteSheet.id][k];
        local anim      = World.components[Animation.id][k];
        local img       = World.components[SpriteSheet.id][k].img;
        local x,y       = transform.position.x,transform.position.y;
        local w,h       = img:getWidth(),img:getHeight();
        local quad      = sheet.sprites[anim.y][anim.x];

        if input.direction == -1 or input.lastDirection == -1 then
            love.graphics.draw(img,quad,x,y,0,-1,1,transform.size.x)            
        else 
            love.graphics.draw(img,quad,x,y)
        end

        -- if Config.DEBUG then
        --     love.graphics.rectangle("line",x,y,anim.w,anim.h);
        -- end
    end
end

return AnimationSystem