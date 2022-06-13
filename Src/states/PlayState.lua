-- Playing state
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

    self.pipeInterval = math.random(2, 3)
end

function PlayState:update(dt)
    self.pipeTimer = self.pipeTimer + dt

    -- spawn pipes 
    if self.pipeTimer > self.pipeInterval then
        local y = math.max(34, math.min(self.lastY + math.random(-30, 30), VIRTUAL_HEIGHT - 120 - 16 - 34))
        self.lastY = y

        table.insert(self.pipePairs, PipePair(y))

        self.pipeTimer = 0

        self.pipeInterval = math.random(2, 3)
    end

    -- bird update
    self.bird:update(dt)

    -- (all) pipes update
    for k, pair in pairs(self.pipePairs) do
        pair:update(dt)

        if not pair.scored then
            if self.bird.x > pair.x + PIPE_WIDTH then
                self.score = self.score + 1
                pair.scored = true

                sounds['score']:play()
            end
        end

        for i, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                gStateMachine:change('score', {score = self.score})

                sounds['explosion']:play()
                sounds['hurt']:play()
            end
        end 
    end

    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    -- check if bird touches the ground
    if self.bird.y >= VIRTUAL_HEIGHT - 16 then
        gStateMachine:change('score', {score = self.score})

        sounds['explosion']:play()
        sounds['hurt']:play()
    end 
end

function PlayState:render()
    -- render (all) pipes
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    -- render bird
    self.bird:render()

    -- render current score
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)    
end

function PlayState:exit() end