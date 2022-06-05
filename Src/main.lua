push = require 'push'

Class = require 'class'

require 'Bird'

require 'PipePair'

require 'StateMachine'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/titleScreenState'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.png')
local ground = love.graphics.newImage('ground.png')

local backgroundScroll = 0
local groundScroll = 0

local BACKGROUND_SCROLL_S = 25
GROUND_SCROLL_S = 60

local BACKGROUND_L_P = 413
local GROUND_L_P = 512

local playing = true

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')

    love.window.setTitle('Flappy bird')

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

    --bird = Bird()

    --pipePairs = {}

    --pipeTimer = 0

    --lastY = math.random(20,80)

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
    gStateMachine:change('title')

    love.keyboard.keyspressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function keyPressed(key)
    if love.keyboard.keyspressed[key] then
        return true
    else
        return false
    end
end

function love.keypressed(key)
    love.keyboard.keyspressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    if playing then
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_S * dt) % BACKGROUND_L_P
        groundScroll = (groundScroll + GROUND_SCROLL_S * dt) % GROUND_L_P

        gStateMachine.current:update(dt)

        --[[pipeTimer = pipeTimer + dt

        if pipeTimer > 3 then
            y = math.max(34, math.min(lastY + math.random(-30, 30), VIRTUAL_HEIGHT - 120 - 16 - 34))
            lastY = y

            table.insert(pipePairs, PipePair(y))

            pipeTimer = 0
        end

        bird:update(dt)

        for k, pair in pairs(pipePairs) do
            pair:update(dt)

            for i, pipe in pairs(pair.pipes) do
                if bird:collides(pipe) then
                    playing = false
                end
            end 
        end

        for k, pair in pairs(pipePairs) do
            if pair.remove then
                table.remove(pipePairs, k)
            end
        end]]
    end

    love.keyboard.keyspressed = {}
end

function love.draw()
    push:start()
    
    love.graphics.draw(background, -backgroundScroll, 0)

    gStateMachine.current:render()

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT-16)

    push:finish()
end