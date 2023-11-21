-- Dependencies

Object = require 'lib/classic'
push = require 'lib/push'

require 'src/constants'
require 'src/Ball'
require 'src/Brick'
require 'src/Bricks'
require 'src/Collisions'
require 'src/Levels'
require 'src/Paddle'
require 'src/Scoreboard'
require 'src/StateMachine'
require 'src/Walls'
require 'src/states/BaseState'
require 'src/states/GameOverState'
require 'src/states/EnterHighScoreState'
require 'src/states/HighScoreState'
require 'src/states/PauseState'
require 'src/states/PlayState'
require 'src/states/TitleScreenState'

fonts = {
    ['small'] = love.graphics.newFont('src/fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('src/fonts/font.ttf', 16),
    ['large'] = love.graphics.newFont('src/fonts/font.ttf', 32)
}

sprites = {
    ['paddle'] = love.graphics.newImage('src/sprites/paddle.png'),
    ['paddle-shadow'] = love.graphics.newImage('src/sprites/paddle-shadow.png'),
    ['ball'] = love.graphics.newImage('src/sprites/ball.png'),
    ['ball-shadow'] = love.graphics.newImage('src/sprites/ball-shadow.png'),
    ['brick'] = love.graphics.newImage('src/sprites/brick-white.png')
}

sounds = {
    ['brick-hit'] = love.audio.newSource('src/sounds/brick-hit.wav', 'static'),
    ['paddle-hit'] = love.audio.newSource('src/sounds/paddle-hit.wav', 'static'),
    ['pause'] = love.audio.newSource('src/sounds/pause.wav', 'static'),
    ['wall-hit'] = love.audio.newSource('src/sounds/wall-hit.wav', 'static')
}