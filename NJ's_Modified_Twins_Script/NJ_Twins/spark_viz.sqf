/*
	Author: Alias, modified by Njpatman

	Description:
		applies ace med damage to units, checks to see if players are looking at Twins, and if they looking, then to 
		stop Twins from teleporting (toggleable by zeus).
*/

if (!hasInterface) exitWith {};

private ["_sun_ini","_token","_obj_emit"];

waitUntil {time > 0};

params ["_obj_emit","_dist_damage","_Twins_stops"];

_sun_ini= "none";

_token = 13;

[_obj_emit,_dist_damage] spawn 
{
private ["_aberat","_dist_damage_w"];
_electromagnetic_anom 	= _this select 0;
_dist_damage_w			= _this select 1;

_play_sunet = true;

while {alive _electromagnetic_anom} do 
{
	waitUntil {player distance _electromagnetic_anom < _dist_damage_w};

	[_electromagnetic_anom,_dist_damage_w] spawn 
	{
		_electr_viz = _this select 0;
		_dist_dam_w	= _this select 1;
		
		_aberat = ppEffectCreate ["WetDistortion", 201];
		_aberat ppEffectEnable true;
		enableCamShake true;
		
		while {player distance _electr_viz < _dist_dam_w} do 
		{
			addCamShake [1,4,33];
			//_aberat ppEffectAdjust[1, 0.8, true];
			_aberat ppEffectCommit 3;
			uiSleep 3;
			addCamShake [4,4,33];
			//_aberat ppEffectAdjust[0, 0, true];
			_aberat ppEffectCommit 3;
			uiSleep 3;
		};
			//_aberat ppEffectEnable false;
			ppEffectDestroy _aberat;
			enableCamShake false;
	};
	
	if (_play_sunet) then 
	{
		_play_sunet = false;
		playsound "sound_twin";
		player setVelocity [1+random 6,1+random 6,1+random 6];
		_selection = selectRandom ["body","hand_r","hand_l","leg_r","leg_l"];
		[player, 0.4, _selection, "stab"] call ace_medical_fnc_addDamageToUnit;
		uiSleep 8;
		_play_sunet = true;
	};
};
};
_viz_fct=0;
while {alive _obj_emit} do 
{
	if (_Twins_stops) then {
	waitUntil {(player distance _obj_emit) < 1500};
	_dir_rel = [player, _obj_emit] call BIS_fnc_dirTo;
	_cam_dir = [0,0,0] getdir getCameraViewDirection player;
	
	if ((abs(_dir_rel - _cam_dir) <= 46) or (abs(_dir_rel - _cam_dir) >= 314)) then 
	{
		if (_viz_fct<1) then {_viz_fct = _viz_fct +1;_total_viz = _obj_emit getVariable "vizibil";_total_viz=_total_viz+1;_obj_emit setVariable ["vizibil", _total_viz, true];};
	};
    };
	//hint str looking_units; hint str (_obj_emit getVariable "vizibil");
	uiSleep 0.2;
};
while {alive _obj_emit} do
{
	_main_obj_sun = ["metalic4","metalic5"] call BIS_fnc_selectRandom;
	if ((_sun_ini!=_main_obj_sun) and (_token>12)) then {_obj_emit say3D [_main_obj_sun, 1500];_token=0};
	_token= _token+0.2;
	_sun_ini = _main_obj_sun;
	if (_viz_fct>0) then {_viz_fct = _viz_fct-1;_total_viz = _obj_emit getVariable "vizibil";_total_viz=_total_viz-1;_obj_emit setVariable ["vizibil", _total_viz, true];};
	};