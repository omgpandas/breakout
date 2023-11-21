-- EnterHighScoreState class

EnterHighScoreState = BaseState:extend()

function EnterHighScoreState:new()
    self.chars = {
        [1] = 65,
        [2] = 65,
        [3] = 65
    }
    self.highlightedChar = 1
end

function EnterHighScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        local name = string.char(self.chars[1]) .. string.char(self.chars[2]) .. string.char(self.chars[3])

        for i = 10, scoreboard.newHighScoreIndex, -1 do
            scoreboard.highScores[i + 1] = {
                name = scoreboard.highScores[i].name,
                score = scoreboard.highScores[i].score
            }
        end

        scoreboard.highScores[scoreboard.newHighScoreIndex].name = name
        scoreboard.highScores[scoreboard.newHighScoreIndex].score = scoreboard.newHighScore

        local scoresStr = ''
        for i = 1, 10 do
            scoresStr = scoresStr .. scoreboard.highScores[i].name .. '\n'
            scoresStr = scoresStr .. tostring(scoreboard.highScores[i].score) .. '\n'
        end

        love.filesystem.write('breakout.lst', scoresStr)

        stateMachine:change('highscore')
    end

    if love.keyboard.wasPressed('left') and self.highlightedChar > 1 then
        self.highlightedChar = self.highlightedChar - 1
    elseif love.keyboard.wasPressed('right') and self.highlightedChar < 3 then
        self.highlightedChar = self.highlightedChar + 1
    end

    if love.keyboard.wasPressed('up') then
        self.chars[self.highlightedChar] = self.chars[self.highlightedChar] + 1
        if self.chars[self.highlightedChar] > 90 then
            self.chars[self.highlightedChar] = 65
        end
    elseif love.keyboard.wasPressed('down') then
        self.chars[self.highlightedChar] = self.chars[self.highlightedChar] - 1
        if self.chars[self.highlightedChar] < 65 then
            self.chars[self.highlightedChar] = 90
        end
    end

    if love.keyboard.wasPressed('escape') then
        stateMachine:change('title')
    end
end

function EnterHighScoreState:draw()
    local r, g, b, a = love.graphics.getColor()

    love.graphics.setFont(fonts['medium'])
    love.graphics.printf('Your score: ' .. tostring(scoreboard.score), 0, 30, gameWidth, 'center')
    love.graphics.setFont(fonts['large'])

    if self.highlightedChar == 1 then
        love.graphics.setColor(0, 1, 0, 1)
    end
    love.graphics.print(string.char(self.chars[1]), gameWidth / 2 - 28, gameHeight / 2)
    love.graphics.setColor(1, 1, 1, 1)

    if self.highlightedChar == 2 then
        love.graphics.setColor(0, 1, 0, 1)
    end
    love.graphics.print(string.char(self.chars[2]), gameWidth / 2 - 6, gameHeight / 2)
    love.graphics.setColor(1, 1, 1, 1)

    if self.highlightedChar == 3 then
        love.graphics.setColor(0, 1, 0, 1)
    end
    love.graphics.print(string.char(self.chars[3]), gameWidth / 2 + 16, gameHeight / 2)
    love.graphics.setColor(1, 1, 1, 1)

    love.graphics.setFont(fonts['small'])
    love.graphics.printf('Press Enter to confirm!', 0, gameHeight - 18, gameWidth, 'center')

    love.graphics.setColor(r, g, b, a)
end