-- BaseState class

BaseState = Object:extend()

function BaseState:new() end
function BaseState:enter() end
function BaseState:exit() end
function BaseState:update(dt) end
function BaseState:draw() end