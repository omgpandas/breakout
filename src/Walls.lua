-- Walls class

Walls = Object:extend()

function Walls:new()
    self.currentLevel = {}
    
    leftWall = {
        x = 0,
        y = 8,
        width = 8,
        height = gameHeight
    }
    rightWall = {
        x = gameWidth - 8,
        y = 8,
        width = 8,
        height = gameHeight
    }
    topWall = {
        x = 0,
        y = 8,
        width = gameWidth,
        height = 8
    }
    bottomWall = {
        x = 0,
        y = gameHeight - 8,
        width = gameWidth,
        height = 8
    }
    
    self.currentLevel['left'] = leftWall
    self.currentLevel['right'] = rightWall
    self.currentLevel['top'] = topWall
    self.currentLevel['bottom'] = bottomWall
end

function Walls:draw()
    love.graphics.rectangle('fill',
                            leftWall.x,
                            leftWall.y,
                            leftWall.width,
                            leftWall.height)
    love.graphics.rectangle('fill',
                            rightWall.x,
                            rightWall.y,
                            rightWall.width,
                            rightWall.height)
    love.graphics.rectangle('fill',
                            topWall.x,
                            topWall.y,
                            topWall.width,
                            topWall.height)
end