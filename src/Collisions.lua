-- Collisions class

Collisions = Object:extend()

function Collisions:resolveCollisions(ball, paddle, walls, bricks, scoreboard)
    collisions:ballPaddleCollision(ball, paddle)
    collisions:ballWallsCollision(ball, walls)
    collisions:ballBricksCollision(ball, bricks, scoreboard)
    collisions:paddleWallsCollision(paddle, walls)
    collisions:ballFloorCollision(ball, walls, scoreboard)
end

function Collisions:checkOverlap(a, b)
    local overlap = false
    local shiftBX = 0
    local shiftBY = 0

    local aLeft = a.x
    local aRight = a.x + a.width
    local aTop = a.y
    local aBottom = a.y + a.height

    local bLeft = b.x
    local bRight = b.x + b.width
    local bTop = b.y
    local bBottom = b.y + b.height
    
    if not(aRight < bLeft or bRight < aLeft or
           aBottom < bTop or bBottom < aTop) then
        overlap = true
        if (aRight / 2) < (bRight / 2) then
            shiftBX = aRight - bLeft
        else
            shiftBX = aLeft - bRight
        end
        if (aBottom) / 2 < (bBottom / 2) then
            shiftBY = aBottom - bTop
        else
            shiftBY = aTop - bBottom
        end
    end

    return overlap, shiftBX, shiftBY
end

function Collisions:ballPaddleCollision(ball, paddle)
    local overlap, shiftBallX, shiftBallY
    local a = { x = paddle.x,
                y = paddle.y,
                width = paddle.width,
                height = paddle.height }
    local b = { x = ball.x - ball.radius,
                y = ball.y - ball.radius,
                width = 2 * ball.radius,
                height = 2 * ball.radius }
    overlap, shiftBallX, shiftBallY = self:checkOverlap(a, b)
    if overlap then
        --ball:rebound(shiftBallX, shiftBallY)
        ball:paddleRebound(shiftBallX, shiftBallY)
        sounds['paddle-hit']:play()
        --print('ball-paddle collision')
    end
end

function Collisions:ballWallsCollision(ball, walls)
    local overlap, shiftBallX, shiftBallY
    local b = { x = ball.x - ball.radius,
                y = ball.y - ball.radius,
                width = 2 * ball.radius,
                height = 2 * ball.radius }
    for _, wall in pairs(walls.currentLevel) do
        local a = { x = wall.x,
                    y = wall.y,
                    width = wall.width,
                    height = wall.height }
        overlap, shiftBallX, shiftBallY = self:checkOverlap(a, b)
        if overlap then
            ball:rebound(shiftBallX, shiftBallY)
            sounds['wall-hit']:play()
            --print('ball-wall collision')
        end
    end
end

function Collisions:ballBricksCollision(ball, bricks, scoreboard)
    local overlap, shiftBallX, shiftBallY
    local b = { x = ball.x - ball.radius,
                y = ball.y - ball.radius,
                width = 2 * ball.radius,
                height = 2 * ball.radius }
    for i, brick in pairs(bricks.currentLevel) do
        local a = { x = brick.x,
                    y = brick.y,
                    width = brick.width,
                    height = brick.height }
        overlap, shiftBallX, shiftBallY = collisions:checkOverlap(a, b)
        if overlap then
            ball:rebound(shiftBallX, shiftBallY)
            bricks:brickHitByBall(i, brick, shiftBallX, shiftBallY)
            scoreboard:increaseScore()
            sounds['brick-hit']:play()
            --print('ball-brick collision')
        end
    end
end

function Collisions:paddleWallsCollision(paddle, walls)
    local overlap, shiftPaddleX, shiftPaddleY
    local b = { x = paddle.x,
                y = paddle.y,
                width = paddle.width,
                height = paddle.height }
    for _, wall in pairs(walls.currentLevel) do
        local a = { x = wall.x,
                    y = wall.y,
                    width = wall.width,
                    height = wall.height }
        overlap, shiftPaddleX, shiftPaddleY = self:checkOverlap(a, b)
        if overlap then
            paddle:rebound(shiftPaddleX, shiftPaddleY)
            --print('paddle-wall collision')
        end
    end
end

function Collisions:ballFloorCollision(ball, walls, scoreboard)
    local overlap
    local b = { x = walls.currentLevel['bottom'].x,
                y = walls.currentLevel['bottom'].y,
                width = walls.currentLevel['bottom'].width,
                height = walls.currentLevel['bottom'].height }
    local a = { x = ball.x - ball.radius,
                y = ball.y - ball.radius,
                width = 2 * ball.radius,
                height = 2 * ball.radius }
    overlap = collisions:checkOverlap(a, b)
    if overlap then
        scoreboard:loseLife()
        ball:respawn()
    end
end