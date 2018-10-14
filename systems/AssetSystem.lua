AssetSystem = require("systems/BaseSystem"):Register(1337)
AssetSystem.SpriteSheets = {};
AssetSystem.Audio = {};

-- Load Sprites / Audio Here
function AssetSystem:Init()
    AssetSystem.SpriteSheets["base"]   = love.graphics.newImage("res/images/base.png");
    AssetSystem.SpriteSheets["wizard"] = love.graphics.newImage("res/images/wizard.png");
end

function AssetSystem:Update(dt) end

function AssetSystem:Draw() end

return AssetSystem