BaseSystem = {}

function BaseSystem:Register(mask)
    local this = {}
    this.mask = mask
    this.entities = {}

    function this:Init()
    end

    function this:Update(dt)
    end

    function this:Draw()
    end

    return this
end

return BaseSystem