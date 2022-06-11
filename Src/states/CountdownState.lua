CountdownState = Class{__includes = BaseState}

local COUNTDOWN_TIME = 0.8

function CountdownState:enter() end

function CountdownState:init()
    self.timer = 0
    self.count = 3
end

function CountdownState:update(dt)
    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIME then
        self.timer = self.timer % COUNTDOWN_TIME
        self.count = self.count - 1

        if self.count == 0 then
            gStateMachine:change('play')
        end
    end
end

function CountdownState:render()
    love.graphics.setFont(hugeFont)
    love.graphics.setColor(255/255, 255/255, 255/255, (1-self.timer)*255/255)
    love.graphics.printf(tostring(self.count), 0, VIRTUAL_HEIGHT/2 - 24, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
end

function CountdownState:exit() end