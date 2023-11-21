-- Scoreboard class

Scoreboard = Object:extend()

function Scoreboard:new()
    self.lives = 3
    self.score = 0
    self.highScores = self:loadHighScores()
    self.newHighScore = 0
    self.newHighScoreIndex = 0
end

function Scoreboard:loseLife()
    self.lives = self.lives - 1

    if self.lives <= 0 then
        levels.gameFinished = true
        stateMachine:change('gameover')
    end
end

function Scoreboard:increaseScore()
    self.score = self.score + 100
end

function Scoreboard:loadHighScores()
    love.filesystem.setIdentity(love.filesystem.getIdentity(), true)
    if not love.filesystem.getInfo('breakout.lst') then
        local scores = ''
        for i = 10, 1, -1 do
            scores = scores .. 'CTO\n'
            scores = scores .. tostring(i * 1000) .. '\n'
        end

        love.filesystem.write('breakout.lst', scores)
    end
    
    local name = true
    local currentName = nil
    local counter = 1

    local scores = {}
    for i = 1, 10 do
        scores[i] = {
            name = nil,
            score = nil
        }
    end

    for line in love.filesystem.lines('breakout.lst') do
        if name then
            scores[counter].name = string.sub(line, 1, 3)
        else
            scores[counter].score = tonumber(line)
            counter = counter + 1
        end

        name = not name
    end

    return scores
end

function Scoreboard:draw()
    love.graphics.setFont(fonts['small'])
    love.graphics.print('LIVES: ' .. tostring(scoreboard.lives), 10, 0)
    love.graphics.print('SCORE: ' .. tostring(scoreboard.score), 50, 0)
end