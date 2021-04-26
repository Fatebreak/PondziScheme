/// @description Insert description here
alarm[0] = 1;
investorList = [oCrawdad, oClownfish, oJellyfish];




spawnInvestor = function()
{
	var _investor = instance_create_layer(x, y, "Investors", investorList[irandom(array_length(investorList) -1)]);
	if Chance(75)
	{
		_investor.firstDirection = 0;
	}
	else _investor.firstDirection = firstDirection;
	_investor.walkDirection = walkDirection;
}