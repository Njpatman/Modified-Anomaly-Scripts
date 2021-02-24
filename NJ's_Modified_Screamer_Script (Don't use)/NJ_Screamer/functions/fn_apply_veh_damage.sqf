params ["_vehicle", "_z", "_damage"];
_vehicle setVelocity [1+random 3,1+random 3,1+random _z];
_vehicle setDammage ((getDammage _vehicle) + _damage);