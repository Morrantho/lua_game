local Transform = require("components/Transform")
local Sprite    = require("components/Sprite")
local SpriteSheet    = require("components/SpriteSheet")
local Collider  = require("components/Collider")
local Player    = require("components/Player")
local Input     = require("components/Input")
local NPC       = require("components/NPC")
local World     = require("World")

CollisionResolverSystem = require("systems/BaseSystem"):Register(
    bit.bor(Transform.id,SpriteSheet.id,Collider.id,Input.id)
)

function CollisionResolverSystem:Init(dt) 

end

function CollisionResolverSystem:Update(dt) 
    for a,value in pairs(self.entities) do
        local player = World.components[Player.id][a]
        local npc    = World.components[NPC.id][a]

        if player or NPC then
            local aTransform = World.components[Transform.id][a]
            local aMotion    = World.components[Motion.id][a]
            local aSprite    = World.components[SpriteSheet.id][a]
            local aCollider  = World.components[Collider.id][a]
            local aInput     = World.components[Input.id][a]

            local b          = aCollider.entity
            local bTransform = World.components[Transform.id][b]
            local bSprite    = World.components[SpriteSheet.id][b]
            local bMotion    = World.components[Motion.id][b]

            local aX,aY,aW,aH = aTransform.position.x,aTransform.position.y,aTransform.size.x,aTransform.size.y
            local bX,bY,bW,bH = bTransform.position.x,bTransform.position.y,bTransform.size.x,bTransform.size.y

            local top = aY+aH-bY
            local bot = bY+bH-aY
            local left = aX+aW-bX
            local right = bX+bW-aX

            local dirs = {top,bot,left,right}
            local min = top
            for a,b in pairs(dirs) do if min > b then min = b end end
            -- Find the smallest overlap and push back in that direction
            if top == min then
                aTransform.position.y = bTransform.position.y-aTransform.size.y
                aMotion.velocity.y = 0
                aInput.jump = false
            elseif bot == min then
                aTransform.position.y = bTransform.position.y+bTransform.size.y
                aMotion.velocity.y = aMotion.velocity.y+(.05+dt)
            elseif left == min then
                aTransform.position.x = bTransform.position.x-aTransform.size.x
                aMotion.velocity.x = aMotion.velocity.x-(.05+dt)
            elseif right == min then
                aTransform.position.x=bTransform.position.x+bTransform.size.x
                aMotion.velocity.x = aMotion.velocity.x+(.05+dt)
            end

            World:RemoveComponent(a,Collider.id)
            World:RemoveComponent(b,Collider.id)
        end
    end
end

function CollisionResolverSystem:Draw() end

return CollisionResolverSystem