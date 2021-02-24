// Originally by ALIAS and modified by Njpatman
private ["_track_dist","_poz_spark","_bob","_tgt_1","_tgt_2"];

if (!isServer) exitWith {};

params ["_spark_pos","_track_dist","_spark_effect","_damage_range","_effect_on_AI","_EMP_enabled","_Ai_attack","_Twins_will_stop","_Twins_invincible","_Give_Light"];

//Creates Twins (A)
_spark_obj = createVehicle ["Land_HighVoltageTower_large_F", _spark_pos, [], 0, "CAN_COLLIDE"];

//Creates twins heart
_heart_twin = "Land_PowerGenerator_F" createVehicle [0,0,0];
_heart_twin attachTo [_spark_obj,[-0.5,0,1.5]];

//Rotates twins heart
[[_heart_twin],"NJ_Twins\Heart_rotate.sqf"] remoteExec ["execvm",0];

//Creates invisible Sphere so death animation doesn't start halfway up the tower
_bob = createVehicle ["Sign_Sphere10cm_F", [0,0,0], [], 0, "CAN_COLLIDE"];
[_bob, true] remoteExec ["hideObjectGlobal",0,true];
_bob attachTo [_spark_obj, [0, 0, -20]];

//Sets object for sparks on the tower
if (_spark_effect) then {
	_poz_spark = createVehicle ["Sign_Sphere10cm_F", [0,0,0], [], 0, "CAN_COLLIDE"];
	[_poz_spark, true] remoteExec ["hideObjectGlobal",0,true]
};

//Allows Twins to damage AI
if (_effect_on_AI) then {
	[[_spark_obj,_damage_range],"NJ_Twins\damage_AI.sqf"] remoteExec ["execvm",0];
};

//Makes _heart_twins invincible if specified by zeus
if (_Twins_invincible)  then{
_heart_twin allowDamage false;
};

_pauza = 5;
[[_spark_obj,_damage_range,_Twins_will_stop],"NJ_Twins\spark_viz.sqf"] remoteExec ["execvm",0,true];

_spark_obj setVariable ["vizibil", 0, true];

[_spark_obj,_track_dist,_damage_range,_heart_twin,_EMP_enabled,_bob,_Ai_attack,_Give_Light,_Twins_invincible] spawn {
private ["_twinslight","_twinslight_alt","_tgt_1","_tgt_2"];
//waitUntil{!isNil "vizibil"};

params ["_spark_move","_track_dist","_dam_range","_heart_twin","_EMP_enabled","_bob","_Ai_attack","_Give_Light","_Twins_invincible"];

//attatches red light to _heart_twin if specified by zeus
if (_Give_Light) then {

	//attatches blue light to _heart_twin if invincibility is specified by zeus
	if (_Twins_invincible)  then{
	_twinslight_alt = createVehicle ["Reflector_Cone_01_narrow_blue_F", [0,0,0], [], 0, "NONE"];
	_twinslight_alt attachTo [_heart_twin,[0,0,0]];
	_twinslight_alt setVectorDirAndUp [[0,0,1],[1,0,0]];

} else {
_twinslight = createVehicle ["Reflector_Cone_01_narrow_red_F", [0,0,0], [], 0, "NONE"];
_twinslight attachTo [_heart_twin,[0,0,0]];
_twinslight setVectorDirAndUp [[0,0,1],[1,0,0]];

};
};

//Attatches invisible targets to _heart_twin if specified by zeus
if (_Ai_attack) then {
	_tgt_1 = createVehicle  ["CBA_B_InvisibleTarget",[0,0,0], [], 0,"CAN_COLLIDE"];
	_tgt_2 = createVehicle  ["CBA_B_InvisibleTargetVehicle",[0,0,0], [], 0,"CAN_COLLIDE"];
	_tgt_1 attachTo [_heart_twin,[0,1.2,0]];
	_tgt_2 attachTo [_heart_twin,[0,-1.2,0]];
	createVehicleCrew _tgt_1;
	createVehicleCrew _tgt_2;
	_tgt_1 addRating -10000;
	_tgt_2 addRating -10000;
};

_allow_move = 15;
_closest_units = [];
_incr = 0;

_vizibil=true;

while {alive _heart_twin} do
{
	_closest_units = (position _spark_move) nearEntities [["CAManBase"], _track_dist];
	
	if (_spark_move getVariable "vizibil"<1) then 
	{
		if ((count _closest_units >0)and(_allow_move>10)) then 
		{
			_closer_un = _closest_units select 0;
			if ((_closer_un distance _spark_move) > _dam_range) then 
			{
			_dir_depl = [_closer_un, _spark_move] call BIS_fnc_dirTo;
			_pos_umbla = [getPosATL _spark_move,_incr,_dir_depl] call BIS_fnc_relPos;
			//hint str _dir_depl;
			_spark_move setPosATL _pos_umbla;
			_spark_move setDir _dir_depl;
			_incr=_incr-(15 + floor(random 11));
			_allow_move = 0;
			};
		};
		_allow_move = _allow_move+3;
		//hint str _allow_move;
	} else {_allow_move =0};
//hint str (_spark_move getVariable "vizibil");
uiSleep 2;
};

// EMP effect
if (_EMP_enabled) then {
	[_spark_move,300] execvm "AL_emp\config_obj.sqf";
	emp_dam =0.1; publicVariable "emp_dam";
	[[_spark_move,true,true],"AL_emp\viz_eff_emp.sqf"] remoteExec ["execVM"];
	waitUntil {!isNil "special_launchers_emp"};
	waitUntil {!isNil "emp_dam"};
	[] execvm "AL_emp\emp_effect.sqf";
	uiSleep 2;
};

if (_Ai_attack) then {
	{ _tgt_1 deleteVehicleCrew _x } forEach crew _tgt_1;
	deletevehicle _tgt_1;
	{ _tgt_2 deleteVehicleCrew _x } forEach crew _tgt_2;
	deletevehicle _tgt_2;
};

[[_bob],"NJ_Twins\teleport_twins.sqf"] remoteExec ["execVM"];
uiSleep 8;

if (_Give_Light) then {

	if (_Twins_invincible)  then{
	deleteVehicle _twinslight_alt

} else {
deleteVehicle _twinslight;

};
};

deleteVehicle _spark_move;
deleteVehicle _heart_twin;
deleteVehicle _bob;;

};

//Sets positions for sparks
if (_spark_effect) then 
{
	while {alive _spark_obj} do 
	{
		_spark_poz_rel =["st","dr","ct"] call BIS_fnc_selectRandom;
		if (_spark_poz_rel isEqualTo "st") then {_poz_spark attachTo [_spark_obj,[-12,0,12.35]]};
		if (_spark_poz_rel isEqualTo "dr") then {_poz_spark attachTo [_spark_obj,[11.5,0,12.35]]};
		if (_spark_poz_rel isEqualTo "ct") then {_poz_spark attachTo [_spark_obj,[-0.3,0,12.2]]};
			
		_spark_obj setDamage 0;
		_sclipiri = 1+ floor (random 5);
		//hint str _sclipiri;
		uiSleep _pauza;
		_nr = 0;
		while {_nr<_sclipiri} do 
		{
			//_spark_obj setDamage 0.9;		uiSleep 0.1;		_spark_obj setDamage 0;
			_pauza_intre_sclipiri = 0.1+ (random 2);
			[[_poz_spark,_pauza_intre_sclipiri],"NJ_Twins\spark_effect.sqf"] remoteExec ["execvm"];
			uiSleep _pauza_intre_sclipiri;
			//_spark_obj setDamage 0.9;
			_nr=_nr+1;
		};
	};
deleteVehicle _poz_spark;
};