local World = require("World")
local Wall = require("entities/Wall")
local Vector2 = require("vector/Vector2");

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

    -- PLAYER
    local player = World:CreateEntity()
    World:AddComponent(player,SpriteSheet.id,"player.png",7,16,5,0)
    World:AddComponent(player,Transform.id,128,128,50,37)
    World:AddComponent(player,Animation.id,.125)
    
    World:AddSequence(player,"run",{ {1,1},{2,1},{3,1},{4,1},{5,1},{6,1} });
    World:AddSequence(player,"idle",{ {0,0},{1,0},{2,0},{3,0} });
    World:AddSequence(player,"crouch",{ {4,0},{5,0},{6,0},{0,1} });    
    World:AddSequence(player,"jump",{ {4,2},{5,2},{6,2}, });    
    World:AddSequence(player,"fall",{ {1,3},{2,3} });    

    World:AddComponent(player,Motion.id)
    World:AddComponent(player,Player.id)
    World:AddComponent(player,Input.id)
    World:AddComponent(player,CanCollide.id)
    -- PLAYER

    love.window.setMode(1024,768)
end

function love.update(dt)
    World:Update(dt)
end

function love.draw()
    World:Draw()
end