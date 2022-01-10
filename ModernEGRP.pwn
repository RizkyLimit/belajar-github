/*
  ______ _______ ______ _____  _   _          _      _____          __  __ ______ _____   _____ 
 |  ____|__   __|  ____|  __ \| \ | |   /\   | |    / ____|   /\   |  \/  |  ____|  __ \ / ____|
 | |__     | |  | |__  | |__) |  \| |  /  \  | |   | |  __   /  \  | \  / | |__  | |__) | (___  
 |  __|    | |  |  __| |  _  /| . ` | / /\ \ | |   | | |_ | / /\ \ | |\/| |  __| |  _  / \___ |
 | |____   | |  | |____| | \ \| |\  |/ ____ \| |___| |__| |/ ____ \| |  | | |____| | \ \ ____) |
 |______|  |_|  |______|_|  \_\_| \_/_/    \_\______\_____/_/    \_\_|  |_|______|_|  \_\_____/ 
                                                                                        

Change notes 0.1a Pre-Alpha:
1. [ADD] Support client '0.3DL' and '0.3.7-R4' version ;
2. [ADD] Mysql database system for input output data ;
3. [ADD] 24 Tables databse ;
4. [CHANGE] Modules system for improved code and managed data ;
5. [CHANGE] Some plugins for improved system gamemode ;

Change notes 0.1b Pre-Alpha:
1. [ADD] Exit/enter interior property states ;
2. [ADD] Some property states location ;
3. [CHANGE] Improved code and add more debug console ;

Change notes 0.1c Pre-Alpha:
1. [ADD] Mapping CGH, ASGH and SANews on modules assets ;
2. [ADD] Arms Dealer and Drug Dealer on property states with pickup point and 3d text label ;
3. [CHANGE] Improved mysql tables and add more configurations ;
4. [CHANGE] Fix some minor bugs ;

Change notes 0.2a Pre-Alpha:
1. [ADD] Pickup point and 3d text label for improved information game ;
2. [ADD] Mechanic, Taxi Driver, and Truck Driver job for additional roleplay mode ;
4. [ADD] Map Building for Fish Factory ;
3. [CHANGE] System enter/exit improved code avoid from minor bugs interior ;
4. [REMOVE] Map Building on east beach for additional feature Fish Factory ;

Change notes 0.2b Pre-Alpha:
1. [ADD] Economy system saving, for additional roleplay mode ;
2. [ADD] HUD system with 'Ctime' code, but if you gmx the server having bug crash only for windows server ;
3. [CHANGE] Improved many code and system gamemode to avoid some minor/major bugs ;

Change notes 0.5a Pre-Alpha (Early):
1. [ADD] More database table for character items ;
2. [ADD] Toggle duty for SAPD on locker point ;
3. [ADD] Items saving system and many improve the codes ;
4. [ADD] Weapon saving system with additional no ammo support system ;
5. [ADD] Death system with additional '/acceptdeath' support system ;
6. [ADD] Anti weapon cheat detected ;
7. [ADD] Command '/locker' for on duty as SAPD ;
8. [ADD] Command '/items' to see all your items ;
9. [ADD] Command '/acceptdeath' to accept death from injured ;
10. [ADD] Detecting client your using when loggin 'Computer Client' and 'Android Client' ;
11. [CHANGE] Fix major bugs on saving character system ;
12. [CHANGE] Now 'Computer Client' and 'Android Client' diffrent visual for improvement ;
13. [CHANGE] Fix minor bugs and improvement timer system ;

Change notes 0.5b Pre-Alpha (Early):
1. [ADD] More information player stats for admin only ;
2. [ADD] Command '/pay' with cent system ;
4. [ADD] Saving player data with every 1 minute ;
5. [CHANGE] Fix major bugs on weapon system ;
6. [CHANGE] Fix major bugs on visual textdraw plant price & fish price ;
7. [CHANGE] Fix minor bugs on time played ;

Contributors:
- SA:MP Team (The creator of San Andreas Multiplayer)
- Y_Less (YSI-Includes, sscanf plugins)
- maddinat0r (mysql plugins)

Copyright © RizkyLimit Inc. 2021
//============================================================================================================================================================*/
#pragma warning disable 239, 214, 217 // Ignores warning for properly indented PAWN code, Pawn compiler v3.10.10

// [ Server Informations ]
#define SERVER_NAME			"Eternalgamers Roleplay"
#define SERVER_NAME_SHORT	"EG:RP"
#define MODE_VERSION		"v0.5a Pre-Alpha (Early)"
#define DISCORD_LINK		"https://bit.ly/EG-RP"
#define CHATLOG				"chatlogs/%s/%s.log"
#define MAX_PLAYERS			10

// [ MySQL Informations ]
#define MYSQL_HOSTNAME		"localhost"
#define MYSQL_USERNAME		"empty"
#define MYSQL_PASSWORD		"00000000"
#define MYSQL_DATABASE		"egrp"

// [ YSI-Includes Config ]
#define CGEN_MEMORY 			90000

// [ Discord Config ]
#define DCMD_PREFIX 			'!'
#define EMAILTEMPLATE 			"mail/templates/%s.html"
#define DC_MAIN_GUILD			"905123859861237812"
#define DC_SAPD_GUILD			"922891672361254943"
#define DC_SAFD_GUILD			"922892931482927164"
#define DC_CHANNEL_REGIST		"905123859861237815"
#define DC_CHANNEL_LOGREGIST	"918449579463159858"
#define DC_ROLE_UNREGISTERED	"918386662084591696"
#define DC_ROLE_REGISTERED		"918385200055091220"

// [ Server Includes ]
#include <a_samp> // This MUST be include for SA:MP.
#include <fixes> // [Modified] This include aims to collect fixes for as many of these bugs as possible from the community.
#include <a_mysql> // [R41-4] This plugin allows you to use MySQL in PAWN.
#include <sscanf2> // [v2.8.3] Allows us to read formatted data from a string rather than standard input.
#include <crashdetect> // [v4.20] Debug runtime errors and server crashes. (Can't use with jit plugin)
#include <sampmailjs> // Send email with pawn code and Node JS.

// YSI-Includes v5.05.0505
#include <YSI_Data\y_iterate> // The latest version of foreach with many extras for iterators and special iterators.
#include <YSI_Coding\y_hooks> // Allowing you to intercept them, or use the same callback in multiple files at once.
#include <YSI_Coding\y_timers> // Wraps SetTimer and SetTimerEx to give compile-time parameter type checks.
#include <YSI_Players\y_android> // Detects when a player is using the Android client:
#include <discord-connector> // [v0.3.5] This plugin allows you to control a Discord bot from within your PAWN script.
#include <discord-cmd> // fast command processor that supports creating discord commands in PAWN with ease. This is made to support samp-discord-connector plugin. (Don't have any version)
#include <samp-bcrypt> // [v0.3.4] A bcrypt plugin for samp in Rust.
#include <Pawn.Regex> // [v1.2.3] Plugin that adds support for regular expressions in Pawn.
#include <filemanager> // [v1.5 Final] FileManager is a simple plugin which allows you to manage files and folders.
#include <easyDialog> // [Modified] The purpose of this include is to make dialogs easier to use in general. (Don't have any version)
#include <streamer> // [v2.9.5] This plugin streams objects, pickups, checkpoints, race checkpoints, map icons, 3D text labels, and actors at user-defined server ticks.
#include <distance> // This library offers a bunch of functions for getting the distance between various entities. (Don't have any version)
#include <compat> // [v1.0.2] Allow connections from previously incompatible SA-MP clients into newer or older servers.
#include <strlib> // String functions for SA-MP Pawn scripting. (Don't have any version)
#include <ctime> //  [v1.2.0] Allows you to use the functions of the C++ library called ctime (time.h) in Pawn.
#include <zcmd> // Quick for commands codes. (Don't have any version)

// [ Server ]
new MySQL:SQL;
new query[10240];

// [ Format Color ]
#define COLOR_CLIENT      (0xAAC4E5FF)
#define COLOR_WHITE       (0xFFFFFFFF)
#define COLOR_RED         (0xFF0000FF)
#define COLOR_CYAN        (0x33CCFFFF)
#define COLOR_LIGHTRED    (0xFF6347FF)
#define COLOR_LIGHTGREEN  (0x9ACD32FF)
#define COLOR_YELLOW      (0xFFFF00FF)
#define COLOR_GREY        (0xAFAFAFFF)
#define COLOR_HOSPITAL    (0xFF8282FF)
#define COLOR_PURPLE      (0xD0AEEBFF)
#define COLOR_LIGHTYELLOW (0xF5DEB3FF)
#define COLOR_DARKBLUE    (0x1394BFFF)
#define COLOR_ORANGE      (0xFFA500FF)
#define COLOR_LIME        (0x00FF00FF)
#define COLOR_GREEN       (0x33CC33FF)
#define COLOR_BLUE        (0x2641FEFF)
#define COLOR_FACTION     (0xBDF38BFF)
#define COLOR_RADIO       (0x8D8DFFFF)
#define COLOR_LIGHTBLUE   (0x007FFFFF)
#define COLOR_SERVER      (0xFFFF90FF)
#define COLOR_DEPARTMENT  (0xF0CC00FF)
#define COLOR_ADMINCHAT   (0x33EE33FF)
#define DEFAULT_COLOR     (0xFFFFFFFF)

// [ Include Modules and Other ]
#include "Global/Macros"
#include "Global/AllHeaders"
#include "Global/AllFunctions"
#include "Global/AllQueryCallbacks"
#include "Global/AllSAMPCallbacks"
#include "Global/AllCommands"
#include "Global/AllDialogs"

// [ Modlets ]
#include "Modlets/PlayerConnect/Include"
#include "Modlets/AFK"
#include "Modlets/Chatlog"
#include "Test/test"

//============================================================================================================================================================
main(){} // This function is useless, don't use it!
//============================================================================================================================================================
public OnGameModeInit()
{
	new curtick = GetTickCount();
	CreateToll();
	DCC_ClearBotActivity();

	// [ SA:MP Setting ]
	SetGameModeText(MODE_VERSION);
	DisableInteriorEnterExits();
	UsePlayerPedAnims();
	ShowPlayerMarkers(false);
	ShowNameTags(true);
	//ManualVehicleEngineAndLights();
	SetNameTagDrawDistance(21.0);
	EnableStuntBonusForAll(false);

	// [ Streamer Setting ]
	Streamer_TickRate(150);
	Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 950);

	// [ Console Server ]
	print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
	print("====================[Server's Information]=================");
	print(" ");
	print("	Server Name     : "SERVER_NAME);
	print("	Mode Version    : "MODE_VERSION);
	print("	Date Created    : Tuesday, 2 November 2021");
	print("	Link Discord    : "DISCORD_LINK);
	print(" ");
	print("	Copyright: RizkyLimit Inc. 2021");
	print(" ");
	print("=======================[Console Log's]=====================");
	// [ MySQL Connecting ]
	mysql_log(ALL);
	SQL = mysql_connect(MYSQL_HOSTNAME, MYSQL_USERNAME, MYSQL_PASSWORD, MYSQL_DATABASE);
	if(mysql_errno(SQL) != 0)
	{
		printf("[MySQL] Couldn't connect to the database (%d).", mysql_errno(SQL));
		SendRconCommand("exit");
	}
	else
	{
		printf("[MySQL] Connected to the database successfully (%d).", _:SQL);
		printf("Server needs %d millisecond to load the gamemode!", (GetTickCount()-curtick));
		print("===========================================================");
		defer UnlockServer();
	}
	return 1;
}
//============================================================================================================================================================
public OnGameModeExit()
{
	DestroyAllDynamicObjects();
	DestroyAllDynamicCPs();
	DestroyAllDynamicRaceCPs();
	DestroyAllDynamicMapIcons();
	DestroyAllDynamic3DTextLabels();
	DestroyAllDynamicAreas();
	mysql_close(SQL);
	return 1;
}
//============================================================================================================================================================
public OnAndroidCheck(playerid, bool:isDisgustingThiefToBeBanned)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerConnect(playerid)
{
	TClientCheck[playerid] = repeat ClientCheck(playerid);
	SetPlayerColor(playerid, HEX_COLOR_AFK);
	ResetVariablePlayer(playerid);
	ResetAccountData(playerid);
	CheckUserData(playerid);
	TogglePlayerSpectating(playerid, true);
	InterpolateCameraPos(playerid, 1807.7985, -1499.5435, 46.9579, 1656.3359, -1497.8246, 53.6404, 60000, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, 1807.7985, -1499.5435, 46.9579, 1656.3359, -1497.8246, 53.6404, 60000, CAMERA_MOVE);
	return 1;
}
//============================================================================================================================================================
public OnPlayerDisconnect(playerid, reason)
{
	if(Logged[playerid])
	{
		SaveAccountData(playerid);
		SaveRemoveVehicleData(playerid);
	}
	return 1;
}
//============================================================================================================================================================
public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerColor(playerid, HEX_COLOR_AFK);
	return 1;
}
//============================================================================================================================================================
public OnPlayerSpawn(playerid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerDeath(playerid, killerid, reason)
{
	return 1;
}
//============================================================================================================================================================
public OnVehicleSpawn(vehicleid)
{
	return 1;
}	
//============================================================================================================================================================
public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerText(playerid, text[])
{
	new string[256];
	if(Logged[playerid])
	{
		if(GetPVarInt(playerid, "AdminDuty") == 1)
		{
			format(string, sizeof(string), COLOR_RED"%s"COLOR_WHITE": (( %s ))", UcpInfo[playerid][uusername], text);
			ProxDetectorChat(30.0, playerid, string);
		}
		else if(GetPVarInt(playerid, "OOCZone") == 1)
		{
			format(string, sizeof(string), "%s: (( %s ))", UcpInfo[playerid][uusername], text);
			ProxDetectorChat(20.0, playerid, string);
		}
		else
		{
			format(string, sizeof(string), "%s says: %s", GetRoleplayName(CharacterInfo[playerid][pusername]), text);
			ProxDetectorChat(15.0, playerid, string);
		}
	}
	else SEM(playerid, "ERROR: You can't say anything right now, login first.");
	return 0;
}
//============================================================================================================================================================
public OnPlayerCommandText(playerid, cmdtext[])
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerCommandReceived(playerid, cmdtext[])
{
	if(!Logged[playerid])
	{
		SEM(playerid, "ERROR: You can't using any command right now, login first.");
		return 0;
	}
	return 1;
}
//============================================================================================================================================================
public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success) return SEM(playerid, "ERROR: Unknown command, see '/help'.");
	return 1;
}
//============================================================================================================================================================
public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}
//============================================================================================================================================================
public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerStateChange(playerid, newstate, oldstate)
{	
	return 1;
}
//============================================================================================================================================================
public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerEnterDynamicCP(playerid, STREAMER_TAG_CP:checkpointid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerLeaveDynamicCP(playerid, STREAMER_TAG_CP:checkpointid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerEnterDynamicRaceCP(playerid, STREAMER_TAG_RACE_CP:checkpointid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerLeaveDynamicRaceCP(playerid, STREAMER_TAG_RACE_CP:checkpointid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	return 1;
}
//============================================================================================================================================================
public OnRconCommand(cmd[])
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerRequestSpawn(playerid)
{
	return 1;
}
//============================================================================================================================================================
public OnObjectMoved(objectid)
{
	return 1;
}
//============================================================================================================================================================
public OnDynamicObjectMoved(STREAMER_TAG_OBJECT:objectid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}
//============================================================================================================================================================
public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}
//============================================================================================================================================================
public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}
//============================================================================================================================================================
public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerExitedMenu(playerid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}
//============================================================================================================================================================
public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerUpdate(playerid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}
//============================================================================================================================================================
public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}
//============================================================================================================================================================
public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}
//============================================================================================================================================================
public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	return 0;
}
//============================================================================================================================================================
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	SetPlayerPosFindZ(playerid, fX, fY, fZ);
	return 1;
}
//============================================================================================================================================================
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerShootDynamicObject(playerid, weaponid, objectid, Float:x, Float:y, Float:z)
{
	return 1;
}
//============================================================================================================================================================
public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	return 1;
}
// //============================================================================================================================================================
public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
	return 1;
}
//============================================================================================================================================================