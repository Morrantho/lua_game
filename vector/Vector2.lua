local Vector = require("vector/Vector")

function Vector2(x,y)
    local this = Vector(x)
    this.y = y

    this.Dot = function(vec2)
        return this.x*vec2.x+this.y*vec2.y
    end

    this.Normal = function()
        return Vector2(this.y,-this.x)
    end

    this.Magnitude = function()
        return this.x^2+this.y^2
    end

    this.Unit = function()
        local mag = this.Magnitude()
        this.x = this.x/mag
        this.y = this.y/mag
    end

    this.Add = function(vec2)
        return Vector2(this.x+vec2.x,this.y+vec2.y)
    end

    this.Subtract = function(vec2)
        return Vector2(this.x-vec2.x,this.y-vec2.y)
    end

    this.Multiply = function(vec2)
        return Vector2(this.x*vec2.x,this.y*vec2.y)
    end

    this.Divide = function(vec2)
        return Vector2(this.x/vec2.x,this.y/vec2.y)
    end

    return this
end

return Vector2