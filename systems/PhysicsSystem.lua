local Transform = require("components/Transform")
local Motion    = require("components/Motion")
local Vector2   = require("vector/Vector2")
local World     = require("World")

PhysicsSystem = require("systems/BaseSystem"):Register(
    bit.bor(Transform.id,Motion.id)
)

function PhysicsSystem:Init(dt)

end

function PhysicsSystem:Update(dt)
    for entity in pairs(self.entities) do
        local transform = World.components[Transform.id][entity]
        local motion = World.components[Motion.id][entity]
        local x = transform.position.x
        local y = transform.position.y

        transform.position.x = transform.position.x + motion.velocity.x
        transform.position.y = transform.position.y + motion.velocity.y

        motion.velocity.x = motion.velocity.x + motion.acceleration.x * dt
        motion.velocity.y = motion.velocity.y + motion.acceleration.y * dt

        transform.lastPosition = Vector2(x,y)
    end
end

function PhysicsSystem:Draw() end

return PhysicsSystem