-- Levels class

Levels = Object:extend()

function Levels:new()
    self.currentLevel = 1
    self.gameFinished = false
    self.sequence = require 'src/levels/sequence'
    
    bricks:constructLevel(self:loadLevel())
end

function Levels:switchLevel(bricks, ball, levels)
    if bricks.noBricks then
        bricks:clearCurrentLevel()
        if self.currentLevel < #self.sequence then
            self.currentLevel = self.currentLevel + 1
            level = self:loadLevel()
            bricks:constructLevel(level)
            ball:respawn()
        else
            self.gameFinished = true
            stateMachine:change('gameover')
        end
    end
end

function Levels:loadLevel()
    local filename = 'src/levels/' .. self.sequence[self.currentLevel]
    local level = require(filename)
    return level
end

function Levels:draw()
    local r, g, b, a = love.graphics.getColor()

    -- Create background.
    love.graphics.setColor(102/255, 112/255, 124/255, 100/100)
    love.graphics.rectangle('fill', 0, 16, gameWidth, gameHeight)

    -- Serve text.
    if ball.served == false then
        love.graphics.setFont(fonts['small'])
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf('Press Space to serve!', 0, gameHeight / 2 + 40, gameWidth, 'center')
    end

    love.graphics.setColor(r, g, b, a)
end