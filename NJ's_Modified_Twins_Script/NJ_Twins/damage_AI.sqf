/*
	Author: Alias

	Description:
		finds and applies damage to AI units in the damage range specified by zeus
*/

//if (hasInterface) exitWith {};
if (!isServer) exitWith {};

params ["_electr_viz","_AI_dam_range"];
	
while {alive _electr_viz} do 
{
	_AI_units = [];
	_AI_units= (position _electr_viz) nearEntities ["Man", _AI_dam_range];	
	//hint str _AI_units;
	//_pos_run = [getPosATL _electr_viz,1000,random 360] call BIS_fnc_relPos;
	
	if (count _AI_units > 0) then 
	{
		{
		_x allowFleeing 1;
		_x setVelocity [1+random 6,1+random 6,1+random 6];
		_selection = selectRandom ["body","hand_r","hand_l","leg_r","leg_l"];
		[_x, 0.6, _selection, "stab"] call ace_medical_fnc_addDamageToUnit;
		uiSleep 6;
		} forEach _AI_units;
	};
	uiSleep 6;
};