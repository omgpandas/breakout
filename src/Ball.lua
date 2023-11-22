-- Ball class

Ball = Object:extend()

function Ball:new()
    self.image = sprites['ball']
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.speedX = 0
    self.speedY = 0
    self.radius = self.width / 2
    self.shadow = sprites['ball-shadow']
    self.served = false
    
    self:respawn()
end

function Ball:rebound(shiftBallX, shiftBallY)
    local minShift = math.min(math.abs(shiftBallX),
                              math.abs(shiftBallY))

    if math.abs(shiftBallX) == minShift then
        shiftBallY = 0
    else
        shiftBallX = 0
    end
    
    self.x = self.x + shiftBallX
    self.y = self.y + shiftBallY
    
    if shiftBallX ~= 0 then
        self.speedX = -self.speedX
    end
    if shiftBallY ~= 0 then
        self.speedY = -self.speedY
    end
end

function Ball:paddleRebound(shiftBallX, shiftBallY)
    local minShift = math.min(math.abs(shiftBallX),
                              math.abs(shiftBallY))

    if math.abs(shiftBallX) == minShift then
        shiftBallY = 0
    else
        shiftBallX = 0
    end
    
    self.x = self.x + shiftBallX
    self.y = self.y + shiftBallY
    
    if shiftBallX ~= 0 then
        self.speedX = -self.speedX
    end
    if shiftBallY ~= 0 then
        self.speedY = -self.speedY
        -- If ball is moving left ...
        if self.speedX < 0 then
            -- If paddle is moving left ...
            if love.keyboard.isDown('left') then
                self:speedup('left')
            -- If paddle is moving right ...
            elseif love.keyboard.isDown('right') then
                self:slowdown('left')
            end
        -- If ball is moving right ...
        else
            -- If paddle is moving right ...
            if love.keyboard.isDown('right') then
                self:speedup('right')
            -- If paddle is moving left ...
            elseif love.keyboard.isDown('left') then
                self:slowdown('right')
            end
        end
    end
end

function Ball:speedup(ballDirection)
    -- If ball is moving left ...
    if ballDirection == 'left' then
        -- If ball is moving slower than top speed (-150).
        if self.speedX > -maxBallSpeed then
            -- Incriment speed.
            self.speedX = self.speedX - 50
        end
        -- Prevent straight line movement.
        if self.speedX == 0 then
            self.speedX = self.speedX - 50
        end
    -- If ball is moving right ...
    else
        -- If ball is moving slower than top speed (150).
        if self.speedX < maxBallSpeed then
            -- Incriment speed.
            self.speedX = self.speedX + 50
        end
        -- Prevent straight line movement.
        if self.speedX == 0 then
            self.speedX = self.speedX + 50
        end
    end
end

function Ball:slowdown(ballDirection)
    -- If ball is moving left ...
    if ballDirection == 'left' then
        -- If ball is moving faster than slowest speed (150).
        if self.speedX < maxBallSpeed then
            -- Decriment speed.
            self.speedX = self.speedX + 50
        end
        -- Prevent straight line movement.
        if self.speedX == 0 then
            self.speedX = self.speedX + 50
        end
    -- If ball is moving right ...
    else
        -- If ball is moving faster than slowest speed (-150).
        if self.speedX > -maxBallSpeed then
            -- Decriment speed.
            self.speedX = self.speedX - 50
        end
        -- Prevent straight line movement.
        if self.speedX == 0 then
            self.speedX = self.speedX - 50
        end
    end
end

function Ball:respawn()
    self.served = false
    self.x = (paddle.x + (paddle.width / 2)) - (self.width / 2)
    self.y = paddle.y - 15
end

function Ball:update(dt)
    if self.served then
        self.x = self.x + (self.speedX * dt)
        self.y = self.y + (self.speedY * dt)
    else
        -- Serve ball.
        self.x = (paddle.x + (paddle.width / 2)) - (self.width / 2)
        if love.keyboard.wasPressed('space') then
            
            -- Angle ball left or right if moving when serving.
            if love.keyboard.isDown('left') then
                self:speedup('left')
            elseif love.keyboard.isDown('right') then
                self:speedup('right')
            else
                self.speedX = 0
            end
            
            self.speedY = -ballSpeed
            self.served = true
        end
    end
end

function Ball:draw()
    love.graphics.draw(self.shadow, self.x, self.y + 9)
    love.graphics.draw(self.image, self.x, self.y)
end