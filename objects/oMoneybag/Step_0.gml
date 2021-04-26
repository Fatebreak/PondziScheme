/// @description Insert description here
if x != goalX || y != goalY
	{
		curvePosition = min(1, curvePosition + curveSpeed)
		var curveValue = animcurve_channel_evaluate(animCurve, curvePosition);
		x = lerp(x, goalX, curveValue);
		y = lerp(y, goalY, curveValue);
	}

if (abs(goalX - x) < 1) && (abs(goalY - y) < 1)
{
	instance_destroy();
}