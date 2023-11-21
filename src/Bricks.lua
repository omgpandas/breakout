-- Bricks class

Bricks = Object:extend()

function Bricks:new()
    self.currentLevel = {}
    self.topLeftX = 8
    self.topLeftY = 24
    self.defaultWidth = 16
    self.defaultHeight = 8
    self.paddingLeftRight = 0
    self.paddingTopBottom = 0
    self.noBricks = false
end

function Bricks:constructLevel(levelBricks)
    self.noBricks = false

    for rowIndex, row in ipairs(levelBricks) do
        for colIndex, bricktype in ipairs(row) do
            if bricktype ~= 0 then
                local newBrickX = self.topLeftX +
                    (colIndex - 1) *
                    (self.defaultWidth + self.paddingLeftRight)
                local newBrickY = self.topLeftY + 
                    (rowIndex - 1) *
                    (self.defaultHeight + self.paddingTopBottom)
                local newBrick = Brick(newBrickX, newBrickY, self.defaultWidth, self.defaultHeight, bricktype)
                self:addToCurrentLevel(newBrick)
            end
        end
    end
end

function Bricks:addToCurrentLevel(brick)
    table.insert(self.currentLevel, brick)
end

function Bricks:brickHitByBall(i, brick, shiftBallX, shiftBallY)
    if brick.bricktype == 1 then
        table.remove(bricks.currentLevel, i)
    else
        self:decreaseRank(brick)
    end
end

function Bricks:decreaseRank(brick)
    if brick.bricktype > 1 and brick.bricktype < 8 then
        brick.bricktype = brick.bricktype - 1
    end
end

function Bricks:clearCurrentLevel()
    for i in pairs(self.currentLevel) do
        self.currentLevel[i] = nil
    end
end

function Bricks:update(dt)
    local noBricks = true
    
    for _, brick in pairs(self.currentLevel) do
        if brick.bricktype == 8 then
            noBricks = noBricks and true
        else
            noBricks = noBricks and false
        end
    end
    
    self.noBricks = noBricks
end

function Bricks:draw()
    for _, brick in pairs(self.currentLevel) do
        brick:draw(brick)
    end
end