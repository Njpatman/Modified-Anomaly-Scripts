params ["_unit", "_z", "_damage"];
_selection = selectRandom ["body","hand_r","hand_l","leg_r","leg_l"];
_unit setVelocity [1+random 3,1+random 3,1+random _z];
[_unit, _damage, _selection, "falling"] call ace_medical_fnc_addDamageToUnit;