/*
	Author: Alias

	Description:
		Rotates the _Twins_Heart
*/

if (!hasInterface) exitWith {};

params ["_Heart_Twins"];

_dir = 0;
while {alive _Heart_Twins} do
{
	if (_dir isEqualTo 360) then {_dir=0};
	_Heart_Twins setdir _dir;
	_dir = _dir + 5;
	uiSleep 0.5;
};