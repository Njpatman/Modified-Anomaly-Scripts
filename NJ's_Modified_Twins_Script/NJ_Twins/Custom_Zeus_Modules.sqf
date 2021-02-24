/*
	Author: Njpatman

	Description:
		Initialises custom modules for the Zeus Interface
*/

//Twins
[
	"NJ's Modified Anomalies",

	"Spawn Twins",
	{	
		private ["_pos","_Twins_Variants"];
		_pos = (ASLToAGL (_this select 0));
		_Twins_Variants = ["Twins A","Twins B"];
		//Dialouge box for custom hunt/damage radius and setting if AI will attack twins.
        ["Twins Options", 
	  	  [
				["COMBO",["Twins Variant", "Variant of Twins that is spawned"], [_Twins_Variants, _Twins_Variants, 0]],
                ["SLIDER",["Hunting Range","Range at which Twins will hunt down AI/Players"], [1, 10000, 1500, 0]],
				["SLIDER",["Damage Range","Range at which Twins will hurt AI/Players"], [1, 150, 65, 0]],
				["CHECKBOX",["Make Twins invincible","Makes Twins invincible and will change Twins light to blue if 'Give Twins a light' is checked"], [false]],
				["CHECKBOX",["AI will attack","All AI will try and engage Twins"], [true]],
				["CHECKBOX",["Twins will stop","if not checked, Twins will not give a shit if a player is looking at it, it will keep on charging"], [true]],
				["CHECKBOX",["Give Twins a light","A red light will be attatched to Twins to make targeting easier in the night time"], [false]]
          ],
          {
			    //Takes all the information from above and turns it into variables, then stuffs those variables into  an array.
				params ["_dialog", "_args"];
                _dialog params ["_Twins_type","_Hunting_Range","_Damage_Range", "_Twins_invincible", "_ai_will_attack_Twins","_Twins_will_stop","_Give_Twins_Light"];
                _args params ["_pos","_Twins_Variants","_Twins_Bool"];
				switch (_Twins_Variants findIf {_x isEqualTo _Twins_type}) do {
                    case 0: {_Twins_Bool = true};
                    case 1: {_Twins_Bool = false};
				};
				[_pos, _Hunting_Range, _Damage_Range, false, _ai_will_attack_Twins, _Twins_will_stop, _Twins_invincible, _Give_Twins_Light,_Twins_Bool] execvm "NJ_Twins\Twins.sqf"
          }, 
		  {}, [_pos, _Twins_Variants]
        ] call zen_dialog_fnc_create;
	}
] call zen_custom_modules_fnc_register;

//Twins Lightning
[
	"NJ's Modified Anomalies",

	"Spawn Twins Lightning",
	{	
		private ["_Lightning_pos","_Lightning_Twins_Variants"];
		_Lightning_pos = (ASLToAGL (_this select 0));
		_Lightning_Twins_Variants = ["Lightning Twins A","Lightning Twins B"];
		//Dialouge box for custom hunt/damage radius and setting if AI will attack Lightning Twins.
        ["Lightning Twins Options", 
	  	  [
				["COMBO",["Lightning Twins Variant", "Variant of Lightning Twins that is spawned"], [_Lightning_Twins_Variants, _Lightning_Twins_Variants, 0]],
                ["SLIDER",["Hunting Range","Range at which Lightning Twins will hunt down AI/Players"], [1, 10000, 1500, 0]],
				["SLIDER",["Damage Range","Range at which Lightning Twins will hurt AI/Players"], [1, 150, 65, 0]],
				["CHECKBOX",["Make Lightning Twins invincible","Makes Lightning Twins invincible and will change Lightning Twins light to blue if 'Give Lightning Twins a light' is checked"], [false]],
				["CHECKBOX",["AI will attack","All AI will try and engage Lightning Twins"], [true]],
				["CHECKBOX",["Lightning Twins will stop","if not checked, Lightning Twins will not give a shit if a player is looking at it, it will keep on charging"], [true]],
				["CHECKBOX",["Give Lightning Twins a light","A red light will be attatched to Lightning Twins to make targeting easier in the night time"], [false]]
          ],
          {
			    //Takes all the information from above and turns it into variables, then stuffs those variables into  an array.
				params ["_dialog", "_args"];
                _dialog params ["_Twins_type","_Hunting_Range","_Damage_Range", "_Twins_invincible", "_ai_will_attack_Twins","_Twins_will_stop","_Give_Twins_Light"];
                _args params ["_Lightning_pos","_Lightning_Twins_Variants","_Twins_Bool"];
				switch (_Lightning_Twins_Variants findIf {_x isEqualTo _Twins_type}) do {
                    case 0: {_Twins_Bool = true};
                    case 1: {_Twins_Bool = false};
				};
				[_Lightning_pos, _Hunting_Range, _Damage_Range, false, _ai_will_attack_Twins, _Twins_will_stop, _Twins_invincible, _Give_Twins_Light,_Twins_Bool] execvm "NJ_Twins\Twins_Lightning.sqf"
          }, 
		  {}, [_Lightning_pos, _Lightning_Twins_Variants]
        ] call zen_dialog_fnc_create;
	}
] call zen_custom_modules_fnc_register;

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Enables EMP effects (untested), only use if you have the script loaded.
// EMP script, you'll have to customize it for the gear in your mission: "https://steamcommunity.com/sharedfiles/filedetails/?id=1462497370"

/*
//Twins A
[
	"NJ's Anomalies",

	"Spawn Twins A (EMP)",
	{	
		private ["_pos"];
		_pos = (ASLToAGL (_this select 0));
		//Dialouge box for custom hunt/damage radius and setting if AI will attack twins
        ["Twins Options", 
	  	  [
                ["SLIDER",["Hunting Range","Range at which Twins will hunt down AI/Players"], [1, 10000, 1500, 0]],
				["SLIDER",["Damage Range","Range at which Twins will hurt AI/Players"], [1, 150, 65, 0]],
				["CHECKBOX",["Make Twins invincible","Makes Twins invincible and will change Twins light to blue if 'Give Twins a light' is checked"], [false]],
				["CHECKBOX",["AI will attack","All AI will try and engage Twins"], [true]],
				["CHECKBOX",["Twins will stop","if not checked, Twins will not give a shit if a player is looking at it, it will keep on charging"], [true]],
				["CHECKBOX",["Give Twins a light","A red light will be attatched to Twins to make targeting easier in the night time"], [false]]
          ],
          {
				params ["_dialog", "_args"];
                _dialog params ["_Hunting_Range","_Damage_Range", "_Twins_invincible", "_ai_will_attack_Twins","_Twins_will_stop","_Give_Twins_Light"];
                _args params ["_pos"];
				[_pos, _Hunting_Range, true, _Damage_Range, true, true, _ai_will_attack_Twins, _Twins_will_stop, _Twins_invincible, _Give_Twins_Light] execvm "NJ_Twins\Twins_A.sqf";
          }, 
		  {}, [_pos]
        ] call zen_dialog_fnc_create;
	}
] call zen_custom_modules_fnc_register;

//Twins B
[
	"NJ's Anomalies",

	"Spawn Twins B (EMP)",
	{	
		private ["_pos"];
		_pos = (ASLToAGL (_this select 0));
		//Dialouge box for custom hunt/damage radius and setting if AI will attack twins
        ["Twins Options", 
	  	  [
                ["SLIDER",["Hunting Range","Range at which Twins will hunt down AI/Players"], [1, 10000, 1500, 0]],
				["SLIDER",["Damage Range","Range at which Twins will hurt AI/Players"], [1, 150, 65, 0]],
				["CHECKBOX",["Make Twins invincible","Makes Twins invincible and will change Twins light to blue if 'Give Twins a light' is checked"], [false]],
				["CHECKBOX",["AI will attack","All AI will try and engage Twins"], [true]],
				["CHECKBOX",["Twins will stop","if not checked, Twins will not give a shit if a player is looking at it, it will keep on charging"], [true]],
				["CHECKBOX",["Give Twins a light","A red light will be attatched to Twins to make targeting easier in the night time"], [false]]
          ],
          {
				params ["_dialog", "_args"];
                _dialog params ["_Hunting_Range","_Damage_Range", "_Twins_invincible", "_ai_will_attack_Twins","_Twins_will_stop","_Give_Twins_Light"];
                _args params ["_pos"];
				[_pos, _Hunting_Range, true, _Damage_Range, true, true, _ai_will_attack_Twins, _Twins_will_stop, _Twins_invincible, _Give_Twins_Light] execvm "NJ_Twins\Twins_B.sqf";
          }, 
		  {}, [_pos]
        ] call zen_dialog_fnc_create;
	}
] call zen_custom_modules_fnc_register;
*/