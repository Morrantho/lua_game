local Transform = require("components/Transform")
local Sprite = require("components/Sprite")
local SpriteSheet = require("components/SpriteSheet")
local Animation = require("components/Animation");

RenderSystem = require("systems/BaseSystem"):Register(
    bit.bor(Transform.id,SpriteSheet.id)
)

function RenderSystem:Init(dt) end

function RenderSystem:Update(dt) end

function RenderSystem:Draw()
    local player;

    for e in pairs(self.entities) do
        if World.components[Player.id][e] then
            player = e;
            break;
        end
    end

    for entity in pairs(self.entities) do
        local transform = World.components[Transform.id][entity];
        local animation = World.components[Animation.id][entity];
        local sheet    = World.components[SpriteSheet.id][entity];
        local x,y       = transform.position.x,transform.position.y;
        local w,h       = sheet.img:getWidth(),sheet.img:getHeight();

        if animation then return end -- Let the animation system take care of rendering this entity.

        local quad = love.graphics.newQuad(0,0,transform.size.x,transform.size.y,w,h)

        love.graphics.push()
            love.graphics.scale(Config.XSCALE,Config.YSCALE);            
            
            if player then
                local winW,winH = love.graphics.getWidth(),love.graphics.getHeight();
                local playerPos = World.components[Transform.id][player];
                local pX = playerPos.position.x;
                local pY = playerPos.position.y;
                local plW = playerPos.size.x;
                local plH = playerPos.size.y;

                winW = winW / 2 - plW;
                winH = winH / 2 - plH;

                love.graphics.translate(-pX + winW / Config.XSCALE, -pY + winH / Config.YSCALE);
            end

            love.graphics.draw(sheet.img,quad,x,y);
        love.graphics.pop();
    end 
end

return RenderSystem