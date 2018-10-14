Component = {lastId=-1}

function Component:Register()
    Component.lastId = Component.lastId+1
    local o = {}
    o.id = bit.lshift(1,Component.lastId)
    return o
end

return Component