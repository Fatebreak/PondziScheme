// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function ClickedonMe(_short){
	var offset;
	if argument_count > 0 offset = 8 else offset = 0;
	if (mouse_x > bbox_left && mouse_x < bbox_right) && (mouse_y > bbox_top && mouse_y < bbox_bottom + offset) && mouse_check_button_pressed(mb_left)
	{
		return true;
	}
}

function Pay(_value){
	if global.money >= _value
	{
		global.money -= _value;
		global.debt -= _value;
		return true;
	} else return false;
}

function GameOver(){
	if global.gui
	{
		layer_sequence_create("GameOver",(room_width / 2), (room_height / 2) - 32, sqGameOver);
		global.gui = false;
	}
}

function Invest(_value,_payback){
	global.money += _value;
	global.debt += _payback;
	global.totalDebt += _payback;
}

function Paused(){
	if state != Paused
	{
		resumeState = state;
		state = Paused;
	}
}
	
function SpawnMoney(_x, _y, _destination)
{
	var _soundarray = [sndJingle1,sndJingle2];
	audio_play_sound(_soundarray[irandom(1)], 50, false);
	
	if _destination
	{
		var _money = instance_create_layer(0, 0, "Investors", oMoneybag);
		_money.x = _money.xMoney;
		_money.y = _money.yMoney;
		_money.goalX = _x;
		_money.goalY = _y;
	}
	else {
		var _money = instance_create_layer(_x, _y, "Investors", oMoneybag);
		_money.goalX = _money.xMoney;
		_money.goalY = _money.yMoney;
	}
}

function GoToEnd()
{
	room_goto(rmGameOver)
}