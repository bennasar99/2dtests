background = {}

function background:load()
    self.image = love.graphics.newImage("img/level/background/"..levelnum..".png")
    self.x = 0
    self.y = 0
    self.w = background.image:getWidth()  
end    

function background:draw()
    love.graphics.draw(self.image, self.x, self.y)
end    
