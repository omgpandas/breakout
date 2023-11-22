-- PlayState class

PlayState = BaseState:extend()

function PlayState:update(dt)
    paddle:update(dt)
    ball:update(dt)
    bricks:update(dt)
    collisions:resolveCollisions(ball, paddle, walls, bricks, scoreboard)
    levels:switchLevel(bricks, ball, levels)

    -- Debug: Clear level bricks.
    if love.keyboard.wasPressed('c') then
        bricks:clearCurrentLevel()
    end

    if love.keyboard.wasPressed('p') then
        stateMachine:change('pause', { paddle, ball, bricks, walls, scoreboard })
        sounds['pause']:play()
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:draw()
    -- We draw the ball and paddle last to overlap bricks.
    levels:draw()
    scoreboard:draw()
    walls:draw()
    bricks:draw()
    ball:draw()
    paddle:draw()
end