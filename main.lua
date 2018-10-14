local World = require("World")
local Wall = require("entities/Wall")

function love.load()
    World:Init()

    -- Floor
    Wall:New(64,512,1024,64)

    Wall:New(100,350,64,64)
    Wall:New(300,350,64,64)
    Wall:New(500,350,64,64)
    Wall:New(700,350,64,64)

    -- LWall
    Wall:New(0,0,64,1024)
    -- RWall
    Wall:New(1024,0,64,1024)

    local ent = World:CreateEntity()
    World:AddComponent(ent,Transform.id,128,128,60,90)
    World:AddComponent(ent,SpriteSheet.id,"wizard.png")
    World:AddComponent(ent,Animation.id)
    World:AddComponent(ent,Motion.id)
    World:AddComponent(ent,Player.id)
    World:AddComponent(ent,Input.id)
    World:AddComponent(ent,CanCollide.id)

    love.window.setMode(1024,768)
end

function love.update(dt)
    World:Update(dt)
end

function love.draw()
    World:Draw()
end