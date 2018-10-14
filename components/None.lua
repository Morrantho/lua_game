None = {id=nil}

setmetatable(None,{
    __call=function(s,entity)
        local this = {}
        return this
    end
})

return None