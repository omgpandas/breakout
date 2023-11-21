-- Breakout

function love.load()
    require 'src/Dependencies'

    love.window.setTitle('Breakout')
    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    push:setupScreen(gameWidth, gameHeight, windowWidth, windowHeight, { 
        vsync = true,
        fullscreen = false, 
        resizable = true
    })

    paddle = Paddle()
    ball = Ball()
    bricks = Bricks()
    walls = Walls()
    levels = Levels()
    collisions = Collisions()
    scoreboard = Scoreboard()
    
    stateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        ['pause'] = function() return PauseState() end,
        ['gameover'] = function() return GameOverState() end,
        ['highscore'] = function() return HighScoreState() end,
        ['enterhighscore'] = function() return EnterHighScoreState() end
    }

    stateMachine:change('title')

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    return push:resize(w, h)
end

function love.update(dt)
    stateMachine:update(dt)
    
    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()

    stateMachine:draw()

    push:finish()
end

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end