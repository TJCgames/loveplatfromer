function touch2 (toucher, touchee)
	for t, v in ipairs(touchee) do
		if toucher.b:isTouching(v.b) then
			return true
	end end
	return false
end

function love.load()
	px = 100
	dpx = 0
	mdpx = 10
	ddpx = 1
	fdpx = 0.5
	py = 450
	dpy = 0
	g = 1
	tv = 20
	jmph = 10
	jmpc = 2

	world = love.physics.newWorld(0, 0, true)
	ball = {}
        ball.b = love.physics.newBody(world, px, py, "dynamic")
        ball.s = love.physics.newCircleShape(50)
        ball.f = love.physics.newFixture(ball.b, ball.s)
	statics = {{}}
        statics[1].b = love.physics.newBody(world, 0, 500, "static")
        statics[1].s = love.physics.newRectangleShape(800, 100)
        statics[1].f = love.physics.newFixture(statics[1].b, statics[1].s)
        statics[1].f:setUserData("Block")
end

function love.update(dt)
	cjmpc = 0
	if love.keyboard.isDown('d', 'right') and not love.keyboard.isDown('a', 'left') then
		if dpx < 0 then
			dpx = dpx + 2 * ddpx
		else
			dpx = dpx + ddpx
		end
	elseif love.keyboard.isDown('a', 'left') and not love.keyboard.isDown('d', 'right') then
		if dpx > 0 then
			dpx = dpx - 2 * ddpx
		else
			dpx = dpx - ddpx
		end
		if dpx < -mdpx then
			dpx = -mdpx
		end
	else
		if dpx > 0 then
			dpx = dpx - fdpx
		elseif dpx < 0 then
			dpx = dpx + fdpx
		end
	end
	if dpx > mdpx then
		dpx = mdpx
	elseif dpx < -mdpx then
		dpx = -mdpx
	end
	px = px + dpx * dt
	ball.b:setPosition(px, py)
	if touch2(ball, statics) then
		px = px - dpx * dt
		dpx = 0
	end
	if love.keyboard.isDown('w', 'up', 'space') and cjmpc ~= 0 then
		dpy = jmph
		cjmpc = cjmpc - 1
	else
		dpy = dpy - g
	end
	if dpy > tv then
		dpy = tv
	end
	py = py - dpy * dt
	ball.b:setPosition(px, py)
	if touch2(ball, statics) then
		py = py + dpy * dt
		dpy = 0
		cjmpc = jmpc
	end
end

function love.draw()
	love.graphics.clear(0, 0.625, 1)
    love.graphics.setColor(0, 0.5, 0)
    love.graphics.rectangle("fill", 0, 500, 800, 100)
	love.graphics.setColor(1, 0.25, 0.25)
	love.graphics.circle("fill", px, py, 50)
end