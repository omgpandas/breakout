-- GameOverState class

GameOverState = BaseState:extend()

function GameOverState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        local highScore = false
        local scoreIndex = 11

        for i = 10, 1, -1 do
            local score = scoreboard.highScores[i].score or 0
            if scoreboard.score > score then
                highScoreIndex = i
                highScore = true
            end
        end

        scoreboard.newHighScore = scoreboard.score
        scoreboard.newHighScoreIndex = highScoreIndex

        if highScore then
            stateMachine:change('enterhighscore')
        else
            scoreboard.lives = 3
            scoreboard.score = 0
            levels.gameFinished = false
            levels.currentLevel = 1
            level = levels:loadLevel()
            bricks:constructLevel(level)
            paddle:respawn()
            ball:respawn()
            stateMachine:change('title')
        end
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function GameOverState:draw()
    if levels.gameFinished then
        local r, g, b, a = love.graphics.getColor()

        love.graphics.setColor(0, 0, 0, 0.50)
        love.graphics.rectangle('fill', 0, 0, gameWidth, gameHeight)

        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(fonts['medium'])
        love.graphics.printf('GAME OVER', 0, gameHeight / 2, gameWidth, 'center')

        love.graphics.setColor(r, g, b, a)
    end
end