local Transform = require("components/Transform")
local Sprite    = require("components/Sprite")
local World     = require("World")

Renderable = {}

function Renderable:New(x,y,sprite,w,h)
    local ent = World:CreateEntity()
    World:AddComponent(ent,Transform.id,x or 0,y or 0,w,h)
    World:AddComponent(ent,Sprite.id,sprite)
    return ent
end

return Renderable