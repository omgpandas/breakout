-- PauseState class

PauseState = BaseState:extend()

function PauseState:update(dt)
    if love.keyboard.wasPressed('p') then
        stateMachine:change('play', { paddle, ball, bricks, walls, scoreboard })
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PauseState:draw()
    levels:draw()
    scoreboard:draw()
    walls:draw()
    bricks:draw()
    ball:draw()
    paddle:draw()

    local r, g, b, a = love.graphics.getColor()

    -- Dark overlay.
    love.graphics.setColor(0, 0, 0, 0.50)
    love.graphics.rectangle('fill', 0, 0, gameWidth, gameHeight)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(fonts['medium'])
    love.graphics.printf('PAUSED', 0, gameHeight / 2, gameWidth, 'center')

    love.graphics.setColor(r, g, b, a)
end