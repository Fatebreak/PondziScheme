soundarray = [sndFishBetta,sndFishTonight,sndHookLine,sndTooDeep];

activate = function()
{
	audio_play_sound(soundarray[(irandom(3))], 100, false);
}