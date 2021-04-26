/// @description Insert description here
/// @description Insert description here
draw_set_font(PressStart);
draw_set_color(c_red);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var _verticaloffset = (gHeight / 2) - 64;

draw_text(gWidth / 2, _verticaloffset, "Remaining Debt: $" + string(ceil(global.debt)));
draw_text(gWidth / 2, _verticaloffset + 16, "Total Borrowed: $" + string(ceil(global.totalDebt)));