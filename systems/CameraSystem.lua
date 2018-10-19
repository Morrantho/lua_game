local Transform = require("components/Transform");
local Camera    = require("components/Camera");
local Player    = require("components/Player");

CameraSystem = require("systems/BaseSystem"):Register(
    bit.bor(Transform.id,Camera.id,Player.id)
)

function CameraSystem:Init(dt) end

function CameraSystem:Update(dt)
end

function CameraSystem:Draw() 
    for entity in pairs(self.entities) do
        local transform = World.components[Transform.id][entity];
        local cam       = World.components[Camera.id][entity];

        -- love.graphics.push()
        --     love.graphics.translate(-transform.position.x,-transform.position.y);
        -- love.graphics.pop();
    end
end

return CameraSystem