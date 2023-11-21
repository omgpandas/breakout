-- Paddle class

Paddle = Object:extend()

function Paddle:new()
    self.image = sprites['paddle']
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.x = (gameWidth / 2) - (self.width / 2)
    self.y = gameHeight - 32
    self.shadow = sprites['paddle-shadow']
end

function Paddle:rebound(shiftPaddleX, shiftPaddleY)
    self.x = self.x + shiftPaddleX
end

function Paddle:respawn()
    self.x = (gameWidth / 2) - (self.width / 2)
    self.y = gameHeight - 32
end

function Paddle:update(dt)
    -- Debug: Auto-move paddle.
    --[[
    if ball.served then
        self.x = ball.x - (self.width / 2)
    end
    ]]

    if love.keyboard.isDown('left') then
        self.x = self.x - (paddleSpeed * dt)
    end
    if love.keyboard.isDown('right') then
        self.x = self.x + (paddleSpeed * dt)
    end
end

function Paddle:draw()
    love.graphics.draw(self.shadow, self.x, self.y + 9)
    love.graphics.draw(self.image, self.x, self.y)
end