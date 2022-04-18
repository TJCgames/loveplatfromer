function touch2 (toucher, touchee)
	for t, v in ipairs(touchee) do
		if toucher.b:isTouching(v.b) then
			return true
	end end
	return false
end

function love.load()
	horizontal = {
		['player_start'] = 100,
		['speed'] = 0,
		['max_speed'] = 10,
		['acceleration'] = 1,
		['friction'] = 0.5
	}
	vertical = {
		['player_start'] = 450,
		['speed'] = 0,
		['max_speed'] = 20
		['acceleration'] = 1
	}
	jump = {
		['speed'] = 10,
		['max_jumps'] = 2,
		['current_jumps'] = 0,
		['coyote_time'] = 0.25,
		['current_coyote_time'] = 0
	}

	world = love.physics.newWorld(0, 0, true)
	ball = {}
    ball.b = love.physics.newBody(world, horizontal.player_start, vertical.player_start, "dynamic")
    ball.s = love.physics.newCircleShape(50)
    ball.f = love.physics.newFixture(ball.b, ball.s)
	statics = {{}}
    statics[1].b = love.physics.newBody(world, 0, 500, "static")
    statics[1].s = love.physics.newRectangleShape(800, 100)
    statics[1].f = love.physics.newFixture(statics[1].b, statics[1].s)
    statics[1].f:setUserData("Block")
end

function love.update(dt)
	jump.current_jumps = 0
	if love.keyboard.isDown('d', 'right') and not love.keyboard.isDown('a', 'left') then
		if horizontal.speed < 0 then
			horizontal.speed = horizontal.speed + 2 * horizontal.acceleration
		else
			horizontal.speed = horizontal.speed + horizontal.acceleration
		end
	elseif love.keyboard.isDown('a', 'left') and not love.keyboard.isDown('d', 'right') then
		if horizontal.speed > 0 then
			horizontal.speed = horizontal.speed - 2 * horizontal.acceleration
		else
			horizontal.speed = horizontal.speed - horizontal.acceleration
		end
	else
		if horizontal.speed > 0 then
			horizontal.speed = horizontal.speed - horizontal.friction
		elseif horizontal.speed < 0 then
			horizontal.speed = horizontal.speed + horizontal.friction
		end
	end
	if horizontal.speed > mhorizontal.speed then
		horizontal.speed = mhorizontal.speed
	elseif horizontal.speed < -mhorizontal.speed then
		horizontal.speed = -mhorizontal.speed
	end
	horizontal.player_start = horizontal.player_start + horizontal.speed * dt
	ball.b:setPosition(horizontal.player_start, vertical.player_start)
	world:update(dt)
	if touch2(ball, statics) then
		horizontal.player_start = horizontal.player_start - horizontal.speed * dt
		horizontal.speed = 0
	end
	if love.keyboard.isDown('w', 'up', 'space') and jump.current_jumps ~= 0 then
		vertical.speed = jump.speed
		jump.current_jumps = jump.current_jumps - 1
	else
		vertical.speed = vertical.speed - vertical.acceleration
	end
	if vertical.speed > vertical.max_speed then
		vertical.speed = vertical.max_speed
	end
	vertical.player_start = vertical.player_start - vertical.speed * dt
	ball.b:setPosition(horizontal.player_start, vertical.player_start)
	world:update(dt)
	if touch2(ball, statics) then
		vertical.player_start = vertical.player_start + vertical.speed * dt
		vertical.speed = 0
		jump.current_jumps = jump.max_jumps
	else
		if jump.current_coyote_time <= 0 then
			if jump.current_jumps == jump.max_jumps then
				jump.current_jumps = jump.max_jumps - 1
			end
		else
			jump.current_coyote_time = jump.current_coyote_time - dt
end end end

function love.draw()
	love.graphics.clear(0, 0.625, 1)
    love.graphics.setColor(0, 0.5, 0)
    love.graphics.rectangle("fill", 0, 500, 800, 100)
	love.graphics.setColor(1, 0.25, 0.25)
	love.graphics.circle("fill", horizontal.player_start, vertical.player_start, 50)
end
