PipePair = Class{}

require 'pipe'

PIPE_IMAGE = love.graphics.newImage('pipe.png')

PIPE_WIDTH = PIPE_IMAGE:getWidth()
PIPE_HEIGHT = PIPE_IMAGE:getHeight()

--GAP_HEIGHT = 90

function PipePair:init(y)
    self.x = VIRTUAL_WIDTH
    self.y = y - PIPE_HEIGHT

    self.pipes = {
        ['top'] = Pipe('top', self.y),
        ['bottom'] = Pipe('bottom', self.y + math.random(90, 120) + PIPE_HEIGHT) 
    }

    self.remove = false

    self.socred = false
end

function PipePair:update(dt)
    if self.x > -PIPE_WIDTH then
        self.x = self.x - GROUND_SCROLL_S * dt
        self.pipes['top'].x = self.x
        self.pipes['bottom'].x = self.x
    else
        self.remove = true
    end
end

function PipePair:render()
    self.pipes['top']:render()
    self.pipes['bottom']:render()
end