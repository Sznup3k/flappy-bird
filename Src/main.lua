--[[
    My Flappy Bird game from the GD50 course, Lecture 1

    Credits:
        - GD50 course (https://www.youtube.com/watch?v=3IdOCxHGMIo&list=PLhQjrBD2T383Vx9-4vJYFsJbvZ_D17Qzh&index=19)
]]

push = require 'push'

Class = require 'class'

require 'Bird'

require 'PipePair'

require 'StateMachine'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/titleScreenState'
require 'states/CountdownState'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512 --162
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.png')
local ground = love.graphics.newImage('ground.png')

local backgroundScroll = 0
local groundScroll = 0

local BACKGROUND_SCROLL_S = 25
GROUND_SCROLL_S = 60

local BACKGROUND_L_P = 413
local GROUND_L_P = 512

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Flappy bird')

    sounds = {
        ['jump'] = love.audio.newSource('jump.wav', 'static'),
        ['score'] = love.audio.newSource('score.wav', 'static'),
        ['hurt'] = love.audio.newSource('hurt.wav', 'static'),
        ['explosion'] = love.audio.newSource('explosion.wav', 'static'),
        ['music'] = love.audio.newSource('music.mp3', 'static')
    }

    sounds['music']:setLooping(true)
    sounds['music']:play()

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('flappy.ttf', 14)
    flappyFont = love.graphics.newFont('flappy.ttf', 28)
    hugeFont = love.graphics.newFont('flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
    gStateMachine:change('title')

    pause = false

    
    keyboard = {}   -- part of the keyPressed function
    
    mouse = {}   -- part of the mousePressed function
end

function love.resize(w, h)
    push:resize(w, h)
end

-- function to check for single keyboard inputs
function keyPressed(key)
    if keyboard[key] then
        return true
    else
        return false
    end
end

function mousePressed(button)
    if mouse[button] then
        return true
    else
        return false
    end
end

function love.keypressed(key)
    keyboard[key] = true

    if key == 'escape' then
        love.event.quit()
    end

    if key == 'f3' then
        enableFPS = enableFPS == 0 and 1 or 0
    end

    if key == 'p' then
        pause = pause == false and true or false
    end
end

function love.mousepressed(x, y, button)
    mouse[button] = true
end

function love.update(dt)
    if not pause then
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_S * dt) % BACKGROUND_L_P
        groundScroll = (groundScroll + GROUND_SCROLL_S * dt) % GROUND_L_P

        gStateMachine.current:update(dt)
    end

    keyboard = {}

    mouse = {}
end

function love.draw()
    push:start()
    
    love.graphics.draw(background, -backgroundScroll, 0)

    gStateMachine.current:render()

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT-16)

    if enableFPS == 1 then displayFPS() end

    push:finish()
end

function displayFPS()
    love.graphics.setFont(smallFont)
    love.graphics.setColor(245/255, 0/255, 0/255, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 2, 2)
end