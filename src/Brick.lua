-- Brick class

Brick = Object:extend()

function Brick:new(x, y, width, height, bricktype)
    local defaultWidth = 16
    local defaultHeight = 8
    
    self.x = x
    self.y = y
    self.image = sprites['brick']
    self.width = width or defaultWidth
    self.height = height or defaultHeight
    self.bricktype = bricktype
end

function Brick:update(dt)
end

function Brick:draw()
    local r, g, b, a = love.graphics.getColor()

    if self.bricktype == 7 then
        love.graphics.setColor(red)
    elseif self.bricktype == 6 then
        love.graphics.setColor(orange)
    elseif self.bricktype == 5 then
        love.graphics.setColor(yellow)
    elseif self.bricktype == 4 then
        love.graphics.setColor(green)
    elseif self.bricktype == 3 then
        love.graphics.setColor(cyan)
    elseif self.bricktype == 2 then
        love.graphics.setColor(blue)
    elseif self.bricktype == 1 then
        love.graphics.setColor(purple)
    end

    love.graphics.draw(self.image, self.x, self.y)
    
    love.graphics.setColor(r, g, b, a)
end