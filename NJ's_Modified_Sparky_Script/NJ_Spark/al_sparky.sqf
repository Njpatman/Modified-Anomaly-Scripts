// Originally by ALIAS and modified by Njpatman

private ["_mark_orig"];

if (!isServer) exitWith {};

_mark_orig = _this select 0;
_protection_gear_spark = _this select 1;
_AI_see_spark= _this select 2;

if (isNil "_protection_gear_spark") exitWith {hint "You haven't defined a protective device!!!"};
obj_prot_sparky = _protection_gear_spark;
publicVariable "obj_prot_sparky";

//poz_curr=[0,0,0];
spark_fired = false;
publicVariable "spark_fired";

[[_mark_orig],"NJ_Spark\al_orb_move.sqf"] remoteExec ["execVM",0,true];
if (_AI_see_spark) then {null= [_mark_orig] execvm "NJ_Spark\ai_avoid_spark.sqf";};