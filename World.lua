local Config = require("Config")

World = {
    mask = {},       -- The world's mask. For each entry (Entity Id) the entities' mask is stored.
    systems = {},    -- Stores a reference to each system type
    components = {}, -- Actual component data
}

function World:Init()
    local componentsDir = "components/"
    local components = love.filesystem.getDirectoryItems(componentsDir)
    local systemsDir = "systems/"
    local systems = love.filesystem.getDirectoryItems(systemsDir)

    for _,file in ipairs(components) do
        file = string.sub(file,0,#file-4)
        if file ~= "Component" and file ~= "None" then
            local comp = require(componentsDir..file)
            self.components[comp.id] = {}
            self.components[comp.id].ctor = comp
        end
    end

    for _,file in ipairs(systems) do
        file = string.sub(file,0,#file-4)
        
        if file ~= "BaseSystem" then
            local sys = require(systemsDir..file)
            if sys.mask then
                self.systems[sys.mask] = sys
            end
        end
    end

    for system in pairs(self.systems) do
        self.systems[system]:Init();
    end
end

function World:CreateEntity()
    for ent=1,Config.MAX_ENTITIES do
        if self.mask[ent] == nil then
            self.mask[ent] = 0
            return ent
        end
    end
    return Config.MAX_ENTITIES
end

function World:DestroyEntity(ent)
    self.mask[ent] = nil
end

-- Bitwise Or's a component mask. If this new mask matches a system, place the entity in the system's list of entities to iterate.
function World:AddComponent(ent,componentType,...)
    self.mask[ent] = bit.bor(self.mask[ent],componentType)
    -- Store the entities' new component by type and entity id and call its constructor.
    self.components[componentType][ent] = self.components[componentType].ctor(...)

    -- Find out what system this entity MIGHT now belong to after Bitwise Or'ing
    for system in pairs(self.systems) do
        if bit.band( system, self.mask[ent] ) == system then
            if not self.systems[system].entities[ent] then
                self.systems[system].entities[ent] = self.mask[ent]
            end
        end        
    end
end

-- Adds an animation sequence to an entities' animation table.
-- seq[1]: startX, seq[2]: endX, seq[3]: startY, seq[4]: endY
function World:AddSequence(ent,animType,seq)
    local animation = World.components[Animation.id][ent];
    animation[animType] = seq;
end

function World:RemoveComponent(ent,componentType)
    local mask = self.mask[ent]

    for system in pairs(self.systems) do
        if bit.band( system, componentType ) ~= 0 then
            if self.systems[system].entities[ent] then
                self.systems[system].entities[ent] = nil
            end
        end        
    end

    self.mask[ent] = bit.bxor(self.mask[ent],componentType)
end

function World:GetComponent(ent,componentType)
    return self.components[componentType][ent]
end

function World:HasComponent(ent,componentType)
    return self.components[componentType][ent] == true;
end

function World:Update(dt)
    for system in pairs(self.systems) do
        self.systems[system]:Update(dt)
    end
end

function World:Draw()
    for system in pairs(self.systems) do
        self.systems[system]:Draw()
    end
end

return World