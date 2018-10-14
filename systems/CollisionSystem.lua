local Transform = require("components/Transform")
local SpriteSheet = require("components/SpriteSheet")
local CanCollide = require("components/CanCollide")
local World     = require("World")

CollisionSystem = require("systems/BaseSystem"):Register(
    bit.bor(Transform.id,SpriteSheet.id,CanCollide.id)
)

function CollisionSystem:Init()
end

function CollisionSystem:Update(dt) 
    for a in pairs(self.entities) do
        for b in pairs(self.entities) do
            if a ~= b then
                -- Don't check self-collision
                self:CheckCollision(a,b)
            end
        end
    end
end

function CollisionSystem:Draw() end

function CollisionSystem:CheckCollision(a,b)
    local aTransform,aSprite = World.components[Transform.id][a],World.components[SpriteSheet.id][a]
    local bTransform,bSprite = World.components[Transform.id][b],World.components[SpriteSheet.id][b]
    local aX,aY,aW,aH = aTransform.position.x,aTransform.position.y,aTransform.size.x,aTransform.size.y
    local bX,bY,bW,bH = bTransform.position.x,bTransform.position.y,bTransform.size.x,bTransform.size.y

    if aX < bX+bW and bX < aX+aW and aY < bY+bH and bY < aY+aH then
        World:AddComponent(a,Collider.id,b)
        World:AddComponent(b,Collider.id,a)
    end
end

return CollisionSystem