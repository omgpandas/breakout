-- TitleScreenState class

TitleScreenState = BaseState:extend()

function TitleScreenState:new()
    self.highlighted = 1
end

function TitleScreenState:update(dt)
    -- Move menu selection up/down.
    if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
        self.highlighted = self.highlighted == 1 and 2 or 1
    end

    -- Confirm option.
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if self.highlighted == 1 then
            stateMachine:change('play')
        elseif self.highlighted == 2 then
            stateMachine:change('highscore')
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function TitleScreenState:draw()
    local r, g, b, a = love.graphics.getColor()
    
    love.graphics.setFont(fonts['large'])
    love.graphics.printf('BREAKOUT', 0, gameHeight / 3, gameWidth, 'center')

    love.graphics.setFont(fonts['medium'])
    if self.highlighted == 1 then
        love.graphics.setColor(0, 1, 0, 1)
    end
    love.graphics.printf('START', 0, gameHeight / 2 + 70, gameWidth, 'center')

    love.graphics.setColor(1, 1, 1, 1)

    if self.highlighted == 2 then
        love.graphics.setColor(0, 1, 0, 1)
    end
    love.graphics.printf('HIGH SCORES', 0, gameHeight / 2 + 90, gameWidth, 'center')

    love.graphics.setColor(r, g, b, a)
end