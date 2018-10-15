local Transform = require("components/Transform")
local Sprite    = require("components/Sprite")
local SpriteSheet = require("components/SpriteSheet")
local World     = require("World")

Wall = {}

function Wall:New(x,y,w,h)
    local ent = World:CreateEntity()

    World:AddComponent(ent,Transform.id,x or 0,y or 0,w or nil,h or nil)
    World:AddComponent(ent,SpriteSheet.id,"wall.png",1,1)
    World:AddComponent(ent,Motion.id)
    World:AddComponent(ent,CanCollide.id)

    return ent
end

return Wall