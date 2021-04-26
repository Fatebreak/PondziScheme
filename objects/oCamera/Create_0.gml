/// @description Insert description here
#macro view view_camera[0]

viewHeight = 334;
viewWidth = 544;

windowScale = 2.5;

window_set_size(viewWidth * windowScale, viewHeight * windowScale);
alarm[0] = 1;

surface_resize(application_surface, viewWidth*windowScale, viewHeight * windowScale);