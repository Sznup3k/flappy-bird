Bird = Class{}

GRAVITY = 15

function Bird:init()
    self.image = love.graphics.newImage('bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)
    self.dy = 0
end

function Bird:collides(pipe)
    if self.x + self.width - 4 >= pipe.x and self.x + 4 <= pipe.x + pipe.width then
        if self.y + self.height - 4 >= pipe.y and self.y + 4 <= pipe.y + pipe.height then 
            return true
        end
    end

    return false
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt

    if keyPressed('space') then
        self.dy = -3.5
    end
    
    self.y = math.max(self.y + self.dy, 0)
end

function Bird:render()
    love.graphics.draw(self.image, self.x, self.y)
end