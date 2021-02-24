//Screamer Jaw
[
	"NJ's Anomalies",

	"Spawn Screamer Jaw",
	{	
		private ["_pos"];
		_pos = (ASLToAGL (_this select 0));
		//Dialouge box for custom hunt/damage radius and setting if AI will attack twins
        ["Screamer Options", 
	  	  [
                ["SLIDER",["Activation Range","Range at which Screamer will become active"], [1, 1000, 150, 0]],
				["SLIDER",["Lockon Range","Range at which Screamer will lock onto a Player/AI"], [1, 500, 65, 0]],
				["CHECKBOX",["AI will attack","All AI will try and engage Screamer"], [true]]
          ],
          {
				params ["_dialog", "_args"];
                _dialog params ["_Damage_Range","_Lockon_Range","_ai_will_attack"];
                _args params ["_pos"];
				[_pos, _Damage_Range, _ai_will_attack,_Lockon_Range] execvm "NJ_Screamer\Screamer_Jaw.sqf";
          }, 
		  {}, [_pos]
        ] call zen_dialog_fnc_create;
	}
] call zen_custom_modules_fnc_register;

//Screamer Flower
[
	"NJ's Anomalies",

	"Spawn Screamer Flower",
	{	
		private ["_pos"];
		_pos = (ASLToAGL (_this select 0));
		//Dialouge box for custom hunt/damage radius and setting if AI will attack twins
        ["Screamer Options", 
	  	  [
                ["SLIDER",["Activation Range","Range at which Screamer will become active"], [1, 1000, 150, 0]],
				["SLIDER",["Lockon Range","Range at which Screamer will lock onto a Player/AI "], [1, 500, 65, 0]],
				["CHECKBOX",["AI will attack","All AI will try and engage Screamer"], [true]]
          ],
          {
				params ["_dialog", "_args"];
                _dialog params ["_Damage_Range","_Lockon_Range","_ai_will_attack"];
                _args params ["_pos"];
				[_pos, _Damage_Range, _ai_will_attack,_Lockon_Range] execvm "NJ_Screamer\Screamer_Flower.sqf";
          }, 
		  {}, [_pos]
        ] call zen_dialog_fnc_create;
	}
] call zen_custom_modules_fnc_register;