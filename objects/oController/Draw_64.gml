/// @description Insert description here
if !global.gui return;

sharkPercent = (sharkTimer / sharkThreshold) * 100;

draw_healthbar(gWidth - (sharkBarOffset + sharkBarWidth), sharkBarOffset, gWidth - sharkBarOffset, gHeight - sharkBarOffset, sharkPercent,c_black, c_red, c_lime, 3, true, false)

draw_set_font(PressStart);
draw_set_color(c_lime);
draw_set_halign(fa_right);
draw_text(gWidth - ((sharkBarOffset * 2) + sharkBarWidth), sharkBarOffset, "Cash $" + string(ceil(moneyDisplay)));
draw_set_color(c_red);
draw_text(gWidth - ((sharkBarOffset * 2) + sharkBarWidth), (sharkBarOffset * 2) + 15, "Debt $" + string(ceil(debtDisplay)));
