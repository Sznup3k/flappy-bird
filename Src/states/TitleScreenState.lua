-- Title screen state
TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:enter() end

function TitleScreenState:update(dt)
    if keyPressed('enter') or keyPressed('return') then
        gStateMachine:change('countdown')
    end
end

function TitleScreenState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Flappy Bird', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter', 0, 100, VIRTUAL_WIDTH, 'center')
end

function TitleScreenState:exit() end