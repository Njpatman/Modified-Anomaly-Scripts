// Originally by ALIAS and modified by Njpatman

if (!hasInterface) exitWith {};

params ["_obj_eff"];

_obj_eff say3D ["teleport_twins", 500];

enableCamShake true;
addCamShake [2, 12, 25];

_blur_sonic = "#particlesource" createVehicle (getPosATL _obj_eff);
_blur_sonic setParticleCircle [13, [0, 0, 35]];
_blur_sonic setParticleRandom [0, [0.25, 0.25, 0], [0.175, 0.175, 0], 0, 0.25, [0, 0, 0, 0.1], 0, 0];
_blur_sonic setParticleParams [["\A3\data_f\ParticleEffects\Universal\Refract.p3d", 1, 0, 1], "", "Billboard", 1, 2, [0, 0, 0], [0, 0, 0], 12, 12, 6, 0.002, [7, 5, 1], [[1, 1, 1, 0.5], [1, 1, 1, 1], [1, 1, 1, 1]], [0.08], 1, 0, "", "", _obj_eff];
_blur_sonic setDropInterval 0.01;

uiSleep 8;

[_obj_eff, nil, true] call BIS_fnc_moduleLightning;
deleteVehicle _obj_eff;
deleteVehicle _blur_sonic;
enableCamShake false;