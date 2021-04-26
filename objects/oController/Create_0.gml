/// @description Insert description here
global.difficulty = {
	maxDifficulty : 6,
	speedMultiplier : [1, 1.2, 1.3, 1.5, 1.8, 2, 2.5],
	spawnRate : [50, 50, 60, 70, 80, 90, 100],
	paybackTimerMultiplier : [1, 1.2, 1.3, 1.5, 1.8, 2, 2.5],
	sharkTimerMultiplier : [1, 1.2, 1.3, 1.5, 1.8, 2, 2.5],
	sharkPayment : [100, 100, 200, 200, 300, 400, 500],
	difficultyThreshold : room_speed * 60,
	difficultyCounter : 0
}

global.currentDifficulty = 0;
global.money = 3000;
global.debt = 5000;
global.totalDebt = global.debt;
global.investors = [];
global.paused = false;
global.strikes = 0;
global.blockadeArray = [];
global.activeBlockades = 0;
global.blockadeMax = 4;
global.gui = true;

sharkThreshold = room_speed * 30;
sharkTimer = sharkThreshold
sharkDifficultyBump = room_speed * 2;

arrayStartX = 496;
arrayStartY = 240;

moneySpeed = .1
moneyDisplay = 3000;
debtDisplay = 5000;

spawnThreshold = room_speed * .7;
spawnTimer = 0;
spawnerArray = [];

display_set_gui_size(544, 334);
gWidth = display_get_gui_width()
gHeight = display_get_gui_height();
sharkBarOffset = 4;
sharkBarWidth = 5;

global.music = audio_play_sound(sndTheme,100,true);

updateShark = function()
{
	if ClickedonMe()
	{
		if Pay(global.difficulty.sharkPayment[@ global.currentDifficulty])
		{
			var _soundarray = [sndBloodyTime, sndKeepComin, sndMuchAppreciated];
			audio_play_sound(_soundarray[irandom(2)], 80, false);
			
			sharkTimer = sharkThreshold;
			if global.currentDifficulty < global.difficulty.maxDifficulty
			{
				global.difficulty.difficultyCounter += sharkDifficultyBump;
			}
			SpawnMoney(x, y, true);
		}
	} else
	{
		sharkTimer -= 1 * global.difficulty.sharkTimerMultiplier[@ global.currentDifficulty];
		if sharkTimer < 0
		{
			GameOver();
		}
	}
}

updateDifficulty = function()
{
	if global.currentDifficulty < global.difficulty.maxDifficulty
	{
		global.difficulty.difficultyCounter += 1 * max(1, array_length(global.investors));
		if global.difficulty.difficultyCounter > global.difficulty.difficultyThreshold
		{
			global.currentDifficulty++
			global.difficulty.difficultyCounter = 0;
		}
	}
}

updateInvestors = function()
{
	for (var i =0; i < array_length(global.investors); i++)
	{
		var xColumn = i mod 5;
		var yRow = i div 5;
		if instance_exists(global.investors[i])
		{
			global.investors[i].goalX = arrayStartX + (16 * xColumn);
			global.investors[i].goalY = arrayStartY + (16 * yRow);
			global.investors[i].position = i;
		}
	}
}

updateMoney = function()
{
	var _debtIncrement = (1 / room_speed) * global.difficulty.sharkTimerMultiplier[@ global.currentDifficulty];
	global.debt += _debtIncrement;
	global.totalDebt += _debtIncrement;
	moneyDisplay = lerp(moneyDisplay, global.money, moneySpeed);
	debtDisplay = lerp(debtDisplay, global.debt, moneySpeed);
	if abs(moneyDisplay - global.money) < 2 moneyDisplay = global.money;
}

updateSpawns = function()
{
	spawnTimer++
	if spawnTimer >= spawnThreshold
	{
		spawnTimer = 0;
		if Chance(global.difficulty.spawnRate[@ global.currentDifficulty])
		{
			var _selection = irandom(array_length(spawnerArray) - 1)
			with spawnerArray[_selection]
			{
				spawnInvestor();
			}
		}
	}
}