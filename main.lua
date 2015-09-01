require("player")
require("level")
require("background")
require("camera")
require("particle")
require("lib.class.full")
require("IA")
bumb = require("lib.bump.bump")
levelnum = 1
maxlevel = 2
time = 0
ticks = 1
tick = 0
text = "No hay nadie"
limit = 0
winW = 0
winH = 0

function love.load()
	love.window.setMode(1920, 1080, {fullscreen=true, resizable=true, vsync=true, minwidth=400, minheight=300})
	winW, winH = love.graphics.getWidth(), love.graphics.getHeight()
	background:load()
    level:load()
    IA:load()
    player:load(0, 750, 6)
    particles:load()
    setresolution()
    camera.layers = {} 
   
    camera:newLayer(0.08, function()
        background:draw()
    end)  
   
    camera:newLayer(1, function()
        level:draw()
        level:platformsdraw()
        player:draw()
        IA:draw()
    end)     
end

function love.update(dt)
    particle:update(dt)
    ticks = ticks + 1
    time = dt
end

function love.draw()
    camera:draw()
    love.graphics.draw(player.hpbar, 2, 2)
    if level == 1 and ticks < 30 then
        love.graphics.print(text, winW / 2, winH * 0.86)
    end    
end

function love.keypressed(key)
    if key == " " then
        player:jump()
    end
    if key == "a" then
        a_down = true
    elseif key == "d" then
        d_down = true
    end    
end    

function love.keyreleased(key)
    if key == "a" then
        a_down = false
    elseif key == "d" then
        d_down = false
    end    
end    

function setresolution()
    local desktopw, desktoph = love.window.getDesktopDimensions()
    camera.scaleY = level.image:getWidth() / winH / 3.5
    camera.scaleX = camera.scaleY
end    
    