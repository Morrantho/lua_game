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

        if motion.velocity.y >= -motion.jumpHeight and motion.velocity.y <= -.1 and not input.fall then -- Jumping
            self:Play(anim,anim.jump,true);
        elseif input.direction == -1 and not input.fall and not input.jump then -- Left
            self:Play(anim,anim.run,true);
        elseif input.direction == 1 and not input.fall and not input.jump then -- Right
            self:Play(anim,anim.run,true);
        elseif input.crouch then -- Crouching
            self:Play(anim,anim.crouch,true);            
        else
            if input.fall then -- Falling
                self:Play(anim,anim.fall,true);                
            else -- Idling
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
    local player;

    for e in pairs(self.entities) do
        if World.components[Player.id][e] then
            player = e;
            break;
        end
    end

    for k,v in pairs(self.entities) do
        local input     = World.components[Input.id][k];
        local transform = World.components[Transform.id][k];
        local sheet     = World.components[SpriteSheet.id][k];
        local anim      = World.components[Animation.id][k];
        local img       = World.components[SpriteSheet.id][k].img;
        local quad      = sheet.sprites[anim.y][anim.x];
        local x,y,w,h   = transform.position.x,transform.position.y,transform.size.x,transform.size.y;
        local spriteW,spriteH = sheet.spriteW,sheet.spriteH;
        local xOff,yOff = sheet.xOffset,sheet.yOffset;

        love.graphics.push()
            love.graphics.scale(Config.XSCALE,Config.YSCALE);            
           
            if player then
                local winW,winH = love.graphics.getWidth(),love.graphics.getHeight();
                local playerPos = World.components[Transform.id][player];
                local pX = playerPos.position.x;
                local pY = playerPos.position.y;

                winW = winW / 2 - spriteW/2;
                winH = winH / 2 - spriteH;

                love.graphics.translate(-pX + winW / Config.XSCALE,-pY + winH / Config.YSCALE);
            end

            if input.direction == -1 or input.lastDirection == -1 and not input.crouch then -- moving left
                love.graphics.draw(img,quad,x-w/2+spriteW/2+xOff,y-h/2+spriteH/2-yOff,0,-1,1,transform.size.x)
            elseif input.direction == 1 or input.lastDirection == 1 and not input.crouch then -- moving right
                love.graphics.draw(img,quad,x+w/2-spriteW/2-xOff,y+h/2-spriteH/2-yOff)
            elseif input.lastXDirection == -1 and not input.crouch then -- Idle and facing left
                love.graphics.draw(img,quad,x-w/2+spriteW/2+xOff,y-h/2+spriteH/2-yOff,0,-1,1,transform.size.x)
            elseif input.lastXDirection == 1 and not input.crouch then -- Idle and facing right
                love.graphics.draw(img,quad,x+w/2-spriteW/2-xOff,y+h/2-spriteH/2-yOff)
            elseif input.crouch then
                if input.lastXDirection == 1 then
                    love.graphics.draw(img,quad,x+w/2-spriteW/2-xOff,y-spriteH/2);
                elseif input.lastXDirection == -1 then
                   love.graphics.draw(img,quad,x-w/2+spriteW/2+xOff,y-spriteH/2,0,-1,1,transform.size.x);                                            
                end
            else -- Must be idling without having pressed anything yet.
                love.graphics.draw(img,quad,x+w/2-spriteW/2-xOff,y+h/2-spriteH/2-yOff);
            end
            
            if Config.DEBUG then
                love.graphics.rectangle("line",x,y,w,h);
            end

        love.graphics.pop()
    end
end

return AnimationSystem