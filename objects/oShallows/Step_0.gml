/// @description Insert description here
if active
{
	if !instance_exists(blockadeid)
	{
		active = !active;
		return;
	}
	if ClickedonMe()
	{
		for (var i = 0; i < array_length(global.blockadeArray); i++;)
		{
			if global.blockadeArray[i] == blockadeid
			{
				array_delete(global.blockadeArray, i, 1);
				break;
			}
		}
		instance_destroy(blockadeid, true);
		global.activeBlockades--;
	}
}
else {
	if ClickedonMe()
	{
		audio_play_sound(sndDrip, 50, false);
		active = true;
		blockadeid = instance_create_layer(x, y, "Investors", oBlockade);
		array_push(global.blockadeArray, blockadeid);
		if global.activeBlockades == global.blockadeMax
		{
			instance_destroy(global.blockadeArray[0], true);
			array_delete(global.blockadeArray, 0, 1);
		} else global.activeBlockades++;
	}
}