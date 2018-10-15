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
    for entity in pairs(self.entities) do
        local transform = World.components[Transform.id][entity];
        local animation = World.components[Animation.id][entity];
        local sprite    = World.components[SpriteSheet.id][entity].img;
        local x,y       = transform.position.x,transform.position.y;
        local w,h       = sprite:getWidth(),sprite:getHeight();

        if animation then return end -- Let the animation system take care of rendering this entity.

        local quad = love.graphics.newQuad(0,0,transform.size.x,transform.size.y,w,h)
        love.graphics.draw(sprite,quad,x,y)

        if Config.DEBUG then
            love.graphics.rectangle("line",x,y,w,h);
        end
    end 
end

return RenderSystem