/// @description Insert description here
sequence = layer_sequence_create("Jaws",(room_width / 2), (room_height / 2) - 32, sqGameOver);
layer_sequence_headpos(sequence, 270);
layer_sequence_pause(sequence);
display_set_gui_size(544, 334);
gWidth = display_get_gui_width()
gHeight = display_get_gui_height();

audio_stop_sound(global.music);

var _soundarray = [sndFishBetta,sndFishTonight,sndHookLine,sndTooDeep];
audio_play_sound(_soundarray[(irandom(3))], 100, false);