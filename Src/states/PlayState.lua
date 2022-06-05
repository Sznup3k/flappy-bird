PlayState = Class{__includes =  BaseState}

PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 38
BIRD_HEIGHT = 24

function PlayState:enter() end

function PlayState:init()
    self.bird = Bird()

    self.pipePairs = {}

    self.pipeTimer = 0

    self.score = 0

    self.lastY = math.random(20, 80)
end

function PlayState:update(dt)
    self.pipeTimer = self.pipeTimer + dt

    if self.pipeTimer > 3 then
        local y = math.max(34, math.min(self.lastY + math.random(-30, 30), VIRTUAL_HEIGHT - 120 - 16 - 34))
        self.lastY = y

        table.insert(self.pipePairs, PipePair(y))

        self.pipeTimer = 0
    end

    self.bird:update(dt)

    for k, pair in pairs(self.pipePairs) do
        pair:update(dt)

        if not pair.scored then
            if self.bird.x > pair.x + PIPE_WIDTH then
                self.score = self.score + 1
                pair.scored = true
            end
        end

        for i, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                gStateMachine:change('score', {score = self.score})
            end
        end 
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    if self.bird.y >= VIRTUAL_HEIGHT - 16 then
        gStateMachine:change('score', {score = self.score})
    end 
end

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

    self.bird:render()
end

function PlayState:exit() end