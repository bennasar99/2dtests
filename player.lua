player = {}

function player:load(x, y, hp) 
    self.isright = true
    self.x = x
    self.y = y
    self.velocidad = 100
    self.y_velocidad = 0
    self.y_colide = false
    self.gravity = 400
    self.jump_height = 250
    self.h = 120
    self.w = 67
    self.collide = {name = "player"}
    self.right = love.graphics.newImage("img/entities/player/player_right.png")
    self.right1 = love.graphics.newImage("img/entities/player/player_right1.png")
    self.right2 = love.graphics.newImage("img/entities/player/player_right2.png")
    self.right3 = love.graphics.newImage("img/entities/player/player_right3.png")
    self.right4 = love.graphics.newImage("img/entities/player/player_right4.png")
    self.right5 = love.graphics.newImage("img/entities/player/player_right5.png")
    self.left = love.graphics.newImage("img/entities/player/player_left.png")
    self.left1 = love.graphics.newImage("img/entities/player/player_left1.png")
    self.left2 = love.graphics.newImage("img/entities/player/player_left2.png")
    self.left3 = love.graphics.newImage("img/entities/player/player_left3.png")
    self.left4 = love.graphics.newImage("img/entities/player/player_left4.png")
    self.left5 = love.graphics.newImage("img/entities/player/player_left5.png")
    self.hp = hp or 6 
    self.hpbar = nil
    world:add(self.collide, self.x, self.y, self.w, self.h)
    self.hpbar = love.graphics.newImage("img/entities/player/hpbar/"..self.hp..".png")
end


function player:draw()
    local actualX, actualY, cols, len = world:move(self.collide, self.x, self.y - self.y_velocidad * time)
    if self.y > 750 then 
        self.y_velocidad = 0
        self.y = 750
    end 
    if not(self.y_velocidad == 0) then
        if len > 0 then
            if self.y_velocidad > 0 then
                self.y_velocidad = -self.y_velocidad
            else    
                self.y_collide = true
            end
        else
            self.y = self.y - self.y_velocidad * time 
            self.y_velocidad = self.y_velocidad - self.gravity * time
        end  
    end    
	if a_down == true then
	    level:checklevel()
	    player:velocity()
	    local actualX, actualY, cols, len = world:move(self.collide, self.x - (self.velocidad * time), self.y)
	    if (not(len > 0)) then
            if self.x < (level.w - (winW / 2)) and self.x > (0 + (winW / 2))then
                --camera:move(-self.velocidad * time, 0)--
                camera:setPosition(self.x - winW / 2, camera.y)
            end
            self.x = self.x - (self.velocidad * time) 
            self.isright = false  
        end
        player:animate()    
	elseif d_down == true then
	    level:checklevel()
	    player:velocity()
        local actualX, actualY, cols, len = world:move(self.collide, self.x + (self.velocidad * time), self.y)
        if (not(len > 0)) then
            if self.x < (level.w - (winW / 2)) and self.x > (0 + (winW / 2)) then
                --camera:move(self.velocidad * time, 0)--
                camera:setPosition(self.x - winW / 2, 0)
            end    
            self.x = self.x + (self.velocidad * time) 
            self.isright = true  	    
        end      
        player:animate()   	
	else
	    if self.isright == true then
            love.graphics.draw(self.right, self.x, self.y)	
        elseif self.isright == false then  
            love.graphics.draw(self.left, self.x, self.y)	  
        end	
        tick = 0
	end	
end		

function player:velocity()
    if love.keyboard.isDown("lshift") then
        player.velocidad = 350
    else
        player.velocidad = 200
    end
end    

function player:jump()
    if player.y_velocidad == 0 or player.y_collide == true then
        player.y_velocidad = player.jump_height
        player.y_collide = false
    end
end    

function player:animate()
    if love.keyboard.isDown("a") then
        if tick >= 3 and tick < 6 then
            love.graphics.draw(player.left1, player.x, player.y)
        elseif tick >= 6 and tick < 10 then
            love.graphics.draw(player.left2, player.x, player.y)
        elseif tick >= 10 and tick < 14 then
            love.graphics.draw(player.left3, player.x, player.y)      
        elseif tick >= 14 and tick < 17 then
            love.graphics.draw(player.left4, player.x, player.y)  
        elseif tick >= 17 and tick < 20 then
            love.graphics.draw(player.left5, player.x, player.y)              
        elseif tick == 20 then
            love.graphics.draw(player.left, player.x, player.y)
            tick = 1
        else
            love.graphics.draw(player.left, player.x, player.y)
        end    
        tick = tick + 1  
    elseif love.keyboard.isDown("d") then   
            if tick >= 3 and tick < 6 then
            love.graphics.draw(player.right1, player.x, player.y)
        elseif tick >= 6 and tick < 10 then
            love.graphics.draw(player.right2, player.x, player.y)
        elseif tick >= 10 and tick < 14 then
            love.graphics.draw(player.right3, player.x, player.y)      
        elseif tick >= 14 and tick < 17 then
            love.graphics.draw(player.right4, player.x, player.y)  
        elseif tick >= 17 and tick < 20 then
            love.graphics.draw(player.right5, player.x, player.y)              
        elseif tick == 20 then
            love.graphics.draw(player.right, player.x, player.y)
            tick = 1
        else
            love.graphics.draw(player.right, player.x, player.y)
        end    
        tick = tick + 1  
    end     
end  

function player:damage(damage)
    player.hp = player.hp - damage
    if player.hp <= 0 then
        level:load()
        player:load(0, 750, 6)
        IA:load()
        camera:setPosition(0,0)
    end    
    player.hpbar = love.graphics.newImage("img/entities/player/hpbar/"..player.hp..".png")
end   
