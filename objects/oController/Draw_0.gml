/// @description Insert description here
draw_self();
for (var i = 0; i < global.strikes; i++)
{
	draw_sprite(sStrike, 0, x - 18 - ( 16 * i), y);
}