/// @description Insert description here
if keyboard_check_pressed(vk_escape)
{
	global.paused = !global.paused;
}

if !global.paused
{
	updateShark();
	updateDifficulty();
	updateInvestors();
	updateMoney();
	updateSpawns();
}