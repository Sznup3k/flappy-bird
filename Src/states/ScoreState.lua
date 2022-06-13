-- Game over state
ScoreState = Class{__includes = BaseState}

function ScoreState:init()
    self.bronze = love.graphics.newImage('bronze.png')
    self.silver = love.graphics.newImage('silver.png')
    self.gold = love.graphics.newImage('gold.png')

    self.medal = self.bronze
end

function ScoreState:enter(params)
    self.score = params.score

    if self.score >= 2 then
        self.medal = self.bronze
        
        if self.score >= 5 then
            self.medal = self.silver
            
            if self.score >= 10 then
                self.medal = self.gold
            end
        end
    end
end

function ScoreState:update(dt)
    if keyPressed('enter') or keyPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    --[[
        Render the game over screen and your final score
    ]]
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 36, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    if self.score >= 2 then 
        love.graphics.draw(self.medal, VIRTUAL_WIDTH/2-32, VIRTUAL_HEIGHT/2 + 12 - 32)
        love.graphics.printf('Press Enter too Play Again!', 0, 198, VIRTUAL_WIDTH, 'center')
    else
        love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
    end
end

function ScoreState:exit() end