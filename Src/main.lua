push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.png')
local ground = love.graphics.newImage('ground.png')

local backgroundScroll = 0
local groundScroll = 0

local BACKGROUND_SCROLL_S = 25
local GROUND_SCROLL_S = 60

local BACKGROUND_L_P = 413
local GROUND_L_P = 512

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Flappy bird')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.update(dt)
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_S * dt) % BACKGROUND_L_P
    groundScroll = (groundScroll + GROUND_SCROLL_S * dt) % GROUND_L_P
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end

function love.draw()
    push:start()
    love.graphics.draw(background, -backgroundScroll, 0)
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT-16)

    love.graphics.printf(
        'Hello Flappy bird!',
        0,
        VIRTUAL_HEIGHT/2-12,
        VIRTUAL_WIDTH,
        'center'
    )
    push:finish()
end