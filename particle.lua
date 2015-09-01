particles = {}

function particles:load()
    particleimage = love.graphics.newImage("img/entities/particles/particlefall.png")
    particle = love.graphics.newParticleSystem(particleimage, 100)
    particle:setParticleLifetime(2, 5)
	particle:setEmissionRate(1341)
	particle:setSizeVariation(1)
	particle:setLinearAcceleration(-20, -20, 20, 20)
end

function particles:draw(particle, x, y)    
    love.graphics.draw(particle, x, y)
end    
    