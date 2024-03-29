local Transform = require("components/Transform")
local Motion    = require("components/Motion")
local Input     = require("components/Input")
local Player    = require("components/Player")
local Config    = require("Config")
local World     = require("World")

PlayerInputSystem = require("systems/BaseSystem"):Register(
    bit.bor(Transform.id,Motion.id,Input.id,Player.id)
)

function PlayerInputSystem:Init(dt)
end

function PlayerInputSystem:Update(dt)
    for entity in pairs(self.entities) do
        local input = World.components[Input.id][entity]
        local motion = World.components[Motion.id][entity]
        input.lastDirection = input.direction;

        if love.keyboard.isDown(Config.RIGHT) and not love.keyboard.isDown(Config.LEFT) then 
            input.direction = 1
        elseif love.keyboard.isDown(Config.LEFT) and not love.keyboard.isDown(Config.RIGHT) then
            input.direction = -1
        else
            if input.direction ~= 0 then
                input.lastXDirection = input.lastDirection;
            end

            input.direction = 0
        end
        
        if love.keyboard.isDown(Config.JUMP) then
            input.jump = true
        else
            input.jump = false
        end

        if love.keyboard.isDown(Config.USE) then
            input.use = true
        else
            input.use = false
        end

        if love.keyboard.isDown(Config.FIRE) then
            input.fire = true
        else
            input.fire = false
        end

        if love.keyboard.isDown(Config.CROUCH) then
            input.crouch = true
        else
            input.crouch = false
        end

        if love.keyboard.isDown("9") then
            Config.XSCALE = Config.XSCALE + .01 
            Config.YSCALE = Config.YSCALE + .01
        elseif love.keyboard.isDown("0") then
            Config.XSCALE = Config.XSCALE - .01
            Config.YSCALE = Config.YSCALE - .01           
        end
    end
end

function PlayerInputSystem:Draw() end

return PlayerInputSystem