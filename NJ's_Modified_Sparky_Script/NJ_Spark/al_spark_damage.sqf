//by ALIAS

if (!isServer) exitWith {};

_selection = selectRandom ["body","hand_r","hand_l","leg_r","leg_l"];

_unit_dam_spark = _this select 0;

if (isNil (_unit_dam_spark getVariable "stare")) then {_unit_dam_spark setVariable ["stare", "liber"];};

if ((_unit_dam_spark getVariable "stare")=="ocupat") exitWith {};

[_unit_dam_spark, 0.2, _selection, "stab"] call ace_medical_fnc_addDamageToUnit;
sleep 4;

