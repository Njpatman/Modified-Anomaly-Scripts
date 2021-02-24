//Sparky boi
[

	"NJ's Anomalies",

	"Spawn Sparky boi",
	{
	private _pos = (ASLToAGL (_this select 0));
    [_pos,"G_Goggles_VR",true] execvm "NJ_Spark\al_sparky.sqf";
	}
] call zen_custom_modules_fnc_register;