//Initialize Variables
totalSpeed = (mSpeed * speedMultiplier) * global.difficulty.speedMultiplier[@ global.currentDifficulty];
firstDirection = 0;
walkDirection = 0;
goalX = room_width / 2;
goalY = room_height / 2;
goalXScale = 1;
goalYScale = 1;
curvePosition = 0;
curveSpeed = 0.05;
animCurve = animcurve_get_channel(SmoothLerp, 0);
timerThreshold = room_speed * timerSeconds;
paybackTimer = timerThreshold;
timerPercent = 100;
position = 0;
arrayMax = 40;

//States
wandering = function()
{
	//Check Collisions
	xSpeed = lengthdir_x(totalSpeed, walkDirection);
	ySpeed = lengthdir_y(totalSpeed, walkDirection);
	if place_meeting(x + xSpeed, y + ySpeed, parWall)
	{
		var collided = instance_place(x + xSpeed, y + ySpeed, parWall);
		if object_get_parent(collided.object_index) == parObstacle
		{
			while !place_meeting(x + sign(xSpeed), y + sign(ySpeed), parWall)
			{
				x += sign(xSpeed);
				y += sign(ySpeed);
			}
			//Get New Direction
			var directionModifier;
			xSpeed = lengthdir_x(totalSpeed, firstDirection);
			ySpeed = lengthdir_y(totalSpeed, firstDirection);
			if (!place_meeting(x + xSpeed, y + ySpeed, parObstacle)) && (firstDirection != Wrap(walkDirection + 180, 0, 359))
			{
				walkDirection = firstDirection;
			}
			else
			{
				if Chance(50) directionModifier = 1 else directionModifier = -1;
				var newDirection = Wrap(walkDirection + (90 * directionModifier), 0, 359);
				xSpeed = lengthdir_x(totalSpeed, newDirection);
				ySpeed = lengthdir_y(totalSpeed, newDirection);
				if place_meeting(x + xSpeed, y + ySpeed, parObstacle)
				{
					newDirection = Wrap(newDirection + 180, 0, 359)
					xSpeed = lengthdir_x(totalSpeed, newDirection);
					ySpeed = lengthdir_y(totalSpeed, newDirection);
					if place_meeting(x + xSpeed, y + ySpeed, parObstacle)
					{
						newDirection = Wrap(walkDirection + 180, 0, 359);
						xSpeed = lengthdir_x(totalSpeed, newDirection);
						ySpeed = lengthdir_y(totalSpeed, newDirection);
						if place_meeting(x + xSpeed, y + ySpeed, parObstacle)
						{
							xSpeed = lengthdir_x(totalSpeed, walkDirection);
							ySpeed = lengthdir_y(totalSpeed, walkDirection);
							x += xSpeed;
							y += ySpeed;
						}
						else walkDirection = newDirection;
					}
					else walkDirection = newDirection;
				}
				else walkDirection = newDirection;
			}
		}
		else if collided.object_index == oBase
		{	
			if array_length(global.investors) < arrayMax
			{
				Invest(value, payback);
				array_push(global.investors,id)
				position = array_length(global.investors)
				state = waiting;
				SpawnMoney(x, y, false);
			}
			else
			{
				walkDirection = random_range(0, 359)
				goalXScale = 1;
				goalYScale = 1;
				curvePosition = 0;
				state = paid;
			}
		}
		else if collided.object_index == oExit
		{
			instance_destroy();
		}
	}
	else
	{
		x += xSpeed;
		y += ySpeed;
	}
}

waiting = function()
{
	//Update Position
	goalYScale = 0.5;
	goalXScale = 0.5;
	if x != goalX || y != goalY || image_yscale != goalY || image_xscale != goalYScale
	{
		curvePosition = min(1, curvePosition + curveSpeed)
		var curveValue = animcurve_channel_evaluate(animCurve, curvePosition);
		x = lerp(x, goalX, curveValue);
		y = lerp(y, goalY, curveValue);
		image_xscale = lerp(image_xscale, goalXScale, curveValue);
		image_yscale = lerp(image_yscale, goalYScale, curveValue);
	}
	else curvePosition = 0;
	//Click to Pay
	if ClickedonMe(true)
	{
		if Pay(payback)
		{
			walkDirection = random_range(0, 359)
			goalXScale = 1;
			goalYScale = 1;
			curvePosition = 0;
			array_delete(global.investors, position, 1);
			state = paid;
			SpawnMoney(x, y, true);
		}
	}
	//Update Timer
	else
	{
		paybackTimer -= 1 * global.difficulty.paybackTimerMultiplier[@ global.currentDifficulty];
		timerPercent = (paybackTimer / timerThreshold) * 100;
		if paybackTimer < 0
		{
			walkDirection = random_range(0, 359)
			goalXScale = 1;
			goalYScale = 1;
			curvePosition = 0;
			array_delete(global.investors, position, 1);
			state = paid;
			global.strikes++;
			if global.strikes == 3
			{
				GameOver();
			}
		}
	}
}

paid = function(){
	if x != goalX || y != goalY || image_yscale != goalY || image_xscale != goalYScale
	{
		curvePosition = min(1, curvePosition + curveSpeed)
		var curveValue = animcurve_channel_evaluate(animCurve, curvePosition);
		x += lengthdir_x(curveValue * 7, walkDirection);
		y += lengthdir_y(curveValue * 7, walkDirection);
		image_xscale = lerp(image_xscale, goalXScale, curveValue);
		image_yscale = lerp(image_yscale, goalYScale, curveValue);
	}
	if (x < -32) || (y < -32) || (x > room_width + 32) || (y > room_width + 32)
	{
		instance_destroy();
	}
}


state = wandering;
resumeState = wandering;