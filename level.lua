level = {}

function level:load()
    world = nil
    level.image = love.graphics.newImage("img/level/"..levelnum..".png")
    level.music = nil
    level.x = 0
    level.y = 0
    level.w = 0
    world = bumb.newWorld()
    level.w = level.image:getWidth()
    if levelnum > 1 then
        if love.filesystem.exists("music/"..levelnum..".mp3") == true then
            level.music = love.audio.newSource("music/"..levelnum..".mp3"),
            love.audio.stop()
            love.audio.play(level.music)
        end
    else
        love.audio.stop()
        level.music = love.audio.newSource("music/"..levelnum..".mp3")
        love.audio.play(level.music)
    end    
    W, H = level.image:getWidth(), level.image:getHeight()
    level:platforms()
    return true
end    

function level:draw()
    love.graphics.draw(level.image, level.x, level.y)
end    

function level:checklevel()
    if (player.x - (player.w / 2)) >= W then
        newlevel = levelnum + 1
        if maxlevel >= newlevel then
            levelnum = newlevel
            world = nil
            level:load()
            player:load(0, 800, player.hp)
            IA:unloadall()
            IA:load()
            camera:setPosition(0,0)
            player.x = 0
        end  
    elseif player.x < 0 then
        newlevel = levelnum - 1
        if newlevel > 0 then
            levelnum = newlevel
            world = nil
            levelimg = love.graphics.newImage("img/level/"..newlevel..".png")
            levelW = levelimg:getWidth()            
            level:load()
            IA:unloadall()
            IA:load()
            player:load(levelW - 100, 800, player.hp)
            camera:setPosition(levelW - winW)
        end   
    end
    return true
end   

function level:platforms() 
    platform = love.graphics.newImage("img/level/platforms/platform.png")
    if levelnum == 1 then
        level:addcollision(platform, "platform", 400, 800)   
        level:addcollision(platform, "platform", 800, 740)   
        level:addcollision(platform, "platform", 1200, 680)   
        level:addcollision(platform, "platform", 1400, 620)
    elseif levelnum == 2 then
        level:addcollision(platform, "platform_4", 500, 800)    
    end    
end     

function level:addcollision(img, name, x, y)
    local w, h = img:getDimensions()
    world:add({name = name}, x, y, w, h)
end    

function level:platformsdraw()
    if levelnum == 1 then
        love.graphics.draw(platform, 400, 800)
        love.graphics.draw(platform, 800, 740)
        love.graphics.draw(platform, 1200, 680)
        love.graphics.draw(platform, 1400, 620)
    elseif levelnum == 2 then
        love.graphics.draw(platform, 500, 800)
    end              
end    
