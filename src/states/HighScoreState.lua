-- HighScoreState class

HighScoreState = BaseState:extend()

function HighScoreState:update(dt)
    if love.keyboard.wasPressed('escape') or love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        stateMachine:change('title')
    end
end

function HighScoreState:draw()
    love.graphics.setFont(fonts['large'])
    love.graphics.printf('HIGH SCORES', 0, 10, gameWidth, 'center')

    love.graphics.setFont(fonts['medium'])
    
    for i = 1, 10 do
        local name = scoreboard.highScores[i].name or '---'
        local score = scoreboard.highScores[i].score or '---'

        love.graphics.printf(tostring(i) .. '.', 10, 60 + i * 13, 50, 'left')
        love.graphics.printf(name, 30, 60 + i * 13, 50, 'right')
        love.graphics.printf(tostring(score), gameWidth / 2, 60 + i * 13, 100, 'right')
    end
end