IA = class:new()

function IA:load()
    if levelnum == 1 then
        ias = {}
        ias[1] = IA:new(1, 200, 800)
        ias[2] = IA:new(2, 600, 800)
    end
    if levelnum == 2 then
        ias = {}
        ias[1] = IA:new(1)
    end    
end    

function IA:draw()
    if not(ias == nil) then
        for i = 1, #ias do
            if not(ias[i] == nil) then
                love.graphics.draw(ias[i].sprite, ias[i].x, ias[i].y)
                ias[i]:update()
            end    
        end
    end        
end    

function IA:init(value, x, y)
    self.sprite = love.graphics.newImage("img/entities/monsters/test.png")
    self.value = value
    self.x = x or 200
    self.y = y or 800
    self.originx = 200
    self.originy = 800
    self.timer = 2
    self.damagetimer = 0
    self.num = {name = "test_"..tostring(value)} 
    self.y_velocidad = 0
    self.y_collide = false
    self.gravity = 400
    self.jump_height = 250  
    self.hp = 3
    world:add(self.num, self.x, self.y, self.sprite:getWidth(), self.sprite:getHeight())
end    

function IA:update()
    if not(ias[self.value] == nil) then
        self:direction()
        self:move()
    end    
end

function IA:direction()
    if self.y_velocidad == 0 or self.y_collide == true then
        self.timer = self.timer + time
        if self.timer >= 2 then
            if player.x > self.x then
                self.isright = true
            elseif player.x < self.x then
                self.isright = false
            end
            self.timer = 0
        end
    end    
end  

function IA:move() 
    local actualX, actualY, cols, len = world:move(self.num, self.x, self.y - self.y_velocidad * time )
    if self.y > 800 then 
        self.y_velocidad = 0
        self.y = 800
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
	if self.isright == false then
	    local actualX, actualY, cols, len = world:move(self.num, self.x - (300 * time), self.y)
	    if (not(len > 0)) then
            self.x = self.x - (100 * time) 
        else       
            if IA:checkplayercollision(cols, len) == true then
                self.damagetimer = self.damagetimer + time
                if self.damagetimer >= 2 then
                    IA:playerdamage(1, true)
                    IA:damage(self.value, 1)
                    self.damagetimer = 0
                end   
            elseif love.math.random(10) > 1 then
                self.y_velocidad = self.jump_height  
            end    
        end  
	elseif self.isright == true then 
        local actualX, actualY, cols, len = world:move(self.num, self.x + (300 * time), self.y)
        if (not(len > 0)) then   
            self.x = self.x + (100 * time) 	    
        else  
            if IA:checkplayercollision(cols, len) == true then
                self.damagetimer = self.damagetimer + time
                if self.damagetimer >= 2 then
                    IA:playerdamage(1, false)
                    IA:damage(self.value, 1)
                    self.damagetimer = 0
                end   
            elseif love.math.random(10) > 1 then
                self.y_velocidad = self.jump_height  
            end    
        end      	
	end
end	
        
          
        
function IA:jump()
    if self.y_velocidad == 0 or self.y_collide == true then
        self.y_velocidad = 1000
        self.y_collide = false
    end
end   

function IA:playerdamage(damage, next)
    player:damage(damage)
    self.isright = next 
end  

function IA:checkplayercollision(cols, len) 
    local col = cols[i]
    for i=1,len do
        local col = cols[i]
        if col.other.name == "player" then
            return true
        end    
    end   
end    

function IA:checkIAcollision(cols, len) 
    local col = cols[i]
    for i=1,len do
        local col = cols[i]
        if tonumber(col.other.name) == true then
            return true
        end    
    end   
end  

function IA:damage(value, damage)
    self = ias[value]
    self.hp = self.hp - damage
    name = self.num
    if self.hp <= 0 and not(self == nil) then
        ias[value] = nil
        world:remove(name)
    end    
end   

function IA:unloadall()
    ias = nil
end    