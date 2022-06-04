Pipe = Class{}

function Pipe:init(orientaion, y)
    self.x = VIRTUAL_WIDTH
    self.y = y

    self.orientaion = orientaion
end

function Pipe:render()
    love.graphics.draw(
        PIPE_IMAGE, -- image
        self.x, -- x position
        (self.orientaion == 'top' and self.y + PIPE_HEIGHT or self.y), -- y position
        0, -- rotation
        1, -- X scale
        (self.orientaion == 'top' and -1 or 1) -- Y scale
    )
end