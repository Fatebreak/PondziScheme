// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Wave(from, to, duration, offset){
	var a4 = (to - from) * 0.5;
	return from + a4 + sin((((current_time * 0.001) + duration * offset) / duration) * (pi*2)) * a4;
}

function Wrap(_value, _min, _max){
	if(_value mod 1 == 0)
	{
		while(_value > _max || _value < _min)
		{
			if(_value > _max)
			{
				_value = _min + _value - _max - 1
			}
			else if (_value < _min)
			{
				_value = _max + _value - _min + 1
			}
			else
			_value = _value
		}
		return _value;
	}
	else
	{
		var _old = _value + 1
		while(_value != _old)
		{
			_old = _value;
			if(_value < _min)
			{
				_value = _max - (_min - _value);
			}
			else if(_value > _max)
			{
				_value = _min + (_value - _max);
			}
			else
			{
				_value = _value;
			}
		}
		return _value;
	}
}
	
function MoveInDirection(length, _direction)
{
	x += lengthdir_x(length, _direction);
	y += lengthdir_y(length, _direction);
}

function Chance(percent)
{
	percent = percent / 100;
	return (percent > random(1));
}