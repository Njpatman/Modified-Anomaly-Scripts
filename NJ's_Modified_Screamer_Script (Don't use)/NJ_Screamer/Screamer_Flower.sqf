// Originally by ALIAS and hevily modified by Njpatman & Kaltag 
private ["_Screamer_entity","_Activation_Range","_ai_will_attack","_tgt_1","_tgt_2","_Health_Modifier","_Damage_allowed","_Lockon_Range"];

if (!isServer) exitWith {};

_Screamer_Position  = _this select 0;
_Activation_Range  	= _this select 1;
_AI_will_attack  	= _this select 2;
_Lockon_Range    	= _this select 3;

//creates _Screamer_entity
_entity_group = createGroup CIVILIAN;
_Screamer_entity= _entity_group createUnit ["C_Soldier_VR_F",_Screamer_Position, [], 0,"NONE"];

//removes all clothing from _Screamer_entity
RemoveAllItems _Screamer_entity;
removeUniform _Screamer_entity;
Removevest _Screamer_entity;
removeHeadgear _Screamer_entity;
removeAllWeapons _Screamer_entity;
_Screamer_entity unassignItem "NVGoggles";
_Screamer_entity removeItem "NVGoggles";

//sets _Screamer_entity setings
_Screamer_entity setSpeaker "NoVoice";
_Screamer_entity disableConversation true;
_Screamer_entity setcaptive true; 
_Screamer_entity addRating -10000;
_Screamer_entity setVariable ["lambs_danger_disableAI", true];
_Screamer_entity setUnitPos "UP";
_Screamer_entity allowDamage false;
_Screamer_entity setBehaviour "CARELESS";
_Screamer_entity enableFatigue false;
_Screamer_entity setSkill ["courage", 1];

//hides _Screamer_entity
_Screamer_entity hideObjectGlobal true;

//prevents _Screamer_entity from taking damage
_Screamer_entity addEventHandler ["HandleDamage", {0}];

//_Screamer_object appearence
_Screamer_object = createVehicle ["Land_AncientStatue_02_F", [0,0,0], [], 0, "CAN_COLLIDE"];
_Screamer_object attachTo [_Screamer_entity, [0, 0.5, 0.5],"spine3"];
_Screamer_object setVectorDirAndUp [[0,-1,0],[0,0,1]];
_Screamer_object setMass 1;

//creates, hides, then attatches the spheres that are used as ranges for the scream.
_Range_1_Object = createVehicle ["Sign_Sphere10cm_F", [0,0,0], [], 0, "CAN_COLLIDE"];
_Range_2_Object = createVehicle ["Sign_Sphere10cm_F", [0,0,0], [], 0, "CAN_COLLIDE"];
_Range_3_Object = createVehicle ["Sign_Sphere10cm_F", [0,0,0], [], 0, "CAN_COLLIDE"];

{_x hideObjectGlobal true;} forEach [_Range_1_Object,_Range_2_Object,_Range_3_Object];

_Range_1_Object attachTo [_Screamer_object, [0, -6, 0.5]];
_Range_2_Object attachTo [_Screamer_object, [0, -19, 0.5]];
_Range_3_Object attachTo [_Screamer_object, [0, -36, 0.5]];

//attatches invisable targets to Screamer if specified by zeus
if (_AI_will_attack) then {
	_tgt_1 = createVehicle  ["CBA_B_InvisibleTarget",[0,0,0], [], 0,"CAN_COLLIDE"];
	_tgt_2 = createVehicle  ["CBA_B_InvisibleTargetVehicle",[0,0,0], [], 0,"CAN_COLLIDE"];
	_tgt_1 attachTo [_Screamer_object,[0,-0.39,1.6]];
	_tgt_2 attachTo [_Screamer_object,[0,-0.4,1.6]];
	createVehicleCrew _tgt_1;
	createVehicleCrew _tgt_2;
	_tgt_1 setVariable ['ace_w_allow_dam',0];
	_tgt_1 allowDamage false;
	_tgt_2 setVariable ['ace_w_allow_dam',0];
	_tgt_2 allowDamage false;
	_tgt_1 addRating -10000;
	_tgt_2 addRating -10000;
};

uiSleep 3;

while {alive _Screamer_entity} do
{
	//checks if players are in range specified by zeus
	private ["_press_implicit_y","_press_implicit_x"];
	if ((_Screamer_entity nearEntities [["CAManBase","Tank","Car","Armored","Air"],_Activation_Range])<2) then {

	//checks if players are in lockon range specified by zeus then randomly picks a target to attack
	_Target = _Screamer_entity nearEntities [["CAManBase","Tank","Car","Armored","Air"],_Lockon_Range];
	_Move_position = getPos (selectRandom _Target);

	//Creates the object the anomaly will throw from it's mouth that effect_screamer tracks
	_wave_obj = createVehicle ["Land_Battery_F", [0,0,0], [], 0, "CAN_COLLIDE"];	
	_wave_obj setMass 10;
	_Screamer_entity doMove _Move_position;
	[_Screamer_object,["miscare_screamer",300]] remoteExec ["say3d",-2];
	uiSleep 5;
	
	_Screamer_entity lookAt _Move_position;
	dostop _Screamer_entity;

	uiSleep 1;
	_units_range_1= (position _Range_1_Object) nearEntities [["CAManBase"], 6];
	_units_range_2= (position _Range_2_Object) nearEntities [["CAManBase"], 10];
	_units_range_3= (position _Range_3_Object) nearEntities [["CAManBase"], 12];
	_veh_range_1= (position _Range_1_Object) nearEntities [["Tank","Car","Armored","Air"], 6];
	_veh_range_2= (position _Range_2_Object) nearEntities [["Tank","Car","Armored","Air"], 10];
	_veh_range_3= (position _Range_3_Object) nearEntities [["Tank","Car","Armored","Air"], 12];	
	uiSleep 1;

	_wave_obj attachTo [_Screamer_object, [0,-1,1.5]];
	detach _wave_obj;
		
	//effect
	if (alive _Screamer_entity) then {[[_wave_obj,_Screamer_object],"NJ_Screamer\effect_screamer.sqf"] remoteExec ["execvm"]};
		
	_dir_blast = getdir _Screamer_entity;

	_al_pressure = 90;

	if (_dir_blast<=90) then {
		_press_implicit_x = linearConversion [0, 90,_dir_blast, 0, 1, true];
		_press_implicit_y = 1-_press_implicit_x;
	};

	if ((_dir_blast>90)and(_dir_blast<180)) then {
		_dir_blast = _dir_blast-90;
		_press_implicit_x = linearConversion [0, 90,_dir_blast, 1, 0, true];
		_press_implicit_y = _press_implicit_x-1;
	};

	if ((_dir_blast>180)and(_dir_blast<270)) then {
		_dir_blast = _dir_blast-180;
		_press_implicit_x = linearConversion [0, 90,_dir_blast, 0, -1, true];
		_press_implicit_y = (-1*_press_implicit_x)-1;
	};

	if ((_dir_blast>270)and(_dir_blast<360)) then {
		_dir_blast = _dir_blast-270;
		_press_implicit_x = linearConversion [0, 90,_dir_blast, -1, 0, true];
		_press_implicit_y = 1+_press_implicit_x;
	};
		
	scream_on=true;

    _range_1_ids = _units_range_1 apply {[_x, owner _x]};
    _range_2_ids = _units_range_2 apply {[_x, owner _x]};
    _range_3_ids = _units_range_3 apply {[_x, owner _x]};
	_range_1_veh_ids = _veh_range_1 apply {[_x, owner _x]};
    _range_2_veh_ids = _veh_range_2 apply {[_x, owner _x]};
    _range_3_veh_ids = _veh_range_3 apply {[_x, owner _x]};
    //Infantry Damage
	{
        _x params ["_unit", "_owner"];
        [_unit, 10, 0.5] remoteExec ["njp_fnc_apply_damage", _owner];
    } foreach _range_1_ids;
        
    {
        _x params ["_unit", "_owner"];
        [_unit, 9, 0.4] remoteExec ["njp_fnc_apply_damage", _owner];
    } foreach _range_2_ids;
        
    {
        _x params ["_unit", "_owner"];
        [_unit, 8, 0.3] remoteExec ["njp_fnc_apply_damage", _owner];
    } foreach _range_3_ids;
	//Vehicle Damage
    {
        _x params ["_vehicle", "_owner"];
        [_vehicle, 12, 0.1] remoteExec ["njp_fnc_apply_veh_damage", _owner];
    } foreach _range_1_veh_ids;
        
    {
        _x params ["_vehicle", "_owner"];
        [_vehicle, 11, 0.05] remoteExec ["njp_fnc_apply_veh_damage", _owner];
    } foreach _range_2_veh_ids;
        
    {
        _x params ["_vehicle", "_owner"];
        [_vehicle, 10, 0.05] remoteExec ["njp_fnc_apply_veh_damage", _owner];
    } foreach _range_3_veh_ids;
        
	_wave_obj setVelocity [_press_implicit_x*_al_pressure,_press_implicit_y*_al_pressure,0];
	uiSleep 1;
	deleteVehicle _wave_obj;
	uiSleep 1;

	scream_on=false;
	_units_range = [];
};
uiSleep 8;
};
if (_AI_will_attack) then {
	{ _tgt_1 deleteVehicleCrew _x } forEach crew _tgt_1;
	deletevehicle _tgt_1;
	{ _tgt_2 deleteVehicleCrew _x } forEach crew _tgt_2;
	deletevehicle _tgt_2;
};
deleteVehicle _Screamer_entity;
[[_Screamer_object],"NJ_Screamer\teleport_screamer.sqf"] remoteExec ["execvm"];
uiSleep 4;
deleteVehicle _Screamer_object;
deleteVehicle _Range_1_Object;
deleteVehicle _Range_2_Object;
deleteVehicle _Range_3_Object;