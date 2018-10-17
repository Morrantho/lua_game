local SpriteSheet = require("components/SpriteSheet")
local Input       = require("components/Input")
local Transform   = require("components/Transform");
local Animation   = require("components/Animation");
local Vector2     = require("vector/Vector2")
local Collider    = require("components/Collider");

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
        local coll      = World.components[Collider.id][k];

        if input.jump and not input.fall then
            self:Play(anim,anim.jump,true);
        elseif input.direction == -1 and not input.fall then -- Left
            self:Play(anim,anim.run,true);
        elseif input.direction == 1 and not input.fall then -- Right
            self:Play(anim,anim.run,true);
        elseif input.crouch and not input.fall then
            self:Play(anim,anim.crouch,true);            
        else -- Idle
            if input.fall then
                self:Play(anim,anim.fall,true);                
            else
                self:Play(anim,anim.idle,true);
            end
        end
    end
end

function AnimationSystem:Play(anim,seq,loop)
    if not anim.time then anim.time = love.timer.getTime(); end

    if love.timer.getTime()-anim.time >= anim.delay then
        anim.time = love.timer.getTime();

        if anim.frame < #seq then
            anim.frame = anim.frame+1
        else
            if loop then
                anim.frame = 1                
            end
        end

        anim.x = seq[anim.frame][1]
        anim.y = seq[anim.frame][2]     
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

        if input.direction == -1 or input.lastDirection == -1 then -- moving left
            love.graphics.draw(img,quad,x,y,0,-1,1,transform.size.x)            
        elseif input.direction == 1 or input.lastDirection == 1 then -- moving right
            love.graphics.draw(img,quad,x,y)
        elseif input.lastXDirection == -1 then -- Idle and facing left
            love.graphics.draw(img,quad,x,y,0,-1,1,transform.size.x)                    
        elseif input.lastXDirection == 1 then -- Idle and facing right
            love.graphics.draw(img,quad,x,y)
        else -- Must be idling without having pressed anything yet.
            love.graphics.draw(img,quad,x,y)            
        end
        
        if Config.DEBUG then
            love.graphics.rectangle("line",x,y,sheet.spriteW,sheet.spriteH);
        end
    end
end

return AnimationSystem