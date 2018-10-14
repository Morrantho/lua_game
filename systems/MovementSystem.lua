-- local Transform = require("components/Transform")
local Motion    = require("components/Motion")
local Input     = require("components/Input")
local World     = require("World")

MovementSystem = require("systems/BaseSystem"):Register(
    bit.bor(Transform.id,Motion.id,Input.id)
)

function MovementSystem:Init(dt)
end

function MovementSystem:Update(dt)
    for entity in pairs(self.entities) do
        local transform = World.components[Transform.id][entity]
        local motion = World.components[Motion.id][entity]
        local input  = World.components[Input.id][entity]
        
        -- Moving Right 
        if input.direction == 1 then
            -- If you were moving left previously, slow them down
            if motion.velocity.x < 0 then
                motion.velocity.x = motion.velocity.x * (1 - math.min(motion.friction*motion.mass*dt,1))            
            end
            if motion.velocity.x < motion.maxSpeed then
                motion.velocity.x = motion.velocity.x+motion.speed*motion.mass*dt
            end
        end

        -- Moving Left
        if input.direction == -1 then
            -- If you were moving right previously, slow them down
            if motion.velocity.x > 0 then
                motion.velocity.x = motion.velocity.x * (1 - math.min(motion.friction*motion.mass*dt,1))                
            end
            if motion.velocity.x > -motion.maxSpeed then
                motion.velocity.x = motion.velocity.x-motion.speed*motion.mass*dt
            end
        end        

        -- Friction / Idle
        if motion.velocity.x ~= 0 and input.direction == 0 then
            motion.velocity.x = motion.velocity.x * (1 - math.min(motion.friction*motion.mass*dt,1))
        end

        -- Jump
        if input.jump then
            if motion.velocity.y == 0 then
                motion.velocity.y = -motion.jumpHeight
            end
        end
        
        -- Fall / Gravity
        motion.velocity.y = motion.velocity.y + motion.mass * dt
    end
end

function MovementSystem:Draw() end

return MovementSystem