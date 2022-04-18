function love.load()
	
	world = love.physics.newWorld(0, 200, true)
	
	ball = {}
        ball.b = love.physics.newBody(world, 400,200, "dynamic")
        ball.b:setMass(10)
        ball.s = love.physics.newCircleShape(50)
        ball.f = love.physics.newFixture(ball.b, ball.s)
        ball.f:setRestitution(0.5)
        ball.f:setUserData("Ball")
    static = {}
        static.b = love.physics.newBody(world, 400,400, "static")
        static.s = love.physics.newRectangleShape(200,50)
        static.f = love.physics.newFixture(static.b, static.s)
        static.f:setUserData("Block")
end

function love.update(dt)
	world:update(dt)
end

function love.draw()
	love.graphics.circle("line", ball.b:getX(),ball.b:getY(), ball.s:getRadius())
    love.graphics.polygon("line", static.b:getWorldPoints(static.s:getPoints()))
end