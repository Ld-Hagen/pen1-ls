#include <a_samp>
#include <core>
#include <float>
#include <time>
#include <file>
#include "../include/rus_text.inc"

#define SCRIPT_VERSION "1.0.1"

new gTeam[MAX_PLAYERS]; // Tracks the team assignment for each player

#define MAX_ALLOWED_CHARS 89
#define CHECKPOINT_NONE 0
#define CHECKPOINT_PICKUP 1
#define CHECKPOINT_DROPOFF 2
#define CHECKPOINT_SR1START 3
#define CHECKPOINT_SRA 4
#define CHECKPOINT_SRB 5
#define CHECKPOINT_SRC 6
#define CHECKPOINT_SRD 7
#define CHECKPOINT_SRE 8
#define CHECKPOINT_SRF 9
#define CHECKPOINT_SRG 10
#define CHECKPOINT_CARDROP 11
#define CHECKPOINT_HOME 12
#define CHECKPOINT_DM 13
#define COLOR_GRAD1 0xB4B5B7FF
#define COLOR_GRAD2 0xBFC0C2FF
#define COLOR_GRAD3 0xCBCCCEFF
#define COLOR_GRAD4 0xD8D8D8FF
#define COLOR_GRAD5 0xE3E3E3FF
#define COLOR_GRAD6 0xF0F0F0FF
#define COLOR_GREY 0xAFAFAFAA
#define COLOR_GREEN 0x33AA33AA
#define COLOR_RED 0xAA3333AA
#define COLOR_YELLOW 0xFFFF00AA
#define COLOR_WHITE 0xFFFFFFAA
#define COLOR_FADE1 0xE6E6E6E6
#define COLOR_FADE2 0xC8C8C8C8
#define COLOR_FADE3 0xAAAAAAAA
#define COLOR_FADE4 0x8C8C8C8C
#define COLOR_FADE5 0x6E6E6E6E
#define COLOR_PURPLE 0xC2A2DAAA
#define COLOR_DBLUE 0x2641FEAA
#define COLOR_ALLDEPT 0xFF8282AA
#define TEAM_CYAN 1
#define TEAM_BLUE 2
#define TEAM_GREEN 3
#define TEAM_ORANGE 4
#define TEAM_BALLAS 5
#define TEAM_GROVE 6
#define TEAM_VAGOS 7
#define TEAM_AZTECAS 8
#define TEAM_NANG 9
#define TEAM_RIFA 78
#define TEAM_MAFIA 11
#define TEAM_RMAFIA 12
#define TEAM_TRIADS 13
#define TEAM_BIKERS 14
#define OBJECTIVE_COLOR 0x64000064
#define TEAM_GREEN_COLOR 0xFFFFFFAA
#define TEAM_BLUE_COLOR 0x8D8DFFAA
#define COLOR_ADD 0x63FF60AA
#define TEAM_CYAN_COLOR 0xFF8282AA
#define TEAM_ORANGE_COLOR 0xFF8300C8
#define TEAM_ORANGE1_COLOR 0xFF830099
#define TEAM_ORANGE2_COLOR 0xFF830088
#define TEAM_ORANGE3_COLOR 0xFF830077
#define TEAM_ORANGE4_COLOR 0xFF830066
#define TEAM_ORANGE5_COLOR 0xFF830055
#define TEAM_ORANGE6_COLOR 0xFF830044
#define TEAM_ORANGE7_COLOR 0xFF830033
#define TEAM_ORANGE8_COLOR 0xFF830022
#define TEAM_ORANGE9_COLOR 0xFF830011
#define TEAM_ORANGE10_COLOR 0xFF830000
#define TEAM_BALLAS_COLOR 0xD900D3C8
#define TEAM_BALLAS1_COLOR 0xD900D399
#define TEAM_BALLAS2_COLOR 0xD900D388
#define TEAM_BALLAS3_COLOR 0xD900D377
#define TEAM_BALLAS4_COLOR 0xD900D366
#define TEAM_BALLAS5_COLOR 0xD900D355
#define TEAM_BALLAS6_COLOR 0xD900D344
#define TEAM_BALLAS7_COLOR 0xD900D333
#define TEAM_BALLAS8_COLOR 0xD900D322
#define TEAM_BALLAS9_COLOR 0xD900D311
#define TEAM_BALLAS10_COLOR 0xD900D300
#define TEAM_GROVE_COLOR 0x00D900C8
#define TEAM_GROVE1_COLOR 0x00D90099
#define TEAM_GROVE2_COLOR 0x00D90088
#define TEAM_GROVE3_COLOR 0x00D90077
#define TEAM_GROVE4_COLOR 0x00D90066
#define TEAM_GROVE5_COLOR 0x00D90055
#define TEAM_GROVE6_COLOR 0x00D90044
#define TEAM_GROVE7_COLOR 0x00D90033
#define TEAM_GROVE8_COLOR 0x00D90022
#define TEAM_GROVE9_COLOR 0x00D90011
#define TEAM_GROVE10_COLOR 0x00D90000
#define TEAM_VAGOS_COLOR 0xFFC801C8
#define TEAM_VAGOS1_COLOR 0xFFC80199
#define TEAM_VAGOS2_COLOR 0xFFC80188
#define TEAM_VAGOS3_COLOR 0xFFC80177
#define TEAM_VAGOS4_COLOR 0xFFC80166
#define TEAM_VAGOS5_COLOR 0xFFC80155
#define TEAM_VAGOS6_COLOR 0xFFC80144
#define TEAM_VAGOS7_COLOR 0xFFC80133
#define TEAM_VAGOS8_COLOR 0xFFC80122
#define TEAM_VAGOS9_COLOR 0xFFC80111
#define TEAM_VAGOS10_COLOR 0xFFC80100
#define TEAM_AZTECAS_COLOR 0x01FCFFC8
#define TEAM_AZTECAS1_COLOR 0x01FCFF99
#define TEAM_AZTECAS2_COLOR 0x01FCFF88
#define TEAM_AZTECAS3_COLOR 0x01FCFF77
#define TEAM_AZTECAS4_COLOR 0x01FCFF66
#define TEAM_AZTECAS5_COLOR 0x01FCFF55
#define TEAM_AZTECAS6_COLOR 0x01FCFF44
#define TEAM_AZTECAS7_COLOR 0x01FCFF33
#define TEAM_AZTECAS8_COLOR 0x01FCFF22
#define TEAM_AZTECAS9_COLOR 0x01FCFF11
#define TEAM_AZTECAS10_COLOR 0x01FCFF00
#define TEAM_NANG_COLOR 0xBDCB92C8
#define TEAM_NANG1_COLOR 0xBDCB9299
#define TEAM_NANG2_COLOR 0xBDCB9288
#define TEAM_NANG3_COLOR 0xBDCB9277
#define TEAM_NANG4_COLOR 0xBDCB9266
#define TEAM_NANG5_COLOR 0xBDCB9255
#define TEAM_NANG6_COLOR 0xBDCB9244
#define TEAM_NANG7_COLOR 0xBDCB9233
#define TEAM_NANG8_COLOR 0xBDCB9222
#define TEAM_NANG9_COLOR 0xBDCB9211
#define TEAM_NANG10_COLOR 0xBDCB9200
#define TEAM_RIFA_COLOR 0x000000C8
#define TEAM_RIFA1_COLOR 0x00000099
#define TEAM_RIFA2_COLOR 0x00000088
#define TEAM_RIFA3_COLOR 0x00000077
#define TEAM_RIFA4_COLOR 0x00000066
#define TEAM_RIFA5_COLOR 0x00000055
#define TEAM_RIFA6_COLOR 0x00000044
#define TEAM_RIFA7_COLOR 0x00000033
#define TEAM_RIFA8_COLOR 0x00000044
#define TEAM_RIFA9_COLOR 0x00000055
#define TEAM_RIFA10_COLOR 0x00000066
#define TEAM_MAFIA_COLOR 0x9A9999C8
#define TEAM_MAFIA1_COLOR 0x9A999999
#define TEAM_MAFIA2_COLOR 0x9A999988
#define TEAM_MAFIA3_COLOR 0x9A999977
#define TEAM_MAFIA4_COLOR 0x9A999966
#define TEAM_MAFIA5_COLOR 0x9A999955
#define TEAM_MAFIA6_COLOR 0x9A999944
#define TEAM_MAFIA7_COLOR 0x9A999933
#define TEAM_MAFIA8_COLOR 0x9A999922
#define TEAM_MAFIA9_COLOR 0x9A999911
#define TEAM_MAFIA10_COLOR 0x9A999900
#define TEAM_RMAFIA_COLOR 0x916600C8
#define TEAM_RMAFIA1_COLOR 0x91660099
#define TEAM_RMAFIA2_COLOR 0x91660088
#define TEAM_RMAFIA3_COLOR 0x91660077
#define TEAM_RMAFIA4_COLOR 0x91660066
#define TEAM_RMAFIA5_COLOR 0x91660055
#define TEAM_RMAFIA6_COLOR 0x91660044
#define TEAM_RMAFIA7_COLOR 0x91660033
#define TEAM_RMAFIA8_COLOR 0x91660022
#define TEAM_RMAFIA9_COLOR 0x91660011
#define TEAM_RMAFIA10_COLOR 0x91660000
#define TEAM_TRIADS_COLOR 0x587B95C8
#define TEAM_TRIADS1_COLOR 0x587B9599
#define TEAM_TRIADS2_COLOR 0x587B9588
#define TEAM_TRIADS3_COLOR 0x587B9577
#define TEAM_TRIADS4_COLOR 0x587B9566
#define TEAM_TRIADS5_COLOR 0x587B9555
#define TEAM_TRIADS6_COLOR 0x587B9544
#define TEAM_TRIADS7_COLOR 0x587B9533
#define TEAM_TRIADS8_COLOR 0x587B9522
#define TEAM_TRIADS9_COLOR 0x587B9511
#define TEAM_TRIADS10_COLOR 0x587B9500
#define TEAM_BIKERS_COLOR 0xA49A00C8
#define TEAM_BIKERS1_COLOR 0xA49A0099
#define TEAM_BIKERS2_COLOR 0xA49A0088
#define TEAM_BIKERS3_COLOR 0xA49A0077
#define TEAM_BIKERS4_COLOR 0xA49A0066
#define TEAM_BIKERS5_COLOR 0xA49A0055
#define TEAM_BIKERS6_COLOR 0xA49A0044
#define TEAM_BIKERS7_COLOR 0xA49A0033
#define TEAM_BIKERS8_COLOR 0xA49A0022
#define TEAM_BIKERS9_COLOR 0xA49A0011
#define TEAM_BIKERS10_COLOR 0xA49A0000
#define COLOR_INVIS 0xAFAFAF00
#define COLOR_SPEC 0xBFC0C200
#define INACTIVE_PLAYER_ID -1
#define C_EVENT   0xFFFF00AA
#define C_WARNING 0xFF0000AA
#define C_TIP     0x00FFFFC8
#define C_DEBUG   0xAAAAAAAA

forward SafeGivePlayerMoney(playerid, money);
forward OnPlayerPrivmsg(senderid, playerid, text[] );
forward DollahScoreUpdate();
forward SetPlayerRandomSpawn(playerid);
forward SetPlayerNewMission();
forward CheckpointReset();
forward SetPlayerToTeamColor(playerid);
forward SetupPlayerForClassSelection(playerid);
forward SetPlayerTeamFromClass(playerid,classid);
forward GameModeExitFunc();
forward GameModeInitExitFunc();
forward PrePlayerNewMission();
forward SetPlayerNewMission();
forward RaceDelay();
forward RaceDelayr();
forward RaceDelayg();
forward OnPlayerDropCashBox(playerid);
forward RewardCalc(playerid,min,max);
forward SetAllPlayerCheckpoint(Float:allx, Float:ally, Float:allz, Float:radi, num);
forward SetAllCopCheckpoint(Float:allx, Float:ally, Float:allz, Float:radi);
forward OpenDoors();
forward SetPlayerCriminal(playerid,declare,reason[],pe,flash);
forward SetPlayerFree(playerid,declare,reason[],pe,flash);
forward OffTheHook();
forward SetPlayerWeapons(playerid);
forward PrintPlayerWeapons(playerid,targetid);
forward SetPlayerToTeamColor(playerid);
forward GameModeInitExitFunc();
forward LoadConfig();
forward GetVal(string[]);
forward SyncUp();
forward SyncTime();
forward PayDay();
forward OnPlayerLogin(playerid,const string[]);
forward PlayerUpdate(playerid);
forward BroadCast(color, string[]);
forward OOCOff(color, string[]);
forward PlaySoundAll(playerid, soundid, Float:psx ,Float:psy ,Float:psz);
forward SendTeamMessage(team, color, string[]);
forward SendAdminMessage(color, string[]);
forward AddCar(carcoords);
forward PlayerPlayMusic(playerid);
forward StopMusic();
forward Decript(string[]);
forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
forward ProxDetectorS(Float:radi, playerid, targetid);
forward FixHour(hour);
forward TestDistance(playerid,giveplayerid,Float:tarx,Float:tary,Float:tarz,Float:radi);
forward PlayJailSound(sound , stopsound, duration, Float: jailx,  Float: jaily,  Float: jailz);
forward MovePlayer(playerid, Float:radius, Float:zangle, Float:vertdelta, wcar = 1);
//---- debug forwards
forward GameTicks();
forward ConvertTicks(ticks);
forward CopScanner();
forward Spectator();
forward IsAPlane(carid);
forward IsACopCar(carid);
forward IsAnAmbulance(carid);
forward IsATruck(carid);
forward ClearCrime(playerid);
forward BetWinner(playerid,contest);
forward PayLog(string[]);
forward CmdLog(string[]);
forward RaceDebug(playerid);
forward RaceEnd();
forward DMDelay();
forward DMDelayr();
forward DMDelayg();
forward DMDetect();
forward DMEndCam(playerid,string[]);
forward DMScoreCalc();
forward JobGive(playerid);
forward HireCost(carid);
//forward CarCheck();
forward CarInit();
forward CarTow(carid);
forward CarRespawn(carid);
forward LockCar(carid);
forward UnLockCar(carid);
forward TeamCarLockInit();
forward TeamLockReset(carid);
forward InitLockDoors(playerid);
forward TeamLockDoors(playerid);
forward DebugPrint(string[],value1,value2,type);
forward CellPhoneTimer();
forward SetPlayerFlash();
forward SetPlayerFlashRev ();
forward RingToner();
forward RingTonerRev();
forward SetPlayerUnjail();
forward VoteKickTimer();
forward ClearVote(kickedid);
forward PrintSBizInfo(playerid,targetid);
forward PrintBizInfo(playerid,targetid);
forward SetPlayerToTeamColorFlash(playerid);
forward SaveRace(playerid,name[]);
forward BestTime(name[]);
forward LoadTmp();
forward LoadRace(playerid,name[]);
forward LoadProperty ();
forward LoadDM(playerid,name[]);
forward SaveDM(playerid,name[]);
forward LoadRaceList(playerid,name[]);
forward SaveRaceList(playerid,name[]);
forward LoadBizz();
forward LoadSBizz();
forward SkyDive();
forward Production();
forward DateProp(playerid);
forward Checkprop();
forward DelPrint(string1[]);
forward LoadPlayer(loaderid,const string[]);
forward SavePlayer(loaderid,const string[]);
forward CopCheck(playerid);
forward MedCheck(playerid);
forward OnPlayerRename (name[],string[],playerid);
forward OnPropUpdate();
forward ABroadCast(color, string[],level);
forward SendTeamBeepMessage(team, color, string[]);
forward SendEnemyMessage(color, string[]);
forward PlayerFixRadio(playerid);
forward PlayerFixRadio2(playerid);
forward StopJail();
forward HouseLevel(playerid);
forward CHouseLevel(houseid);
forward CrimInRange(Float:radi, playerid,copid);
forward CrimProxDetector(Float:radi, playerid,col1,col2,col3,col4,col5,col6,col7,col8,col9,col10);
forward PlayerInArea();
forward PlayerInArena();
forward PenInArea();
forward CustomPickups();
forward IdleKick();
forward AntiCamp();
forward AntiTeleport ();
forward RaceSpec(playerid);
forward BestPlayer(playerid);
forward PenDelay(playerid);
forward SpeedDelay(playerid);
forward DMPlayer(playerid);
forward InHouse();
forward IsStringAName(string[]);
forward GetPlayerID(string[]);
forward SetCamBack(playerid);
forward AddsOn();
forward SetVehicleParamsForPlayerEx(vehicleid, playerid, para1, para2);
forward SetPlayerCheckpointFixed(playerid, Float:px, Float:py, Float:pz, Float:radius);
//------------------------------------------------------------------------------------------------------
new vParams[MAX_VEHICLES+1][MAX_PLAYERS];
new allowedchars[MAX_ALLOWED_CHARS] = {
	'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z', //26
	'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z', //26
	'1','2','3','4','5','6','7','8','9','0', // 10
	'!','@','#','$','%','^','&','*','(',')','-',':',';',',','.','?',' ','[',']','{','}','~','_','/','"','=', //26
	0};
new gPlayerCheckpointStatus[MAX_PLAYERS];
new gPlayerLapStatus[MAX_PLAYERS];
new gPlayerLogged[MAX_PLAYERS];
new gPlayerSpawned[MAX_PLAYERS];
new gActivePlayers[MAX_PLAYERS];
new gLastCar[MAX_PLAYERS];
new gOoc[MAX_PLAYERS];
new BigEar[MAX_PLAYERS];
new Spectate[MAX_PLAYERS];
new FlashTime[MAX_PLAYERS];
new CellTime[MAX_PLAYERS];
new JailTime[MAX_PLAYERS];
new StartTime[MAX_PLAYERS];
new RaceTime[MAX_PLAYERS];
new Contract[MAX_PLAYERS];
new KickVote[MAX_PLAYERS];
new VoteKick[MAX_PLAYERS];
new LastVote[MAX_PLAYERS];
new HireCar[MAX_PLAYERS];
new SafeTime[MAX_PLAYERS];
new HidePM[MAX_PLAYERS];
new gDice[MAX_PLAYERS];
new gSkyDive[MAX_PLAYERS];
new gSpeedo[MAX_PLAYERS];
new gSpentCash[MAX_PLAYERS];
new FirstSpawn[MAX_PLAYERS];
new gPlayerFighter[MAX_PLAYERS];
new DmScore[MAX_PLAYERS];
new LapCount[MAX_PLAYERS];
new SwitchKey[MAX_PLAYERS];
new TVMode[MAX_PLAYERS];
new Fixr[MAX_PLAYERS];
new Hidden[MAX_PLAYERS];
new Locator[MAX_PLAYERS];
new PLicence[MAX_PLAYERS];
new DmHiScore;
new DmHiPlayer = -1;
new Speeder;
new gFighters;
new pos1time;
new pos2time;
new pos3time;
new cmins,csecs,cmils;
new Mobile[MAX_PLAYERS];
new RingTone[MAX_PLAYERS];
new CallCost[MAX_PLAYERS];
new Mute[MAX_PLAYERS];
new gPlayerAccount[MAX_PLAYERS];
new gRaceGuy[MAX_PLAYERS];
new gPlayerMission[MAX_PLAYERS];
new gPhoneBook[MAX_PLAYERS];
new gLastDriver[MAX_VEHICLES+1];
new gTeamCarLock[MAX_VEHICLES+1];
new gCarLock[MAX_VEHICLES+1];
new gPublicEnemy = -1;
new gSuperCop = -1;
new gRaceLeader;
new gFightLeader;
new gRaceFin;
new gRaceMid;
new gRaceMid2;
new gRaceEnd;
new LevScoreOld;
new MissionActive;
new DropOff;
new noooc;
new racelist = 1;
new dmlist = 1;
new automission = 1;
new adds = 1;
new addtimer = 60000;
new raceendtimer;
new dmweapon;
new rconmakeadmin = 0;
new RetVal;
new specflick;
new Float:rx, Float:ry, Float:rz;
new Float:cwx, Float:cwy, Float:cwz;
new Float: scx, Float: scy, Float: scz;
new Float:rsx, Float:rsy, Float:rsz;
new Float:rmx, Float:rmy, Float:rmz;
new Float:rm2x, Float:rm2y, Float:rm2z;
new Float:rex, Float:rey, Float:rez;
new Float: jailxt, Float: jailyt, Float: jailzt;
new stopsoundt;
new carselect[15];
new objstore[128];
new cbjstore[128];
new motd[256];
new CurrentRace[256];
new stealcar = 0;
new stealcardest = 0;
//new rccounter = 0;
new racedelay = 60000;
//new RStart;
new RNext;
new RNext2;
new REnd;
new Float:radardist = 1000.0;
new radarfreq = 1000;
new ghour = 0;
new gminute = 0;
new gsecond = 0;
new reward = 0;
new mediccharge = 1000;
new preward = 0;
new numplayers = 0;
new dollah = 1000; // Amount player recieves on spawn.
new realtime = 1;
new wtime = 15;
new hotwire = 1;
new cashbox = 1;
new streetrace = 1;
new deathmatch = 1;
new levelcost = 10000;
new deathcost = 500;
new paycheck = 10000;
new jobdelay = 20000;
new petime = 180000; //3 minuites
new jailtime = 20000; //20 seconds
new callcost = 10; //20 seconds
new forceteam = 0;
new realchat = 1;
new fow = 1;
new timeshift = 0;
new stats = 0;
new gdebug = 0;
new shifthour;
new synctimer;
new newmistimer;
new unjailtimer;
new playertimer;
new dmtimer;
new cartimer;
new lastkiller;
new celltimer;
new intrate = 1;
new teamcarlock = 0;
new levelexp = 2;
new nocasino = 0;
new idletime = 1800000; //30 mins
new dmtime = 240; //4 mins
new accountplay = 1;
new civnokill =1;
new basedcost = 1000;
new suecost = 1000;
new cchargetime = 10;
new txtcost = 1;
new offhook;
new pickups;
new randomrace = 0;
new nocarcash = 0;
new skydivecount = 60;
new Gtickcount;
new gLaps;
new Float:PlayerPos[MAX_PLAYERS][6];
new Float:DmeCam[6];
new Float:TeleportDest[MAX_PLAYERS][3];
new Float:CarTracking[MAX_PLAYERS][4];
new Float:TelePos[MAX_PLAYERS][6];
new Float:PenPos[3];
new BetRace[MAX_PLAYERS][2];
new BetDm[MAX_PLAYERS][2];
new CreatedCar;
new CreatedCars[MAX_VEHICLES + 1];
new Races[54][128] = {
{"LS2LV2LS"},
{"Downhill"},
{"Docks"},
{"StormDrain"},
{"Rectang"},
{"RampTime"},
{"VineDrive"},
{"RiverDieR"},
{"aero"},
{"AirportDrag"},
{"AirportParking"},
{"AirportRunway"},
{"AirportUnderground"},
{"Square"},
{"CrazyMtChillad"},
{"CupCakeCorner"},
{"Drift"},
{"grovesfjump"},
{"HillRun"},
{"Insanity"},
{"Jumper"},
{"LSDual"},
{"LSMainStreet"},
{"LSOrbital"},
{"OverHill_4X4"},
{"LAEastbound"},
{"StadiumLoop"},
{"TourDeSA"},
{"Tracker"},
{"Vinal"},
{"4x4DirtLoop"},
{"4x4OverTrack"},
{"4x4LSSouth"},
{"4x4DirtLoop"},
{"HillRun"},
{"BigWater"},
{"BlueFarm"},
{"BlueRed"},
{"Coastal"},
{"Countryloop"},
{"DesertGas"},
{"DesertRamp"},
{"FarmersLoop"},
{"JimsRing"},
{"ScorpGo"},
{"RiverRun"},
{"HarbourLoop"},
{"MoonRaker"},
{"VineDrive"},
{"DesertDiver"},
{"DriftHell"},
{"PierPressure"},
{"Mental"},
{"BeachTwist"}
};

new DmGun[12] = {31,30,32,26,28,24,27,25,29,22,23,0};

new DeathMatches[36][128] = {
{"Area52"},
{"Atlantis"},
{"Baseball"},
{"Construction"},
{"Quarry"},
{"Refinery"},
{"RodsOffice"},
{"RodsCastle"},
{"Carrier"},
{"TheBoat"},
{"Ruins"},
{"RodsCampus"},
{"Ruins"},
{"Urban"},
{"Ruins"},
{"TheCage"},
{"TheFarm"},
{"WildWest"},
{"Suburb"},
{"TruckYard"},
{"OpenWarII"},
{"MastaTrailer"},
{"EstateOfHate"},
{"OpenWar"},
{"HellSite"},
{"BigEars"},
{"PirateView"},
{"CabinFever"},
{"BatesMotel"},
{"Woods"},
{"SleepyHallow"},
{"WangView"},
{"DeathWay"},
{"TrainHouse"},
{"Glen"},
{"Abandon"}
};

new Float:gRandomPlayerSpawns[1][3] = {
{2223.8,-1147.1,1025.7} // sp1
};
/*
{1094.4218,-1098.2269,25.2422},
{1101.2023,-1085.7203,26.1813},
{1096.1254,-1064.2736,29.1876},
{1103.8142,-1026.3247,32.0990},
{1142.7146,-1026.3687,32.0073},
{291.8222,-1336.9775,53.4404},
{246.7791,-1354.0120,53.1094},
{161.7426,-1342.1641,69.6395},
{419.9783,-1264.4738,51.5809},
{398.8884,-1270.2999,50.0198},
{2241.2683,-1241.4480,25.3971},
{2221.3689,-1237.8572,24.8427},
{2144.9207,-1245.7646,24.9917},
{2104.0166,-1245.5676,25.2678},
{2191.5950,-1277.3251,25.0362}
};
*/

new Float:gRandomDMSpawns[21][3] = {
{-2414.0,1551.8,2.1}, // 1
{-2406.9,1555.2,2.1}, // 2
{-2392.8,1550.4,2.1}, // 3
{-2406.6,1545.1,2.1}, // 4
{-2391.9,1539.2,2.1}, // 5
{-2379.7,1541.8,2.1}, // 6
{-2366.9,1539.6,2.1}, // 7
{-2426.6,1537.4,2.1}, // 8
{-2473.5,1550.1,33.2}, // 9
{-2474.2,1546.8,23.6}, // 10
{-2464.2,1530.9,17.3}, // 11
{-2437.5,1559.0,17.3}, // 12
{-2416.3,1554.3,26.0}, // 13
{-2424.7,1542.5,26.0}, // 14
{-2410.5,1532.4,26.0}, // 15
{-2403.5,1546.5,26.0}, // 16
{-2389.2,1550.7,26.0}, // 17
{-2368.0,1556.7,17.3}, // 18
{-2351.5,1551.1,23.1}, // 19
{-2313.7,1546.4,18.7}, // 20
{-2313.7,1546.4,18.7} // 21
};

new Float:gDMWbounds[4] = {0.0,0.0,0.0,0.0};

new Float:gCopPlayerSpawns[2][3] = {
{1530.8369,-1664.8872,6.2188},
{1530.6913,-1669.4760,6.2188}
//{614.8,-608.2,17.2},
//{611.5,-607.8,17.2}
};

new Float:gMedPlayerSpawns[2][3] = {
{1178.1,-1321.0,14.1},
{1177.7,-1325.0,14.0}
};

new Float:gRaceCheckpoints[5][3] = {
{144.869800 ,-1564.952000,10.716340},
{1370.314000,-939.442600,34.187500},
{2865.989000,-1657.180000,10.875000},
{2123.180000,-2665.730000,13.375000},
{1350.4,-1400.2,13.3}//ls
};

/*
{1699.2, 1435.1, 10.7},
{1457.7,-1160.6,23.4},
{1454.2,-1439.2,13.1},
{1711.3,-1439.7,13.1},
{1710.7,-1163.6,23.4},
{1711.3,-1439.7,13.1},
{-1417.0,-295.8,14.1},
{-1945.2,606.4,35.0},//sf
{-2262.5,2310.1,4.8},
{-795.5,2421.2,157.0},
{310.1,1946.2,17.6},
{2349.5,2142.5,10.6},//lv
{1350.4,-1400.2,13.3}//ls
};
*/

new Float:gCBdropoff[37][3] = {
{2217.2,-1179.7,29.7},
{1098.1,-1428.0,22.7},
{2484.2,-1961.8,16.7},
{733.2,-1357.9,23.5},
{1411.6,-1455.1,20.4},
{1080.6,-1605.0,20.4},
{382.0,-2058.7,10.7},
{656.1,-1646.6,15.4},
{816.2,-1380.5,23.5},
{853.3,-1388.2,-0.5},
{915.4,-1235.1,17.2},
{1153.7,-1180.4,32.8},
{1183.9,-1257.3,18.8},
{1441.3,-926.8,39.6},
{1527.5,-893.5,57.6},
{1342.1,-1624.3,17.7},
{1292.1,-770.7,95.9},
{1907.9,-1318.6,14.1},
{1971.7,-1284.5,28.4},
{2687.1,-1144.6,71.3},
{2654.1,-1317.5,58.9},
{2771.0,-1388.5,27.1},
{2793.3,-1945.0,17.3},
{197.9,-1206.0,78.3},
{2447.5,-2209.8,26.6},
{2512.4,-2072.9,26.5},
{2171.6,-1732.1,17.2},
{2175.4,-1836.1,16.1},
{2399.5,-1550.7,28.0},
{2109.2,-1010.2,63.8},
{1409.9,-1274.5,33.4},
{1279.8,-1439.0,20.4},
{2234.0,-2269.3,17.8},
{2025.8,-2133.1,19.8},
{811.2,-1098.2,25.9},
{818.2,-944.2,55.2},
{1976.8,-1779.4,17.3}
};

enum pSpec
{
	Float:sPx,
	Float:sPy,
	Float:sPz,
	sPint,
	sLocal,
	sCam,
};

new Unspec[MAX_PLAYERS][pSpec];

enum eCars
{
	model_id,
	Float:pos_x,
	Float:pos_y,
	Float:pos_z,
	Float:z_angle
};

enum pInfo
{
	pPassword[128],
	pCash,
	pAccount,
	pAdmin,
	pLevel,
	pExp,
	gPupgrade,
	pKills,
	pCB,
	pHW,
	pSR,
	pWA,
	pPEN,
	pGun1,
	pGun2,
	pGun3,
	pGun4,
	pGun5,
	pGun6,
	pAmmo1,
	pAmmo2,
	pAmmo3,
	pAmmo4,
	pAmmo5,
	pAmmo6,
	Float:pSHealth,
	Float:pHealth,
	Float:pPos_x,
	Float:pPos_y,
	Float:pPos_z,
	pInt,
	pLocal,
	pTeam,
	pModel,
	pPnumber,
	pPhousekey,
	pPbiskey,
};
new PlayerInfo[MAX_PLAYERS][pInfo];

enum plInfo
{
	plPassword[128],
	plCash,
	plAccount,
	plAdmin,
	plLevel,
	plExp,
	glPupgrade,
	plKills,
	plCB,
	plHW,
	plSR,
	plWA,
	plPEN,
	plGun1,
	plGun2,
	plGun3,
	plGun4,
	plGun5,
	plGun6,
	plAmmo1,
	plAmmo2,
	plAmmo3,
	plAmmo4,
	plAmmo5,
	plAmmo6,
	Float:plSHealth,
	Float:plHealth,
	Float:plPos_x,
	Float:plPos_y,
	Float:plPos_z,
	plInt,
	plLocal,
	plTeam,
	plModel,
	plPnumber,
	plPhousekey,
	plPbiskey,
};
new PLlayerInfo[MAX_PLAYERS][plInfo];

enum hInfo
{
	Float:hEntrancex,
	Float:hEntrancey,
	Float:hEntrancez,
	Float:hExitx,
	Float:hExity,
	Float:hExitz,
	hHealthx,
	hHealthy,
	hHealthz,
	hArmourx,
	hArmoury,
	hArmourz,
	hOwner[MAX_PLAYER_NAME],
	hDiscription[MAX_PLAYER_NAME],
	hValue,
	hHel,
	hArm,
	hInt,
	hLock,
	hOwned,
	hRooms,
	hRent,
	hRentabil,
	hTakings,
	hVec,
	hVcol1,
	hVcol2,
	hDate,
	hLevel,
};

new HouseInfo[34][hInfo];

enum bInfo
{
	Float:bEntrancex,
	Float:bEntrancey,
	Float:bEntrancez,
	Float:bExitx,
	Float:bExity,
	Float:bExitz,
	bHealthx,
	bHealthy,
	bHealthz,
	bArmourx,
	bArmoury,
	bArmourz,
	bOwner[MAX_PLAYER_NAME],
	bDiscription[64],
	bValue,
	bHel,
	bArm,
	bInt,
	bLock,
	bOwned,
	bEntcost,
	bTakings,
	bDate,
	bLevel,
	bProd,
	bProdCap,
	bComp,
	bCompCap,
	bProdCost,
	bPayComp,
	bPriceMod,
};

new BizzInfo[13][bInfo];

enum sbInfo
{
	Float:sbEntrancex,
	Float:sbEntrancey,
	Float:sbEntrancez,
	sbOwner[MAX_PLAYER_NAME],
	sbDiscription[64],
	sbValue,
	sbHel,
	sbArm,
	sbInt,
	sbLock,
	sbOwned,
	sbEntcost,
	sbTakings,
	sbDate,
	sbLevel,
	sbProd,
	sbProdCap,
	sbComp,
	sbCompCap,
	sbProdCost,
	sbPayComp,
};

new SBizzInfo[14][sbInfo];

enum pHaul
{
	pCapasity,
	pLoad,
};

new PlayerHaul[100][pHaul];

enum pCrime
{
	pBplayer[32],
	pAccusing[32],
	pAccusedof[32],
	pVictim[32],
};

new PlayerCrime[MAX_PLAYERS][pCrime];

enum pTele
{
	Float:pTmpposx,
	Float:pTmpposy,
	Float:pTmpposz,
	pTmpint,
};

new Teletmp[255][pTele];

enum rInfo
{
	Float:rStartx,
	Float:rStarty,
	Float:rStartz,
	Float:rMidx,
	Float:rMidy,
	Float:rMidz,
	Float:rMid2x,
	Float:rMid2y,
	Float:rMid2z,
	Float:rEndx,
	Float:rEndy,
	Float:rEndz,
	rName[MAX_PLAYER_NAME],
	rBest[MAX_PLAYER_NAME],
	rBestm,
	rBests,
	rBestms,
	rLaps,
};

new RaceInfo[rInfo];

/*
enum pPickup
{
	pID,
	pType,
	Float:pPx,
	Float:pPy,
	Float:pPz,
};

new PickUps[MAX_PLAYERS][pPickup];
*/

new RandCars[50][1] = {
{404},{405},{410},{413},{418},
{419},{421},{422},{426},{436},
{439},{445},{458},{466},{467},
{474},{475},{479},{482},{483},
{491},{492},{496},{500},{507},
{516},{517},{518},{526},{527},
{529},{533},{540},{542},{545},
{546},{547},{549},{550},{551},
{555},{566},{579},{580},{585},
{587},{589},{600},{602},{603}
};


new RandLCars[6][1] = {
{431},// bus
{433},// barracks
{437},// coach
{443},// packer
{455},// flatbed
{578}// dft30
};


new GunPrice[30][1] = {
{500}, //parachute
{400}, //golfclub
{300}, //nightstick
{200}, //knife
{700}, //baseballbat
{300}, //shovel
{100}, //poolcue
{400}, //purpledildo
{780}, //whitedildo
{560}, //longwhitedildo
{530}, //whitedildo2
{200}, //flowers
{600}, //cane
{500}, //sdpistol
{1000}, //colt45
{1500}, //deagle
{2000}, //Tec9
{3000}, //uzi
{2500}, //mp5
{100}, //shotgun
{2000}, //spas12
{4000}, //sawnoff
{2000}, //ak47
{2500}, //m4
{1000}, //rifle
{1}, //pistolammo
{10}, //shotgunammo
{2}, //smgammo
{20}, //assaultammo
{50} //rifle
};

new Peds[276][1] = {
{264},
{102},//TEAM_BALLAS
{103},
{104},
{105},//TEAM_GROVE
{106},
{107},
{108},//TEAM_VAGOS
{109},
{110},
{114},//TEAM_AZTECAS
{115},
{116},
{121},// TEAM_NANG
{122},
{123},
{124},//TEAM_MAFIA
{125},
{126},
{127},
{111},//TEAM_RMAFIA
{112},
{113},
{117},//TEAM_TRIADS
{118},
{120},
{247},//TEAM_BIKERS
{248},
{100},
{256},
{263},
{262},
{261},
{260},
{259},
{258},
{257},
{256},
{255},
{253},
{252},
{251},
{250},
{249},
{246},
{245},
{244},
{243},
{242},
{241},
{240},
{239},
{238},
{237},
{236},
{235},
{234},
{233},
{232},
{231},
{230},
{229},
{228},
{227},
{226},
{225},
{173},
{174},
{175},
{224},
{223},
{222},
{221},
{220},
{219},
{218},
{217},
{216},
{215},
{214},
{213},
{212},
{211},
{210},
{209},//	{208},
{207},
{206},
{205},
{204},
{203},
{202},
{201},
{200},
{199},
{198},
{197},
{196},
{195},
{194},
{193},
{192},
{191},
{190},
{189},
{188},
{187},
{186},
{185},
{184},
{183},
{182},
{181},
{180},
{179},
{178},
{177},
{176},
{172},
{171},
{170},
{169},
{168},
{167},//	{166},//	{165},//	{164},//	{163},
{162},
{161},
{160},
{159},
{158},
{157},
{156},
{155},
{154},
{153},
{152},
{151},
{150},//	{149},
{148},
{147},
{146},
{145},
{144},
{143},
{142},
{141},
{140},
{139},
{138},
{137},
{136},
{135},
{134},
{133},
{132},
{131},
{130},
{129},
{128},
{101},
{254},
{99},
{98},
{97},
{96},
{95},
{94},
{93},
{92},
{91},
{90},
{89},
{88},
{87},//	{86},
{85},
{84},
{83},
{82},
{81},
{80},
{79},
{78},
{77},
{76},
{75},//	{74},
{73},
{72},
{69},
{68},
{67},
{66},//	{65},
{64},
{63},
{62},
{61},
{60},
{59},
{58},
{57},
{56},
{55},
{54},
{53},
{52},
{51},
{50},
{49},
{48},
{47},
{46},
{45},
{44},
{43},//	{42},
{41},
{40},
{39},
{38},
{37},
{36},
{35},
{34},
{33},
{32},
{31},
{30},
{29},
{28},
{27},
{26},
{25},
{24},
{23},
{22},
{21},
{20},
{19},
{18},
{17},
{16},
{15},
{14},
{13},
{12},
{11},
{10},
{1},//TRUTH
{2},//MACCER
{290},//ROSE
{291},//PAUL
{292},//CESAR
{293},//OGLOC
{294},//WUZIMU
{187},
{296},//JIZZY
{297},//MADDOGG
{298},//CAT
{299},//ZERO
{71}, //=255 amb
{70},
{274},
{275},
{276}, //==259
{163}, //=260
{164},
{165},
{166},
{295},//TORINO
{246},
{186},
{147},
{288},
{286},
{285},
{284},
{283},
{282},
{281},
{280} //276
};
//{9},
//{8},
//{7},
//{6},
//{5},
//{4},
//{3},
//{2},
//{1}


/*
{536},//Blade
{496},//Blista
{422},//Bobcat
{518},//Buccaneer
{402},//Buffalo
{482},//Burrito
{480},//Comet
{562},//Elegy
{587},//Euros
{533},//Feltzer
{565},//Flash
{579},//Huntly
{545},//Hustler
{546},//Intruduer
{559},//Jester
{400},//Landstalker
{517},//Majestic
{551},//Merit
{500},//Mesa
{467},//Oceanic
{603},//Phoenix
{436},//Previon
{475},//Sabre
{567},//Savanna
{535},//Slamvan
{561},//Stratum
{560},//Sultan
{550},//Sunrise
{566},//Tahoma
{558},//Uranus
{540},//Vincent
{412},//Voodoo
{421},//Washington
{529},//Willard
{555}//Windsor
};
*/

new RandLow[7][1] = {
{536}, //Blade
{575}, //Broadway
{534}, //Remington
{567}, //Savanna
{535}, //Slamvan
{576}, //Tornado
{412}  //Voodoo
};

new RandBikes[12][1] = {
//{448},//Pizza Boy
{461},//PCJ-600
{462},//Faggio
{463},//Freeway
{468},//Sanchez
{481},//BMX
{509},//Bike
{510},//Mountain Bike
{521},//FCR-900
//{522},//NRG-500
{581},//BF-400
{586},//Wayfarer
{571},//kart
{471}//quad
};

new RandAngles[5][1] = {
{562},//Elegy
//{561},//Stratum
{565},//Flash
{559},//Jester
{558},//Uranus
{560}//Sultan
};

new Float:HouseCarSpawns[34][4] = {
{2342.5,-1039.8,52.5,180.1809},//flash //trailer 0
{2064.4,-1694.4,13.1,271.1561},//elergy 1
{2246.9573,-1909.0677,14.2518,177.5861},
{1109.8,-968.0,42.7,0.0},//house3
{2497.6274,-2025.6306,13.2521,355.4281}, // hosue 4
{2645.0,-1990.8,13.1,180.0},//balde hr - 5
{2503.5977,-1364.4044,28.2365,357.6592},//house 6
{1910.5149,-1120.5304,25.4493,177.8350},//house7
{828.8,-887.0,68.5,230.7095},//blistac 8
{2149.6,-1610.9,14.0,90.7904},//remington 9
{760.1,-1687.8,4.3,180.6},//10
{645.5,-1616.1,14.9,0.0},//supergt 11
{1830.7705,-1404.1754,13.1338,269.9360},//house 12
{1679.2,-1462.9,13.3,270.0},//comet 13
{959.5864,-901.0845,45.8584,177.3087},//newhouse cheeta	14
{2445.8,-1326.8,23.6,18.4},
{2845.9,-1286.8,18.9,90.0},//savanna 8 house 16
{2159.8,-1803.9,13.3,271.4}, //blank 17
{2485.1,-1653.4,13.1,90.7904},//bullit 10 house 18
{977.6,-829.0,95.6,0.0},//hotring 2 house 19
{1514.0,-694.6,94.5,90.0},//bullit 10 house 20
{1246.7,-1107.6,25.5,266.4},//rancher 5 house 21
{831.7,-857.5,69.9,180.0},//bucaner//hotrod 6 house 22
{1007.9,-659.4,121.1,130.6194},//cheetah 23
{1110.0,-726.4,100.1,90.0},//zr350 //house 24
{259.7,-1221.0,74.7,202.0011},//infurnus house25
{1463.7,-901.7,55.8,359.0},//euros //house26
{1440.1,-890.6,51.2,0.0},//banshee //house 27
{1040.7,-1053.7,31.7,0.0},//banshee //house 19
{1146.2,-2046.5,69.0,301.3},
//{1880.2,-2022.3,13.3,180.0},//banshee //house 20 //move
{963.5,-1830.8,12.6,254.8},//banshee //house 21
{2088.6,-1140.6,25.5,90.8},//banshee //house 21
{904.5523,-1454.7026,12.9286,269.2811},
{1534.1,-841.5,65.0,93.2}//banshee //house 21
};


new CarSpawns[][eCars] = {
	{405,2205.2,-1177.0,25.7,270.8},//carid 90
	{554,2205.1,-1169.1,25.7,270.8},
	{426,2216.7,-1170.6,25.7,268.3},
	{445,2228.5,-1177.3,25.7,88.4},
	{492,2229.2,-1170.2,25.7,86.9},
	{507,2228.9,-1162.7,25.7,87.8},
	{545,2217.0,-1157.2,25.7,269.8},
	{540,169.1929,-1342.3611,69.7396,180.4404},
	{482,422.8060,-1263.5979,51.6681,21.4204},
	{547,405.9748,-1264.3921,50.1237,24.2110},
	{550,2242.3, -1235.4, 24.3,359.7513},
	{551,2223.9, -1237.3, 24.4,358.8547},
	{560,2106.4695,-1248.7920,24.0461,0.1524},
	{566,2196.2891,-1277.7905,24.2147,180.4522},
	{402,198.6057,-1437.2435,13.1844,318.3837},
	{405,216.5521,-1431.4004,13.0853,132.5749},
	{554,334.2231,-1343.7405,14.3828,209.9581},
	{426,481.0428,-1320.8564,15.4095,35.6808},
	{507,697.4343,-1230.9486,16.5063,298.7916},
	{545,723.9850,-1121.5535,18.1450,333.9010},
	{540,912.2176,-996.2035,38.1402,7.5764},
	{482,982.1829,-921.8636,41.8776,262.3163},
	{547,981.8715,-917.3546,41.5443,88.0589},
	{550,1188.4082,-925.1859,42.8590,277.5563},
	{400,1307.5226,-914.4717,39.0082,269.3765},
	{405,1450.2,-937.1,36.2,269.6909}, //116
	{492,2148.3257,-1175.2518,24.1959,269.6909},
	{507,2161.4871,-1163.1450,23.6760,269.1628},
	{545,2216.8965,-1165.9469,25.4697,89.8643},
	{540,2348.2910,-1167.9983,27.3637,323.1586},
	{482,2502.0388,-1134.9507,39.1953,150.9506},
	{547,2909.4895,-1180.3746,11.0176,222.1346},
	{550,2853.1858,-1326.8011,11.1511,278.9301},
	{551,2797.2690,-1549.3374,10.4935,93.0282},
	{533,2796.9031,-1567.2024,10.6386,272.4041},
	{482,2813.2175,-1673.0276,9.6638,2.3369},
	{547,2827.6736,-1703.9755,9.7308,77.2896},
	{550,2809.3872,-1837.2391,9.7398,268.9880},
	{551,2870.8789,-1943.2599,11.4834,359.2344},
	{566,2411.5386,-2134.7576,13.9352,0.7795},
	{554,1389.7467,-2695.9370,13.4164,121.1818},
	{405,783.1359,-1601.8208,13.2577,270.9069},
	{554,782.7205,-1619.3584,13.2653,93.0550},
	{426,923.0841,-1361.7990,13.0324,181.1371},
	{445,911.7986,-1352.7415,13.1543,359.3287},
	{492,1174.6599,-922.1939,43.1189,276.8927},
	{507,1363.0210,-1288.3124,13.2839,180.1453},
	{545,1363.2723,-1260.8229,13.0954,179.5841},
	{540,2383.5627,-1927.9207,13.2436,359.6281},
	{482,2377.0374,-1927.8434,13.1071,0.7843},
	{547,2391.7234,-1978.0658,13.1963,90.1736},
	{550,2396.6899,-1966.8123,13.2793,271.6838},
	{551,2391.1135,-1500.6554,23.6355,269.7709},
	{560,2390.7446,-1490.9093,23.5335,271.1926},
	{405,321.2212,-1809.3561,4.2627,179.7758},
	{554,334.3586,-1789.3143,4.6717,178.7722},
	{426,343.8039,-1808.9827,4.3090,181.8368},
	{445,499.4850,-1764.0182,5.3367,89.7930},
	{492,646.4998,-1771.6411,13.2905,348.7706},
	{507,740.4332,-1797.7659,13.9196,349.9927},//150
	{545,652.4496,-1656.7273,14.4585,91.3294},
	{540,546.0256,-1622.4747,16.4585,180.7857},
	{482,438.9431,-1625.4088,25.7951,0.1850},
	{547,453.3896,-1494.3240,30.7917,7.7513},
	{550,487.6469,-1516.2312,20.0235,185.5384},
	{551,300.5775,-1490.8882,24.3748,235.1359},
	{560,297.9918,-1535.9011,24.3758,231.2773},
	{566,524.0590,-1375.0093,15.8231,193.3626},
	{405,598.9131,-1519.1414,14.8214,180.4083},
	{554,593.2022,-1519.3578,14.9461,181.5466},
	{426,733.5679,-1438.4880,13.3203,266.7551},
	{445,770.4971,-1431.1127,13.3247,0.7436},
	{492,735.9440,-1346.2430,13.3003,88.3069},
	{507,736.8572,-1337.1550,13.3140,271.3832},
	{545,856.7003,-1363.1852,13.4093,179.8542},//165
	{482,888.1506,-1659.2727,13.3296,1.2414},
	{547,879.1024,-1669.2560,13.3305,180.5853},
	{550,888.0242,-1678.5981,13.3294,358.4990},
	{551,920.4441,-1823.0966,12.3452,84.1821},
	{560,986.5818,-1761.2992,13.4014,181.9385},
	{566,1062.6744,-1757.9412,13.1956,89.0572},
	{405,1084.3831,-1763.8369,13.1501,269.0443},
	{554,1081.8948,-1629.9564,13.4064,90.0880},
	{426,981.7941,-1523.5115,13.3379,267.2751},
	{445,1014.7464,-1434.4586,13.3292,266.3129},
	{492,2684.6,-1990.2,13.3,180.0931},
	{507,2684.6,-2019.0,13.3 ,0.8777},
	{545,1096.1,-1379.9,13.3,270.1909},//178
	{540,1151.6812,-1203.2323,20.2889,273.5155},//179
	{482,1182.2568,-1219.2407,18.4163,0.5578},
	{547,1260.9978,-1187.1921,23.3559,183.3606},
	{550,1331.9304,-1081.3899,24.9941,90.4092},
	{551,1284.8755,-1525.5013,13.3451,269.4388},
	{560,1279.1887,-1539.2032,13.3201,94.8070},
	{566,1275.9120,-1646.7448,13.3273,267.2669},
	{405,1318.2792,-1785.7821,13.2429,182.4215},
	{554,1253.9153,-1833.3832,13.1734,175.3692},
	{426,1279.2875,-1814.4156,13.1657,93.6385},
	{445,1198.5004,-1835.2216,13.1820,93.6780},
	{492,1479.9131,-1737.8813,13.2418,269.5805},
	{507,1508.1047,-1737.7089,13.2418,270.0250},
	{545,1618.0411,-1891.1044,13.3278,0.3364},
	{540,1623.7291,-1892.7234,13.3307,180.0126},
	{482,1742.8494,-1857.7446,13.1960,271.1740},
	{547,1743.5837,-1844.6041,13.3557,180.3384},
	{550,1838.1904,-1871.3842,13.1703,358.5452},
	{551,1841.4791,-1871.6549,13.1687,179.3825},
	{560,1777.1376,-1910.0310,13.1681,91.0725},
	{566,1803.1235,-1920.5144,13.1758,266.0453},
	{566,1981.0780,-1986.3513,13.3275,2.1479},
	{405,1987.6057,-1994.9520,13.3296,359.9128},
	{554,1978.0371,-2066.7500,13.1640,358.2871},
	{426,1984.7471,-2066.7776,13.1625,359.7226},
	{445,1938.0565,-2086.8459,13.3429,268.3414},
	{492,1947.1119,-2136.3887,13.3286,90.9804},
	{507,1932.1523,-2141.5220,13.3429,1.8383},
	{545,1793.9172,-2148.5300,13.3781,359.7861},
	{540,1748.0751,-2084.2090,13.3324,0.4337},
	{482,1560.5026,-2260.5457,13.3258,268.7398},
	{547,1461.6943,-1505.1688,13.2541,356.9007},
	{550,1426.4930,-1402.3170,13.1800,181.0290},
	{551,1435.0645,-1325.6835,13.2580,270.9400},
	{560,1513.9486,-1272.5691,14.2685,181.0697},
	{566,1583.7561,-1338.7435,16.1896,359.8619},
	{405,1573.8772,-1209.9202,17.1378,92.7502},
	{554,1476.2012,-1120.3083,23.5660,359.9746},
	{426,1430.2316,-1054.8555,22.8693,359.3625},
	{445,1574.1168,-1036.7643,23.6151,145.6786},
	{492,1617.6676,-1009.8663,23.6052,356.8697},
	{507,1645.3188,-1036.5238,23.6027,0.7258},
	{545,1735.2826,-1010.5402,23.6588,346.3133},
	{540,1770.4874,-1060.9886,23.6658,179.2750},
	{482,1739.9854,-1084.5490,23.6660,176.8026},
	{547,1653.1766,-1134.8994,23.6110,178.6835},
	{550,1617.3746,-1132.8293,23.6117,91.7300},
	{551,1790.0190,-1292.9065,13.2653,267.2964},
	{560,1754.3009,-1476.8170,13.2402,269.6320},
	{554,2003.3417,-1121.4993,26.3879,357.4926},
	{426,2084.2334,-1170.0986,24.2042,91.8975},
	{445,2229.1128,-1357.8774,23.6930,268.2194},
	{492,2229.2278,-1345.4033,23.6892,93.3009},
	{507,2332.5684,-1362.4845,23.7297,358.1198},
	{545,2384.1567,-1275.6326,23.9198,101.6528},
	{540,2432.3149,-1226.0785,24.9941,17.9805},
	{482,2426.9612,-1224.4158,25.0000,202.7159},
	{547,2438.4309,-1321.6925,24.1225,269.7535},
	{551,2612.9702,-1262.6970,48.2461,269.4752},
	{560,2659.4529,-1428.4343,30.1790,266.5051},
	{566,2659.7053,-1422.6743,30.1714,89.8159},
	{405,2485.5313,-1556.1823,23.7478,178.8338},
	{554,2478.7664,-1555.7006,23.7226,183.6043},
	{426,2605.3967,-1365.8829,34.6461,359.9891},
	{445,2754.7136,-1373.0253,40.1154,91.4169},
	{492,2717.3662,-1468.0308,30.0894,1.0298},
	{507,2816.7195,-1449.4285,15.9549,268.9106},
	{545,2816.9937,-1441.5880,15.9544,90.7779},
	{540,2681.9016,-1673.3879,9.1290,0.5605},
	{482,2442.5845,-1642.7507,13.1644,180.3454},
	{547,2361.3120,-1674.6146,13.2505,357.4959},
	{550,2298.3535,-1633.7542,14.3849,80.8107},
	{551,2297.9077,-1639.9464,14.4352,94.4292},
	{560,2255.4045,-1664.5736,15.1304,74.6898},
	{566,2234.1057,-1726.9386,13.1665,271.7536},
	{405,2319.3833,-1716.6823,13.2518,359.8540},
	{554,2474.5105,-1755.9194,13.2522,270.5967},
	{426,2501.8213,-1754.2794,13.1208,176.4916}, //= 255
	{445,2489.1560,-1952.6886,13.1366,178.1629},
	{492,2495.4326,-1953.2922,13.1299,356.5514},
	{507,2306.7168,-1989.6796,13.2639,184.8385},
	{482,2056.1807,-1904.7751,13.2502,2.2910},
	{550,2064.9871,-1919.1674,13.2504,180.8575},
	{551,1886.4812,-2022.9338,13.0964,179.4265},
	{560,1824.8976,-2019.8374,13.0875,272.5273},
	{566,1942.1669,-1862.6425,13.2679,264.5590},
	{405,1923.9409,-1795.5616,13.0877,90.0886},
	{554,1807.0905,-1571.7120,13.1659,125.1048},
	{426,1809.9016,-1676.0603,13.2422,180.7589},
	{445,1809.6266,-1653.3402,13.2365,180.6530},
	{492,1809.7056,-1660.3019,13.2380,180.6262},
	{507,1978.4003,-1675.0157,15.6741,269.7336},
	{545,1974.8230,-1693.5488,15.6741,92.1162},
	{540,1929.2253,-1584.6954,13.2700,185.5542},
	{482,1731.9725,-1590.8959,13.1630,77.7249},
	{547,1721.5776,-1589.2834,13.1526,80.9057},
	{550,1695.1428,-1519.2667,13.1671,0.7121},
	{551,1694.7080,-1501.7454,13.1675,357.8150}
    };

// new Float:gJailPlayerSpawns[1][3] = {
// {264.395200,77.564040,1001.039000}
// };

//Round code stolen from mike's Manhunt :P
new gRoundTime = 3600000;                   // Round time - 1 hour
//new gRoundTime = 1200000;					// Round time - 20 mins
//new gRoundTime = 900000;					// Round time - 15 mins
//new gRoundTime = 600000;					// Round time - 10 mins
//new gRoundTime = 300000;					// Round time - 5 mins
//new gRoundTime = 120000;					// Round time - 2 mins
//new gRoundTime = 60000;					// Round time - 1 min



//------------------------------------------------------------------------------------------------------

main()
{
print(" ");
print(" ");
print("Public Enemy No.1 LS Russian for SAMP 0.3a");
print("__________________________________________");
print("Autor: Denver");
print("Translated and modified by D0lph1N");
print(" ");
}

//------------------------------------------------------------------------------------------------------

public DollahScoreUpdate()
{
	new LevScore;
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
   			LevScore = PlayerInfo[i][pLevel];
			SetPlayerScore(i, LevScore);
			if (LevScore > LevScoreOld)
			{
				LevScoreOld = LevScore;
			}
		}
	}
	return 1;
}

public GameTicks()
{
	Gtickcount = Gtickcount+500;
}

public ConvertTicks(ticks)
{
	csecs = 0;
	cmils = 0;
	cmins = 0;
	new tempcsecs = ticks / 1000;//61.59
	cmins = ticks / 60000;//1.0265
	csecs = (ticks - cmins*60000)/1000;
	cmils = (ticks - tempcsecs*1000)/10;
}


public CopScanner()
{
	for(new i=0; i<MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i) && gTeam[i] >= 4 && gPublicEnemy != i && gSuperCop != i && Hidden[i] !=1)
		{
			if(gTeam[i] == 4)
			{
				CrimProxDetector(radardist, i,TEAM_ORANGE1_COLOR,TEAM_ORANGE2_COLOR,TEAM_ORANGE3_COLOR,TEAM_ORANGE4_COLOR,TEAM_ORANGE5_COLOR,TEAM_ORANGE6_COLOR,TEAM_ORANGE7_COLOR,TEAM_ORANGE8_COLOR,TEAM_ORANGE9_COLOR,TEAM_ORANGE10_COLOR);
			}
			if(gTeam[i] == 5)
			{
				CrimProxDetector(radardist, i,TEAM_BALLAS1_COLOR,TEAM_BALLAS2_COLOR,TEAM_BALLAS3_COLOR,TEAM_BALLAS4_COLOR,TEAM_BALLAS5_COLOR,TEAM_BALLAS6_COLOR,TEAM_BALLAS7_COLOR,TEAM_BALLAS8_COLOR,TEAM_BALLAS9_COLOR,TEAM_BALLAS10_COLOR);
			}
			if(gTeam[i] == 6)
			{
				CrimProxDetector(radardist, i,TEAM_GROVE1_COLOR,TEAM_GROVE2_COLOR,TEAM_GROVE3_COLOR,TEAM_GROVE4_COLOR,TEAM_GROVE5_COLOR,TEAM_GROVE6_COLOR,TEAM_GROVE7_COLOR,TEAM_GROVE8_COLOR,TEAM_GROVE9_COLOR,TEAM_GROVE10_COLOR);
			}
			if(gTeam[i] == 7)
			{
				CrimProxDetector(radardist, i,TEAM_VAGOS1_COLOR,TEAM_VAGOS2_COLOR,TEAM_VAGOS3_COLOR,TEAM_VAGOS4_COLOR,TEAM_VAGOS5_COLOR,TEAM_VAGOS6_COLOR,TEAM_VAGOS7_COLOR,TEAM_VAGOS8_COLOR,TEAM_VAGOS9_COLOR,TEAM_VAGOS10_COLOR);
			}
			if(gTeam[i] == 8)
			{
				CrimProxDetector(radardist, i,TEAM_AZTECAS1_COLOR,TEAM_AZTECAS2_COLOR,TEAM_AZTECAS3_COLOR,TEAM_AZTECAS4_COLOR,TEAM_AZTECAS5_COLOR,TEAM_AZTECAS6_COLOR,TEAM_AZTECAS7_COLOR,TEAM_AZTECAS8_COLOR,TEAM_AZTECAS9_COLOR,TEAM_AZTECAS10_COLOR);
			}
			if(gTeam[i] == 9)
			{
				CrimProxDetector(radardist, i,TEAM_NANG1_COLOR,TEAM_NANG2_COLOR,TEAM_NANG3_COLOR,TEAM_NANG4_COLOR,TEAM_NANG5_COLOR,TEAM_NANG6_COLOR,TEAM_NANG7_COLOR,TEAM_NANG8_COLOR,TEAM_NANG9_COLOR,TEAM_NANG10_COLOR);
			}
			if(gTeam[i] == 78)
			{
				CrimProxDetector(radardist, i,TEAM_RIFA1_COLOR,TEAM_RIFA2_COLOR,TEAM_RIFA3_COLOR,TEAM_RIFA4_COLOR,TEAM_RIFA5_COLOR,TEAM_RIFA6_COLOR,TEAM_RIFA7_COLOR,TEAM_RIFA8_COLOR,TEAM_RIFA9_COLOR,TEAM_RIFA10_COLOR);
			}
			if(gTeam[i] == 11)
			{
				CrimProxDetector(radardist, i,TEAM_MAFIA1_COLOR,TEAM_MAFIA2_COLOR,TEAM_MAFIA3_COLOR,TEAM_MAFIA4_COLOR,TEAM_MAFIA5_COLOR,TEAM_MAFIA6_COLOR,TEAM_MAFIA7_COLOR,TEAM_MAFIA8_COLOR,TEAM_MAFIA9_COLOR,TEAM_MAFIA10_COLOR);
			}
			if(gTeam[i] == 12)
			{
				CrimProxDetector(radardist, i,TEAM_RMAFIA1_COLOR,TEAM_RMAFIA2_COLOR,TEAM_RMAFIA3_COLOR,TEAM_RMAFIA4_COLOR,TEAM_RMAFIA5_COLOR,TEAM_RMAFIA6_COLOR,TEAM_RMAFIA7_COLOR,TEAM_RMAFIA8_COLOR,TEAM_RMAFIA9_COLOR,TEAM_RMAFIA10_COLOR);
			}
			if(gTeam[i] == 13)
			{
				CrimProxDetector(radardist, i,TEAM_TRIADS1_COLOR,TEAM_TRIADS2_COLOR,TEAM_TRIADS3_COLOR,TEAM_TRIADS4_COLOR,TEAM_TRIADS5_COLOR,TEAM_TRIADS6_COLOR,TEAM_TRIADS7_COLOR,TEAM_TRIADS8_COLOR,TEAM_TRIADS9_COLOR,TEAM_TRIADS10_COLOR);
			}
			if(gTeam[i] == 14)
			{
				CrimProxDetector(radardist, i,TEAM_BIKERS1_COLOR,TEAM_BIKERS2_COLOR,TEAM_BIKERS3_COLOR,TEAM_BIKERS4_COLOR,TEAM_BIKERS5_COLOR,TEAM_BIKERS6_COLOR,TEAM_BIKERS7_COLOR,TEAM_BIKERS8_COLOR,TEAM_BIKERS9_COLOR,TEAM_BIKERS10_COLOR);
			}
		}
	}
}

public Spectator()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			if(TVMode[i] >= 1 && TVMode[i] <= 5)
			{
				Unspec[i][sCam] = 2;
				TVMode[i]++;
				BestPlayer(i);
			}
			if(TVMode[i] >= 6 && TVMode[i] <= 9)
			{
				Unspec[i][sCam] = 3;
				TVMode[i]++;
				BestPlayer(i);
			}
			if(TVMode[i] == 10)
			{
				TVMode[i] = 1;
				BestPlayer(i);
				Unspec[i][sCam] = random(4);
			}
			if(TVMode[i] >= 11 && TVMode[i] <= 15)
			{
				DMPlayer(i);
				Unspec[i][sCam] = 2;
				TVMode[i]++;
			}
			if(TVMode[i] >= 16 && TVMode[i] <= 19)
			{
				DMPlayer(i);
				Unspec[i][sCam] = 3;
				TVMode[i]++;
			}
			if(TVMode[i] == 20)
			{
				DMPlayer(i);
				TVMode[i] = 11;
				Unspec[i][sCam] = random(4);
			}
			if(TVMode[i] >= 21 && TVMode[i] <= 25)
			{
				RaceSpec(i);
				Unspec[i][sCam] = 2;
				TVMode[i]++;
			}
			if(TVMode[i] >= 26 && TVMode[i] <= 29)
			{
				RaceSpec(i);
				Unspec[i][sCam] = 3;
				TVMode[i]++;
			}
			if(TVMode[i] == 30)
			{
				RaceSpec(i);
				TVMode[i] = 21;
				Unspec[i][sCam] = random(4);
			}
			if(TVMode[i] >= 31 && TVMode[i] <= 35)
			{
				PenDelay(i);
				Unspec[i][sCam] = 2;
				TVMode[i]++;
			}
			if(TVMode[i] >= 36 && TVMode[i] <= 39)
			{
				PenDelay(i);
				Unspec[i][sCam] = 3;
				TVMode[i]++;
			}
			if(TVMode[i] == 40)
			{
				PenDelay(i);
				TVMode[i] = 31;
				Unspec[i][sCam] = random(4);
			}
			if(TVMode[i] >= 41 && TVMode[i] <= 45)
			{
				SpeedDelay(i);
				Unspec[i][sCam] = 2;
				TVMode[i]++;
			}
			if(TVMode[i] >= 46 && TVMode[i] <= 49)
			{
				SpeedDelay(i);
				Unspec[i][sCam] = 3;
				TVMode[i]++;
			}
			if(TVMode[i] == 50)
			{
				SpeedDelay(i);
				TVMode[i] = 41;
				Unspec[i][sCam] = random(4);
			}
			if(IsPlayerConnected(Spectate[i]) && Spectate[i] != -1)
			{
				SetPlayerColor(i,COLOR_SPEC);
				TogglePlayerControllable(i, 0);
				new hight;
				new targetid = Spectate[i];
				new Float:px, Float:py, Float:pz, Float:pa;
				if(specflick == 1)
				{
					GetPlayerPos(targetid, CarTracking[i][0], CarTracking[i][1], CarTracking[i][2]);
				}
				px = CarTracking[i][0];py = CarTracking[i][1];pz = CarTracking[i][2];
				if(PlayerInfo[targetid][pInt] == 0)
				{
					SetPlayerInterior(i,0);
				}
				if(PlayerInfo[targetid][pInt] > 0)
				{
					SetPlayerInterior(i,PlayerInfo[targetid][pInt]);
				}
				if(pz > 530.0 && PlayerInfo[targetid][pInt] == 0) //the highest land point in sa = 526.8
				{
					SetPlayerInterior(i,1);
				}
				if(Unspec[i][sCam] <= 1 &&  Unspec[i][sCam] != 10)
				{
					if(GetPlayerState(targetid) != 1)
					{
						SetPlayerCameraPos(i,px,py,pz+40);
					}
					else
					{
						SetPlayerCameraPos(i,px,py,pz+10);
					}
					SetPlayerPos(i, px, py, pz+110);
				}
				else if(Unspec[i][sCam] >= 2 && Unspec[i][sCam] <= 3)
				{
					new dist;
					if(Unspec[i][sCam] == 2)
					{
						if(GetPlayerState(targetid) != 1)
						{
							dist = 6;
							hight = 2;
						}
						else
						{
							dist = 6;
							hight = 1;
						}
					}
					if(Unspec[i][sCam] == 3)
					{
						if(GetPlayerState(targetid) != 1)
						{
							dist = -50;
							hight = 4;
						}
						else
						{
							dist = -10;
							hight = 2;
						}
					}
					if(GetPlayerState(targetid) != 1)
					{
						if(specflick == 2)
						{
							new Float:px2, Float:py2, Float:pz2, Float:tpx,Float:tpy;
							GetPlayerPos(targetid, px2, py2, pz2);
							if(py2 > py && px2 > px)
							{
								tpx = px2-px;
								tpy = py2-py;
								if(tpy > tpx)
								{
									if(tpy-tpx > 10.0)
									{
										CarTracking[i][3] = 0.0;
									}
									else
									{
										CarTracking[i][3] = 315.0;
									}
								}
								if(tpy < tpx)
								{
									if(tpx-tpy > 10.0)
									{
										CarTracking[i][3] = 270.0;
									}
									else
									{
										CarTracking[i][3] = 315.0;
									}
								}
							}
							if(py2 < py && px2 > px)
							{
								tpx = px2-px;
								tpy = py-py2;
								if(tpy > tpx)
								{
									if(tpy-tpx > 10.0)
									{
										CarTracking[i][3] = 180.0;
									}
									else
									{
										CarTracking[i][3] = 225.0;
									}
								}
								if(tpy < tpx)
								{
									if(tpx-tpy > 10.0)
									{
										CarTracking[i][3] = 270.0;
									}
									else
									{
										CarTracking[i][3] = 225.0;
									}
								}
							}
							if(py2 < py && px2 < px)
							{
								tpx = px-px2;
								tpy = py-py2;
								if(tpy > tpx)
								{
									if(tpy-tpx > 10.0)
									{
										CarTracking[i][3] = 180.0;
									}
									else
									{
										CarTracking[i][3] = 135.0;
									}
								}
								if(tpy < tpx)
								{
									if(tpx-tpy > 10.0)
									{
										CarTracking[i][3] = 90.0;
									}
									else
									{
										CarTracking[i][3] = 135.0;
									}
								}
							}
							if(py2 > py && px2 < px)
							{
								tpx = px-px2;
								tpy = py2-py;
								if(tpy > tpx)
								{
									if(tpy-tpx > 10.0)
									{
										CarTracking[i][3] = 0.0;
									}
									else
									{
										CarTracking[i][3] = 45.0;
									}
								}
								if(tpy < tpx)
								{
									if(tpx-tpy > 10.0)
									{
										CarTracking[i][3] = 90.0;
									}
									else
									{
										CarTracking[i][3] = 45.0;
									}
								}
							}
							specflick = 0;
						}
						pa = CarTracking[i][3];
						//	new formated[256];
						//	format(formated, sizeof(formated), "Debug:CarAngle (%f)",CarTracking[i][3]);
						//	SendClientMessageToAllRus(COLOR_WHITE, formated);
					}
					else
					{
						GetPlayerFacingAngle(targetid,pa);
					}
					if(pa >= 0.0 && pa <= 22.5) //n1
					{
						SetPlayerCameraPos(i, px, py-(dist), pz+hight);
					}
					if(pa >= 332.5 && pa < 0.0) //n2
					{
						SetPlayerCameraPos(i, px, py-(dist), pz+hight);
					}
					if(pa >= 22.5 && pa <= 67.5) //nw
					{
						SetPlayerCameraPos(i, px+(dist/2), py-(dist/2), pz+hight);
					}
					if(pa >= 67.5 && pa <= 112.5) //w
					{
						SetPlayerCameraPos(i, px+(dist), py, pz+hight);
					}
					if(pa >= 112.5 && pa <= 157.5) //sw
					{
						SetPlayerCameraPos(i, px+(dist/2), py+(dist/2), pz+hight);
					}
					if(pa >= 157.5 && pa <= 202.5) //s
					{
						SetPlayerCameraPos(i, px, py+(dist), pz+hight);
					}
					if(pa >= 202.5 && pa <= 247.5)//se
					{
						SetPlayerCameraPos(i, px-(dist/2), py+(dist/2), pz+hight);
					}
					if(pa >= 247.5 && pa <= 292.5)//e
					{
						SetPlayerCameraPos(i, px-(dist), py, pz+hight);
					}
					if(pa >= 292.5 && pa <= 332.5)//e
					{
						SetPlayerCameraPos(i, px-(dist/2), py-(dist/2), pz+hight);
					}
					SetPlayerPos(i, px, py, pz+110);
				}
				else if(Unspec[i][sCam] == 5)
				{
					SetPlayerPos(i, px, py, pz+40);
				}
				else if(Unspec[i][sCam] == 6)
				{
					SetPlayerPos(i, rsx, rsy, rsz+100);
					SetPlayerCameraPos(i, rsx, rsy+4, rsz+2);
				}
				else if(Unspec[i][sCam] == 7)
				{
					SetPlayerPos(i, rmx, rmy, rmz+100);
					SetPlayerCameraPos(i, rmx, rmy+4, rmz+2);
				}
				else if(Unspec[i][sCam] == 8)
				{
					SetPlayerPos(i, rm2x, rm2y, rm2z+100);
					SetPlayerCameraPos(i, rm2x, rm2y+4, rm2z+2);
				}
				else if(Unspec[i][sCam] == 9)
				{
					SetPlayerPos(i, rex, rey, rez+100);
					SetPlayerCameraPos(i, rex, rey+4, rez+2);
				}
				else if(Unspec[i][sCam] == 10)
				{
					new house = Unspec[i][sLocal];
					SetPlayerPos(i,HouseInfo[house][hEntrancex], HouseInfo[house][hEntrancey],HouseInfo[house][hEntrancez]+100);
					SetPlayerCameraPos(i, HouseInfo[house][hEntrancex], HouseInfo[house][hEntrancey],HouseInfo[house][hEntrancez]+2.0);
					SetPlayerInterior(i,0);
				}
				SetPlayerCameraLookAt(i,px,py,pz);
			}
		}
	}
	if(specflick < 2)
	{
		specflick++;
	}
	else
	{
		specflick = 0;
	}
}

//------------------------------------------------------------------------------------------------------

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if (gdebug >= 1){printf("DEBUG OnPlayerEnterVehicle(%d, %d, %d)", playerid, vehicleid, ispassenger);}
	if(gTeam[playerid] == TEAM_GREEN)
	{
		if (IsACopCar(vehicleid) && !ispassenger)
		{
			SetPlayerCriminal(playerid,-1, "Stealing A Police Vehicle",0,0);
			if(FlashTime[playerid] == 0){FlashTime[playerid] = 10;}
		}
		if (IsAnAmbulance(vehicleid) && !ispassenger)
		{
			SetPlayerCriminal(playerid,-1, "Stealing An Ambulance",0,0);
			if(FlashTime[playerid] == 0){FlashTime[playerid] = 10;}
		}
	}
	return 1;
}

public IsAPlane(carid)
{
	if((carid >= 66 && carid <=71) || carid == 60)
	{
		return 1;
	}
	return 0;
}

public IsACopCar(carid)
{
	if((carid >= 35) && (carid <= 60))
	{
		return 1;
	}
	return 0;
}

public IsAnAmbulance(carid)
{
	if((carid >= 61) && (carid <= 63))
	{
		return 1;
	}
	return 0;
}

public IsATruck(carid)
{
	if(carid >= 78 && carid <= 81)
	{
		return 1;
	}
	return 0;
}

//------------------------------------------------------------------------------------------------------

public OnPlayerConnect(playerid)
{
	if (gdebug >= 1){printf("DEBUG OnPlayerConnect(%d)", playerid);}
	gActivePlayers[playerid]++;
	numplayers++;
	new plname[MAX_PLAYER_NAME];
	new string[MAX_PLAYER_NAME];
	//TelePos[playerid][0] = 0;
	//TelePos[playerid][1] = 0;
	//TelePos[playerid][2] = 0;
	SafeTime[playerid] = 60;
	BetRace[playerid][0] = -1;
	BetRace[playerid][1] = 0;
	BetDm[playerid][0] = -1;
	BetDm[playerid][1] = 0;
	HidePM[playerid] = 0;
	gPlayerFighter[playerid] = 0;
	DmScore[playerid] = 0;
	Mobile[playerid] = -1;
	Spectate[playerid] = -1;
	Unspec[playerid][sLocal] = -1;
    gSkyDive[playerid] = 0;
	TVMode[playerid] = 0;
    gLastCar[playerid] = 0;
    FirstSpawn[playerid] = 0;
	gPlayerLapStatus[playerid] = 0;
	gOoc[playerid] = 0;
	BigEar[playerid] = 0;
	FlashTime[playerid] = 0;
	gDice[playerid] = 0;
	gSpeedo[playerid] = 0;
	gPlayerLogged[playerid] = 0;
	gPlayerAccount[playerid] = 0;
	gPlayerSpawned[playerid] = 0;
	LapCount[playerid] = 0;
	Mute[playerid] = 0;
	StartTime[playerid] = 0;
	gRaceGuy[playerid] = 0;
	Contract[playerid] = 0;
	gPlayerMission[playerid] = 0;
	PlayerInfo[playerid][pCash] = dollah;
	KickVote[playerid] = 0;
	VoteKick[playerid] = 0;
	LastVote[playerid] = -1;
	HireCar[playerid] = -1;
	Hidden[playerid] = 0;
	Locator[playerid] = 0;
	PLicence[playerid] = 0;
	gPhoneBook[playerid] = 0;
	//PlayerPos[playerid][3] = 1.0;
	//PlayerPos[playerid][4] = 1.0;
	//PlayerPos[playerid][5] = 1.0;
	SafeGivePlayerMoney(playerid,PlayerInfo[playerid][pCash]);
	PlayerInfo[playerid][pAccount] = 0;
	PlayerInfo[playerid][pAdmin] = 0;
	PlayerInfo[playerid][pLevel] = 1;
	PlayerInfo[playerid][pExp] = 0;
	PlayerInfo[playerid][gPupgrade] = 0;
	PlayerInfo[playerid][pKills] = 0;
	PlayerInfo[playerid][pCB] = 0;
	PlayerInfo[playerid][pHW] = 0;
	PlayerInfo[playerid][pSR] = 0;
	PlayerInfo[playerid][pWA] = 0;
	PlayerInfo[playerid][pPEN] = 0;
	PlayerInfo[playerid][pGun1] = 0;
	PlayerInfo[playerid][pGun2] = 0;
	PlayerInfo[playerid][pGun3] = 0;
	PlayerInfo[playerid][pGun4] = 0;
	PlayerInfo[playerid][pGun5] = 0;
	PlayerInfo[playerid][pGun6] = 0;
	PlayerInfo[playerid][pAmmo1] = 200;
	PlayerInfo[playerid][pAmmo2] = 8;
	PlayerInfo[playerid][pAmmo3] = 30;
	PlayerInfo[playerid][pAmmo4] = 30;
	PlayerInfo[playerid][pAmmo5] = 10;
	PlayerInfo[playerid][pAmmo6] = 10;
	PlayerInfo[playerid][pSHealth] = 0.0;
	PlayerInfo[playerid][pHealth] = 50.0;
	PlayerInfo[playerid][pPos_x] = 2246.6;
	PlayerInfo[playerid][pPos_y] = -1161.9;
	PlayerInfo[playerid][pPos_z] = 1029.7;
	PlayerInfo[playerid][pInt] = 15;
	PlayerInfo[playerid][pLocal] = -1;
	PlayerInfo[playerid][pTeam] = 1;
	PlayerInfo[playerid][pModel] = 264;
	new randphone = 1000 + random(8999);//minimum 1000  max 9999 //giving one at the start
	PlayerInfo[playerid][pPnumber] = randphone;
	PlayerInfo[playerid][pPhousekey] = -1;
	PlayerInfo[playerid][pPbiskey] = -1;
	ClearCrime(playerid);
	printf("Player Connecting as (%d)", playerid);
	SetPlayerColor(playerid,COLOR_GRAD2);
	GetPlayerName(playerid, plname, sizeof(plname));
	//SetPlayerCameraPos(playerid,1460.0, -1324.0, 287.2);
	//SetPlayerCameraLookAt(playerid,1374.5, -1291.1, 239.0);
	SendClientMessage(playerid, 0x00000000, " "); SendClientMessage(playerid, 0x00000000, " "); SendClientMessage(playerid, 0x00000000, " "); SendClientMessage(playerid, 0x00000000, " "); SendClientMessage(playerid, 0x00000000, " ");
	SendClientMessage(playerid, COLOR_YELLOW, "Добро пожаловать на сервер Public Enemy: LS. Подробная информация: /about");
	format(string, sizeof(string), "%s.cer", plname);
	if(fexist(string))
	{
		gPlayerAccount[playerid] = 1;
		SendClientMessageRus(playerid, COLOR_YELLOW, "СЕРВЕР: Этот ник зарегистрирован, у вас 60 секунд, чтобы авторизоваться");
		SendClientMessageRus(playerid, COLOR_WHITE, "ПОДСКАЗКА: Чтобы войти введите /login <password>");
	}
	else
	{
		gPlayerAccount[playerid] = 0;
		SendClientMessageRus(playerid, COLOR_YELLOW, "СЕРВЕР: Введите /regnick <password> чтобы зарегистрироваться или /help для помощи");
	}
	return 1;
}

public ClearCrime(playerid)
{
	if (gdebug >= 1){printf("DEBUG ClearCrime(%d)", playerid);}
	new string[MAX_PLAYER_NAME];
	format(string, sizeof(string), "********");
	strmid(PlayerCrime[playerid][pBplayer], string, 0, strlen(string), 255);
	strmid(PlayerCrime[playerid][pVictim], string, 0, strlen(string), 255);
	strmid(PlayerCrime[playerid][pAccusing], string, 0, strlen(string), 255);
	strmid(PlayerCrime[playerid][pAccusedof], string, 0, strlen(string), 255);
	return 1;
}

public BetWinner(playerid,contest)
{
	new winname[MAX_PLAYER_NAME];
	new better[MAX_PLAYER_NAME];
	new string[256];
	GetPlayerName(playerid, winname, sizeof(winname));
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			if(contest == 1)
			{
				if(BetRace[i][0] == playerid)
				{
					SafeGivePlayerMoney(i,BetRace[i][1]*2);
					BizzInfo[5][bTakings] -= (BetRace[i][1]*2);
					format(string, sizeof(string), "______-= %s =-_______", BizzInfo[5][bDiscription]);
					SendClientMessageRus(i, TEAM_VAGOS_COLOR,string);
					format(string, sizeof(string), "Вы выйграли $%d на победе %s в гонке", BetRace[i][1]*2, winname);
					SendClientMessageRus(i, COLOR_WHITE, string);
					SendClientMessageRus(i, TEAM_VAGOS_COLOR,"_______________________________________");
					PlayerPlaySound(i, 1052, 0.0, 0.0, 0.0);
					GetPlayerName(i, better, sizeof(better));
					format(string, sizeof(string), "%s выйграл $%d на победе %s", better, BetRace[i][1]*2, winname);
					printf("%s", string);
					PayLog(string);
				}
				BetRace[i][0] = -1;
				BetRace[i][1] = 0;
			}
			if(contest == 2)
			{
				if(BetDm[i][0] == playerid)
				{
					SafeGivePlayerMoney(i,BetDm[i][1]*2);
					BizzInfo[5][bTakings] -= (BetDm[i][1]*2);
					format(string, sizeof(string), "______-= %s =-_______", BizzInfo[5][bDiscription]);
					SendClientMessageRus(i, TEAM_VAGOS_COLOR,string);
					format(string, sizeof(string), "Вы выйграли $%d на победе %s в дезматче", BetDm[i][1]*2, winname);
					SendClientMessageRus(i, COLOR_WHITE, string);
					SendClientMessageRus(i, TEAM_VAGOS_COLOR,"_______________________________________");
					PlayerPlaySound(i, 1052, 0.0, 0.0, 0.0);
					GetPlayerName(i, better, sizeof(better));
					format(string, sizeof(string), "%s выйграл $%d на победе %s", better, BetDm[i][1]*2, winname);
					printf("%s", string);
					PayLog(string);
				}
				BetDm[i][0] = -1;
				BetDm[i][1] = 0;
			}
		}
	}
	return 1;
}

//------------------------------------------------------------------------------------------------------
public OnPlayerDisconnect(playerid)
{
//if (gdebug >= 1){printf("DEBUG OnPlayerDisconnect(%d)", playerid);}
	printf("DEBUG OnPlayerDisconnect(%d)1", playerid);
	gActivePlayers[playerid]--;
	numplayers--;
	if (DmHiPlayer == playerid)
	{
		DmHiPlayer = -1;
		new tmp1;
		new tmp2;
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(DmScore[i] > tmp1 && IsPlayerConnected(i) == 1)
			{
				DmScore[i] = tmp1;
				i = tmp2;
			}
		}
		if(DmHiPlayer != -1)
		{
			DmHiPlayer = tmp2;
			new dmname[MAX_PLAYER_NAME];
			new string[256];
			GetPlayerName(DmHiPlayer, dmname, sizeof(dmname));
			DmHiScore = DmScore[DmHiPlayer];
			format(string, sizeof(string), "НОВОСТИ ДМ: %s лидирует с %d убийствами", dmname,DmHiScore);
			BroadCast(COLOR_WHITE, string);
		}
	}
	if (gPublicEnemy == playerid)
	{
		gPublicEnemy = -1;
		SafeGivePlayerMoney(playerid, -reward);
		KillTimer(offhook);
	}
	PlayerUpdate(playerid);
	printf("DEBUG OnPlayerDisconnect(%d)2", playerid);
	if(HireCar[playerid] != -1)
	{
		gLastDriver[HireCar[playerid]] = -1;
		gCarLock[HireCar[playerid]] = 0;
		UnLockCar(HireCar[playerid]);
	}
	if (gLastCar[playerid] > 0)
	{
		gLastDriver[gLastCar[playerid]] = -1;
		if(PlayerInfo[playerid][pPhousekey] != gLastCar[playerid]-1)
		{
			gCarLock[gLastCar[playerid]] = 0;
			UnLockCar(gLastCar[playerid]);
		}
	}
	printf("DEBUG OnPlayerDisconnect(%d)3", playerid);
	if (gPlayerCheckpointStatus[playerid] == CHECKPOINT_DROPOFF)
	{
		DisablePlayerCheckpoint(playerid);
		gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
		MissionActive = 0;
		if (gdebug){print("DEBUG MissionActive = 0;");}
	}
	if (gSuperCop == playerid)
	{
		gSuperCop = -1;
	}
}

public SetPlayerRandomSpawn(playerid)
{
	new rand;
	new playername[MAX_PLAYER_NAME];
	new house = PlayerInfo[playerid][pPhousekey];
	GetPlayerName(playerid, playername, sizeof(playername));
	if(gPlayerFighter[playerid] == 1)
    {
		new string[256];
		gTeam[playerid] = 4;
		SetPlayerToTeamColor(playerid);
		rand = random(sizeof(gRandomDMSpawns)-2)+1;
		SetPlayerPos(playerid, gRandomDMSpawns[rand][0], gRandomDMSpawns[rand][1], gRandomDMSpawns[rand][2]); // Warp the player
		SetPlayerFacingAngle(playerid, 270.0);
		SetPlayerInterior(playerid,0);
		PlayerInfo[playerid][pInt] = 0;
		format(string, sizeof(string), "~r~%d~w~|~g~%d",DmScore[playerid],DmHiScore);
		GameTextForPlayerRus(playerid, string, 5000, 6);
		if(gFightLeader < 1000)
		{
			TogglePlayerControllable(playerid, 0);
		}
		if (gdebug >=0){printf("DEBUG SPAWNED: Playerid:%d Team:%d DMPoint:%d", playerid, gTeam[playerid], rand);}
		return 1;
	}
	if(house !=-1)
	{
		/*
		if(gTeam[playerid] <= 2 && strcmp(playername, HouseInfo[house][hOwner], true) == 0 || gTeam[playerid] > 2)
		{
			*/
			SetPlayerToTeamColor(playerid);
			SetPlayerInterior(playerid,HouseInfo[house][hInt]);
			SetPlayerPos(playerid, HouseInfo[house][hExitx], HouseInfo[house][hExity],HouseInfo[house][hExitz]); // Warp the player
			PlayerInfo[playerid][pLocal] = house;
			PlayerInfo[playerid][pInt] = HouseInfo[house][hInt];
			if (gdebug >=1){printf("DEBUG SPAWNED: Playerid:%d Team:%d SpawnPoint:%d", playerid, gTeam[playerid], rand);}
			return 1;
		//}

	}
	if ((gTeam[playerid]) == 2)
	{
		SetPlayerToTeamColor(playerid);
		rand = random(sizeof(gCopPlayerSpawns));
		SetPlayerPos(playerid, gCopPlayerSpawns[rand][0], gCopPlayerSpawns[rand][1], gCopPlayerSpawns[rand][2]); // Warp the player
		SetPlayerFacingAngle(playerid, 270.0);
		SetPlayerInterior(playerid,0);
		PlayerInfo[playerid][pInt] = 0;
		if (gdebug >=1){printf("DEBUG SPAWNED: Playerid:%d Team:%d SpawnPoint:%d", playerid, gTeam[playerid], rand);}
		return 1;
    }
    if ((gTeam[playerid]) == 1)
    {
		SetPlayerToTeamColor(playerid);
		rand = random(sizeof(gMedPlayerSpawns));
		SetPlayerPos(playerid, gMedPlayerSpawns[rand][0], gMedPlayerSpawns[rand][1], gMedPlayerSpawns[rand][2]); // Warp the player
		SetPlayerFacingAngle(playerid, 270.0);
		SetPlayerInterior(playerid,0);
		PlayerInfo[playerid][pInt] = 0;
		if (gdebug >=1){printf("DEBUG SPAWNED: Playerid:%d Team:%d SpawnPoint:%d", playerid, gTeam[playerid], rand);}
		return 1;
	}
    else
    {
		SetPlayerToTeamColor(playerid);
		rand = random(sizeof(gRandomPlayerSpawns));
		SetPlayerPos(playerid, gRandomPlayerSpawns[rand][0], gRandomPlayerSpawns[rand][1], gRandomPlayerSpawns[rand][2]); // Warp the player
		SetPlayerFacingAngle(playerid, 270.0);
		SetPlayerInterior(playerid,15);
		SetPlayerVirtualWorld(playerid, 1);
		if (gdebug >=1){printf("DEBUG SPAWNED: Playerid:%d Team:%d SpawnPoint:%d", playerid, gTeam[playerid], rand);}
		return 1;
	}
//	return 1;
}

//------------------------------------------------------------------------------------------------------

public OnPlayerDeath(playerid, killerid, reason)
{
	if (gdebug >=0){
		printf("OnPlayerDeath Playerid:%d killerid:%d reason:%d", playerid, killerid, reason);
	}
	new name[MAX_PLAYER_NAME];
	new string[256];
	new dmessage[128];
	new deathreason[24];
	new playercash;
	new victimteam;
	new Float:px,Float:py,Float:pz;
	//new killerteam;
	victimteam = (gTeam[playerid]);
	//killerteam = (gTeam[killerid]);
	gPlayerSpawned[playerid] = 0;
	GetPlayerName(playerid, name, sizeof(name));
	PlayerInfo[playerid][pLocal] = -1;
	GetPlayerPos(playerid, px, py, pz);
	new sgun, sammo;
	
	if(killerid != INVALID_PLAYER_ID)
	{
		if(GetPlayerState(killerid) == 2 && playerid != gPublicEnemy)
		{
			SendClientMessageRus(killerid, COLOR_YELLOW, "Мочи из тачки, бей всех в мурло, но если замочишь пешим - получишь в придачу бабло.");
			return 1;
		}
	}
	SendDeathMessage(killerid, playerid, reason);
	if( killerid != INVALID_PLAYER_ID)
	{
		if (PlayerInfo[killerid][pAdmin] < 1)
		{
			if(reason == 38)
			{
				if(gPlayerFighter[playerid] != 1)
				{
					new kickname[MAX_PLAYER_NAME];
					if(IsPlayerConnected(killerid))
					{
                    	GetPlayerWeaponData(killerid, 7, sgun, sammo);
                    	if(sgun == reason && sammo > 0)
                    	{
    						GetPlayerName(killerid, kickname, sizeof(kickname));
							format(string, 256, "AdmWarning: [%d]%s только что убил игрока [%d]%s из Минигана и был забанен по IP.",killerid,kickname, playerid, name);
							ABroadCast(0xFF000000,string,1);
							Ban(killerid);
							return 1;
						}
						else
		 				{
							GetPlayerName(killerid, kickname, sizeof(kickname));
							format(string, 256, "AdmWarning: [%d]%s пытался подставить игрока [%d]%s используя чит и был кикнут.",playerid,name, killerid, kickname);
							ABroadCast(0xFF000000,string,1);
							Kick(playerid);
							return 1;
		 				}
					}
				}
			}
			if(reason == 35)
			{
				if(gPlayerFighter[playerid] != 1)
				{
					new kickname[MAX_PLAYER_NAME];
					if(IsPlayerConnected(killerid))
					{
						GetPlayerWeaponData(killerid, 7, sgun, sammo);
						if(sgun == reason && sammo > 0)
						{
							GetPlayerName(killerid, kickname, sizeof(kickname));
							format(string, 256, "AdmWarning: [%d]%s только что убил игрока [%d]%s из Огнемёта и был забанен по IP .",killerid,kickname, playerid, name);
							ABroadCast(0xFF000000,string,1);
							Ban(killerid);
							return 1;
						}
						else
		 				{
	                        GetPlayerName(killerid, kickname, sizeof(kickname));
							format(string, 256, "AdmWarning: [%d]%s пытался подставить игрока [%d]%s используя чит и был кикнут.",playerid,name, killerid, kickname);
							ABroadCast(0xFF000000,string,1);
							Kick(playerid);
							return 1;
		 				}
					}
				}
			}
			if(reason == 9)
			{
				if(gPlayerFighter[playerid] != 1)
				{
					new kickname[MAX_PLAYER_NAME];
					if(IsPlayerConnected(killerid))
					{
	                    GetPlayerWeaponData(killerid, 1, sgun, sammo);
	                    if(sgun == reason && sammo > 0)
	                    {
							GetPlayerName(killerid, kickname, sizeof(kickname));
							format(string, 256, "AdmWarning: [%d]%s только что убил игрока [%d]%s Бензопилой и был забанен по IP.",killerid,kickname, playerid, name);
							ABroadCast(0xFF000000,string,1);
							Ban(killerid);
							return 1;
						}
						else
		 				{
	                        GetPlayerName(killerid, kickname, sizeof(kickname));
							format(string, 256, "AdmWarning: [%d]%s пытался подставить игрока [%d]%s используя чит и был кикнут.",playerid,name, killerid, kickname);
							ABroadCast(0xFF000000,string,1);
							Kick(playerid);
							return 1;
		 				}
					}
				}
			}
			if(reason == 18)
			{
				if(gPlayerFighter[playerid] != 1)
				{
					new kickname[MAX_PLAYER_NAME];
					if(IsPlayerConnected(killerid))
					{
						GetPlayerWeaponData(killerid, 8, sgun, sammo);
						if(sgun == reason && sammo > 0)
						{
							GetPlayerName(killerid, kickname, sizeof(kickname));
							format(string, 256, "AdmWarning: [%d]%s только что убил игрока [%d]%s Молотовым и был забанен по IP.",killerid,kickname, playerid, name);
							ABroadCast(0xFF000000,string,1);
							Ban(killerid);
							return 1;
						}
						else
		 				{
    	                    GetPlayerName(killerid, kickname, sizeof(kickname));
							format(string, 256, "AdmWarning: [%d]%s пытался подставить игрока [%d]%s используя чит и был кикнут.",playerid,name, killerid, kickname);
							ABroadCast(0xFF000000,string,1);
							Kick(playerid);
							return 1;
		 				}
					}
				}
			}
			if(reason == 36)
			{
				if(gPlayerFighter[playerid] != 1)
				{
    				new kickname[MAX_PLAYER_NAME];
					if(IsPlayerConnected(killerid))
					{
                	    GetPlayerWeaponData(killerid, 7, sgun, sammo);
                	    if(sgun == reason && sammo > 0)
                	    {
							GetPlayerName(killerid, kickname, sizeof(kickname));
							format(string, 256, "AdmWarning: [%d]%s только что убил игрока [%d]%s из HS Rocket Launcher и был забанен по IP.",killerid,kickname, playerid, name);
							ABroadCast(0xFF000000,string,1);
							Ban(killerid);
							return 1;
						}
						else
	 					{
                	        GetPlayerName(killerid, kickname, sizeof(kickname));
							format(string, 256, "AdmWarning: [%d]%s пытался подставить игрока [%d]%s используя чит и был кикнут.",playerid,name, killerid, kickname);
							ABroadCast(0xFF000000,string,1);
							Kick(playerid);
							return 1;
		 				}
					}

				}
			}
		}
	}
	if(gPlayerFighter[playerid] == 1)
	{
		DmScore[playerid]--;
		if(killerid != INVALID_PLAYER_ID)
		{
			DmScore[killerid]++;
			if(DmScore[killerid] > DmHiScore)
			{
				new dmname[MAX_PLAYER_NAME];
				GetPlayerName(killerid, dmname, sizeof(dmname));
				DmHiPlayer = killerid;
				DmHiScore = DmScore[killerid];
				format(string, sizeof(string), "НОВОСТИ ДМ: %s лидирует с %d убийствами", dmname,DmHiScore);
				BroadCast(COLOR_WHITE, string);
				format(string, sizeof(string), "~g~%d~w~|~g~%d",DmScore[killerid],DmHiScore);
			}
			else
			{
				format(string, sizeof(string), "~r~%d~w~|~g~%d",DmScore[killerid],DmHiScore);
			}
			GameTextForPlayerRus(killerid, string, 5000, 6);
		}
	}
	GetWeaponName(reason, deathreason, 20);
	format(dmessage, sizeof(dmessage), "You Got Pwned");
	if (strlen(deathreason) == 0)
	{
		format(deathreason, sizeof(deathreason), "Кулаки");
	}
	if (reason == 41)
	{
		format(deathreason, sizeof(deathreason), "Газовый баллончик");
	}
	if (gPlayerCheckpointStatus[playerid] == CHECKPOINT_DROPOFF)
	{
		if (gdebug){print("DEBUG test6");}
		DisablePlayerCheckpoint(playerid);
		gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
		new check;
		check = gPlayerCheckpointStatus[playerid];
		if (gdebug){printf("DEBUG check %d",check);}
		OnPlayerDropCashBox(playerid);
	}
	if (gPlayerCheckpointStatus[playerid] > 4 && gPlayerCheckpointStatus[playerid] < 11)
	{
		DisablePlayerCheckpoint(playerid);
		gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
		LapCount[playerid] = 0;
	}
	/*
	if((PlayerInfo[playerid][pPhousekey]+1 != gLastCar[playerid] && gLastCar[playerid] != 0) || HireCar[playerid] != gLastCar[playerid] && gLastCar[playerid] != 0)
	{
		printf("DEBUG PlayerInfo[playerid][pPhousekey](%d) gLastCar[playerid]-1(%d) HireCar[playerid](%d)", PlayerInfo[playerid][pPhousekey],gLastCar[playerid]-1,HireCar[playerid]);
		UnLockCar(gLastCar[playerid]);
		gCarLock[gLastCar[playerid]] = 0;
		gLastDriver[gLastCar[playerid]] = -1;
		gLastCar[playerid] = 0;
	}
	*/
	new caller = Mobile[playerid];
	if(caller != -1)
	{
		SendClientMessageRus(caller,  COLOR_GRAD2, "Связь прервалась....");
		CellTime[caller] = 0;
		CellTime[playerid] = 0;
		Mobile[caller] = -1;
		Mobile[playerid] = -1;
		CellTime[playerid] = 0;
	}
	ClearCrime(playerid);
	if (killerid == INVALID_PLAYER_ID)
	{
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && gTeam[i] != gTeam[playerid] && CrimInRange(20.0, playerid,i) && GetPlayerState(i) != 2)
			{
				killerid = i;
				format(deathreason, sizeof(deathreason), "Запугивание");
				break;
			}
		}
	}
	if (killerid == INVALID_PLAYER_ID)
	{
		if ((gTeam[playerid]) == 0){return 1;}
		new slice = ((PlayerInfo[playerid][pLevel]*deathcost)+(basedcost)); //1k +your level
		SafeGivePlayerMoney(playerid, -slice);
		format(string, sizeof(string), "ДОКТОР: Ваше лечение обошлось в $%d, удачного дня.", slice);
		SendClientMessageRus(playerid, TEAM_CYAN_COLOR, string);
		switch (reason)
		{
			case WEAPON_DROWN:
			{
				format(string, sizeof(string), ".: %s утонул :.", name);
				BroadCast(COLOR_RED, string);
				GameTextForPlayerRus(playerid, dmessage, 5000, 2);
			}
			case WEAPON_COLLISION:
			{
				format(string, sizeof(string), ".: %s разбился :.", name);
				BroadCast(COLOR_RED, string);
				GameTextForPlayerRus(playerid, dmessage, 5000, 2);
			}
			default:
			{
				/*
				if (strlen(deathreason) > 0)
				{
					format(string, sizeof(string), ".: %s died. (%s) :.", name, deathreason);
				}*/
			//	else
			//	{
				format(string, sizeof(string), ".: %s умер :.", name);
			//	}
				BroadCast(COLOR_RED, string);
				GameTextForPlayerRus(playerid, dmessage, 5000, 2);
			}
		}
		if (gTeam[playerid] == 4)
		{
			gTeam[playerid] = PlayerInfo[playerid][pTeam];
		}
		if (gPublicEnemy == playerid)
		{
			if(killerid == INVALID_PLAYER_ID)
			{
				gPublicEnemy = -1;
				SafeGivePlayerMoney(playerid, -preward);
				format(string, sizeof(string), "SMS: %s, медики получили ваш последний выйгрыш $%d, Отправитель: MOLE (555)",name,preward);
				RingTone[playerid] = 20;
				SendClientMessageRus(playerid, COLOR_YELLOW, string);
				KillTimer(offhook);
				new tmpmed;
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i) == 1 && gTeam[i] == TEAM_CYAN)
					{
						tmpmed++;
					}
				}
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i) == 1 && gTeam[i] == TEAM_CYAN)
					{
						SafeGivePlayerMoney(i, preward/tmpmed);
					}
				}
			}
		}
		return 1;
	}
	if (Contract[playerid] > 0)
	{
		new killer[MAX_PLAYER_NAME];
		GetPlayerName(killerid, killer, sizeof(killer));
		SafeGivePlayerMoney(killerid, Contract[playerid]);
		format(string,128,"<< %s выполнил контракт на %s и заработал $%d >>",killer,name,Contract[playerid]);
		BroadCast(COLOR_YELLOW, string);
		PayLog(string);
		Contract[playerid] = 0;
	}
	if (victimteam >= 4)
	{
		new killer[MAX_PLAYER_NAME];
		GetPlayerName(killerid, killer, sizeof(killer));
		new slice = ((PlayerInfo[playerid][pLevel]*deathcost)+(basedcost)); //1k +your level
		playercash = GetPlayerMoney(playerid);
		if(SafeTime[playerid] <= 0 || gPlayerFighter[playerid] == 1)
		{
			if(gTeam[killerid] != gTeam[playerid])
			{
				if(GetPlayerState(killerid) == 1)
				{
					PlayerInfo[killerid][pKills] = PlayerInfo[killerid][pKills]+2;
				}
				else
				{
					PlayerInfo[killerid][pKills]++;
				}
				PlayerInfo[playerid][pKills]--;
				if(PlayerInfo[killerid][pKills] >= 30)
				{
					PlayerInfo[killerid][pExp]++;
					PlayerInfo[killerid][pKills] = 0;
					SendClientMessageRus(killerid, COLOR_YELLOW, "Вы получили бонус: +1 опыт");
				}
			}
		}
		if (strlen(deathreason) > 0)// patch
		{
			if (((gTeam[killerid]) == 1) || ((gTeam[killerid]) == 3 && civnokill) || gTeam[killerid] == gTeam[playerid])//med kill criminal
			{
				format(string, sizeof(string), ".: %s убил %s. (%s) :.", killer, name, deathreason);
			}
			else
			{
				format(string, sizeof(string), ".: %s убил %s (%s) и заработал $%d :.", killer, name, deathreason, slice);
			}
			if (gdebug){print("DEBUG Deathtest3");}

		}
		else
		{
			if (gdebug){print("DEBUG Deathtest4");}
			if (((gTeam[killerid]) == 1) || ((gTeam[killerid]) == 3 && civnokill || gTeam[killerid] == gTeam[playerid]))
			{
				format(string, sizeof(string), ".: %s убил %s :.", killer, name);
			}
			else
			{
				format(string, sizeof(string), ".: %s убил %s и заработал $%d :.", killer, name, slice);
			}
		}
		if ((gTeam[killerid]) == 2)//cops kill criminal
		{
			format(string, sizeof(string), ".: %s был арестован Офицером %s (%s) и оштрафован $%d :.", name, killer, deathreason, slice);
			format(dmessage, sizeof(dmessage), "Арестован");
			if(IsACopCar(gLastCar[playerid]))
			{
				SafeGivePlayerMoney(killerid, 2000);
				SendClientMessageRus(killerid, TEAM_BLUE_COLOR, "Бонус за возврат полицейской машины $2000");
			}
		}
		if (((gTeam[killerid]) == 1) || ((gTeam[killerid]) == 3 && civnokill) || (gTeam[killerid] == gTeam[playerid] && gTeam[playerid] != 4))
		{
			slice = 0;
		}
		if (((gTeam[killerid]) != 4) && ((gTeam[killerid]) == gTeam[playerid]))//no team kill
		{
			slice = 0;
		}
		if (playercash > 0)
		{
			if (gdebug){print("DEBUG Deathtest1");}
			SafeGivePlayerMoney(playerid, -slice);
		}
		else
		{
			if (gdebug){print("DEBUG Deathtest2");}
			slice = slice+500;
		}
		SafeGivePlayerMoney(killerid, slice);
		GameTextForPlayerRus(playerid, dmessage, 5000, 2);
		PlayerPlaySound(killerid, 1083, 0.0, 0.0, 0.0);
		if (((gTeam[killerid]) == 3) && reason != 49)
		{
			SetPlayerCriminal(killerid,-1, "First Degree Murder",0,0);
			if(FlashTime[killerid] == 0){FlashTime[killerid] = 10;}
		}
		else if (((gTeam[killerid]) == 3) && reason == 49)
		{
			SetPlayerCriminal(killerid,-1, "Hit And Run",0,0);
			if(FlashTime[killerid] == 0){FlashTime[killerid] = 10;}
		}
		if (gPublicEnemy == playerid)
		{
			//SendClientMessageRus(killerid, TEAM_BLUE_COLOR, "HQ: You Have Arrested Public Enemy No.1, $5000 Bonus PayCheck");
			SafeGivePlayerMoney(killerid, preward);
			SafeGivePlayerMoney(playerid, -preward);
			KillTimer(offhook);
			format(string, sizeof(string), "SMS: %s, %s забрал ваш выйгрыш $%d, Отправитель: MOLE (555)", name, killer,preward);
			SendClientMessageRus(playerid, COLOR_YELLOW, string);
			RingTone[playerid] = 20;
			format(string, sizeof(string), ".:Враг народа №1 %s был убит игроком %s (%s) и потерял $%d :.", name, killer,  deathreason, slice);
			PlayerInfo[killerid][pPEN]++;
			if(PlayerInfo[killerid][pPEN] >= 4)
			{
				PlayerInfo[killerid][pExp]++;
				PlayerInfo[killerid][pPEN] = 0;
				SendClientMessageRus(killerid, COLOR_YELLOW, "Вы получаете бонуc: +1 опыт");
			}
			PlayerPlayMusic(killerid);
		}
		BroadCast(COLOR_RED, string);
		if (gPublicEnemy != playerid)
		{
			if(gPlayerFighter[killerid] != 1)
			{
				format(string, sizeof(string), "~g~$%d", slice);
				GameTextForPlayerRus(killerid, string, 5000, 1);
			}
		}
		else
		{
			format(string, sizeof(string), "~p~Враг Народа номер 1 ~w~убит~n~Вы заработали ~g~$%d", preward);
			GameTextForPlayerRus(killerid, string, 5000, 1);
			gPublicEnemy = -1;
		}
	}
	else if (victimteam == 2)
	{
		new killer[MAX_PLAYER_NAME];
		GetPlayerName(killerid, killer, sizeof(killer));
		// Cop kill
		if (gdebug){print("DEBUG test5");}
		PlayerInfo[playerid][pKills]--;
		if (gTeam[killerid] == 2)//cops kill cop
		{
			format(string,128,".: Офицер %s убил Офицера %s (%s) и был оштрафован на $%d :.",killer,name,deathreason,suecost);
			PlayerPlaySound(killerid, 1084, 0.0, 0.0, 0.0);
			SafeGivePlayerMoney(killerid, -suecost);
			SafeGivePlayerMoney(playerid, suecost+100);//+100pays hospital bill
		}
		else
		{
			format(string,128,".: %s убил Офицера %s (%s) :.",killer,name,deathreason);
	    }
		if (gTeam[killerid] == 3)
		{
			if(reason != 49)
			{
				SetPlayerCriminal(killerid,-1, "First Degree Murder",0,0);
			}
			else if (reason == 49)
			{
				SetPlayerCriminal(killerid,-1, "Hit And Run",0,0);
			}
			if(FlashTime[killerid] == 0){FlashTime[killerid] = 10;}
		}
		if(gTeam[killerid] >= 5 && SafeTime[playerid] <= 0)
		{
			if(GetPlayerState(killerid) == 1)
			{
				PlayerInfo[killerid][pKills] = PlayerInfo[killerid][pKills]+2;
			}
			else
			{
				PlayerInfo[killerid][pKills]++;
			}
			if(PlayerInfo[killerid][pKills] >= 30)
			{
				PlayerInfo[killerid][pExp]++;
				PlayerInfo[killerid][pKills] = 0;
				SendClientMessageRus(killerid, COLOR_YELLOW, "Вы получаете бонус: +1 опыт");
			}
		}
		BroadCast(COLOR_RED, string);
	}
	else if (victimteam == 3)
	{
		if (gdebug){print("DEBUG test6");}
		new killer[MAX_PLAYER_NAME];
		GetPlayerName(killerid, killer, sizeof(killer));
		// Civ kill
		if ((gTeam[killerid]) == 2)//cops kill civ
		{
			format(string,128,".: Офицер %s убил %s (%s) и был оштрафован на $%d :.",killer,name,deathreason,suecost);
			PlayerPlaySound(killerid, 1084, 0.0, 0.0, 0.0);
			SafeGivePlayerMoney(killerid, -suecost);
			SafeGivePlayerMoney(playerid, suecost+100);//+100pays hospital bill
		}
		else
		{
			format(string,128,".: %s murdered %s (%s) :.",killer,name,deathreason);
	    }
		if (((gTeam[killerid]) == 3 || (gTeam[killerid]) == 1) && reason != 49)
		{
			SetPlayerCriminal(killerid,-1, "First Degree Murder",0,0);
			if(FlashTime[killerid] == 0){FlashTime[killerid] = 10;}
		}
		else if (((gTeam[killerid]) == 3 || (gTeam[killerid]) == 1) && reason == 49)
		{
			SetPlayerCriminal(killerid,-1, "Hit And Run",0,0);
			if(FlashTime[killerid] == 0){FlashTime[killerid] = 10;}
		}
	    BroadCast(COLOR_RED, string);
	}
	else if (victimteam == 1)
	{
		if (gdebug){print("DEBUG test6");}
		new killer[MAX_PLAYER_NAME];
		GetPlayerName(killerid, killer, sizeof(killer));
		// Civ kill
		if ((gTeam[killerid]) == 2)//cops kill civ
		{
			format(string,128,".: Офицер %s убил медика %s (%s) и был оштрафован на $%d :.",killer,name,deathreason,suecost);
			PlayerPlaySound(killerid, 1084, 0.0, 0.0, 0.0);
			SafeGivePlayerMoney(killerid, -suecost);
			SafeGivePlayerMoney(playerid, suecost+100);//+100pays hospital bill
		}
		else if ((gTeam[killerid]) == 1)//med kill civ
		{
			format(string,128,".: Доктор %s убил %s (%s) и был оштрафован на $%d :.",killer,name,deathreason,suecost);
			PlayerPlaySound(killerid, 1084, 0.0, 0.0, 0.0);
			SafeGivePlayerMoney(killerid, -suecost);
			SafeGivePlayerMoney(playerid, suecost+100);//+100pays hospital bill
		}
		else
		{
			format(string,128,".: %s убил %s (%s) :.",killer,name,deathreason);
	    }
		if (((gTeam[killerid]) == 4) && reason != 49)
		{
			SetPlayerCriminal(killerid,-1, "First Degree Murder",0,0);
			if(FlashTime[killerid] == 0){FlashTime[killerid] = 10;}
		}
		else if (((gTeam[killerid]) == 3) && reason == 49)
		{
			SetPlayerCriminal(killerid,-1, "Hit And Run",0,0);
			if(FlashTime[killerid] == 0){FlashTime[killerid] = 10;}
		}
	    BroadCast(COLOR_RED, string);
	}
	if (gSuperCop == playerid)
	{
		gSuperCop = -1;
	}
	if(GetPlayerState(killerid) == 1)
	{
		lastkiller = killerid;
	}
	SetPlayerColor(playerid,COLOR_GRAD2);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if (gdebug >=1){printf("OnPlayerSpawn Playerid:%d", playerid);}
	if (teamcarlock)
	{
		TeamLockDoors(playerid);
	}
	InitLockDoors(playerid);
    if (gdebug >=1){printf("doors locked", playerid);}
	if(accountplay)
	{
		if (gdebug >=1){printf("accountplay");}
		if (gPlayerAccount[playerid] == 0)
		{
			gTeam[playerid] = 0;
			GameTextForPlayerRus(playerid, "~w~Добро пожаловать.~n~Для игры вам нужно зарегистрироваться, введите ~n~~r~/regnick (password)~w~ для регистрации", 20000, 3);
			//SetPlayerInterior(playerid,0);
			SetPlayerInterior(playerid,3);
			PlayerInfo[playerid][pInt] = 3;
			SetPlayerPos(playerid,198.5,162.5,1003.0);
			// airport
			PlayJailSound(1153 , 1154, 2000,264.395200, 77.564040, 1001.039000);
			gPlayerSpawned[playerid] = 1;
    		return 1;
		}
		if (gPlayerLogged[playerid] == 0)
		{
			gTeam[playerid] = 0;
			GameTextForPlayerRus(playerid, "~w~Для игры вам необходимо авторизоваться, введите ~n~~g~/login (password)", 20000, 3);
			//SetPlayerInterior(playerid,0);
			SetPlayerInterior(playerid,3);
			PlayerInfo[playerid][pInt] = 3;
			SetPlayerPos(playerid,198.5,162.5,1003.0);
			// airport
			PlayJailSound(1153 , 1154, 2000,264.395200, 77.564040, 1001.039000);
			gPlayerSpawned[playerid] = 1;
    		return 1;
		}
	}
	if (gPlayerSpawned[playerid] == 0)
	{
		gTeam[playerid] = PlayerInfo[playerid][pTeam];
		if (gTeam[playerid] == 2 && forceteam && CopCheck(playerid))
		{
			gTeam[playerid] = 3;
			PlayerInfo[playerid][pTeam] = 3;
			SetPlayerRandomSpawn(playerid);
			SendClientMessageRus(playerid, COLOR_YELLOW, "СЕРВЕР: Вы не можете быть копом.");
		}
		/*
		if(gTeam[playerid] == 2 && PlayerInfo[playerid][pLevel] < 3)
		{
			gTeam[playerid] = 3;
			PlayerInfo[playerid][pTeam] = 3;
			SetPlayerRandomSpawn(playerid);
			SendClientMessageRus(playerid, COLOR_YELLOW, "SERVER: You must be level 3 to join the cops.");
		}
		*/
		else if (gTeam[playerid] == 1 && forceteam && MedCheck(playerid))
		{
			gTeam[playerid] = 3;
			PlayerInfo[playerid][pTeam] = 3;
			SetPlayerRandomSpawn(playerid);
			SendClientMessageRus(playerid, COLOR_YELLOW, "СЕРВЕР: Вы не можете быть врачем.");
		}
		else if (gTeam[playerid] == 4) //medic / criminal reset team
		{
			gTeam[playerid] = PlayerInfo[playerid][pTeam];
		}
		/*
		if (FirstSpawn[playerid] == 0)
		{
			SetPlayerToTeamColor(playerid);
			SetPlayerInterior(playerid,PlayerInfo[playerid][pInt]);
			printf("PlayerInfo[playerid][pInt]= %d",PlayerInfo[playerid][pInt]);
			SetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
			gPlayerSpawned[playerid] = 1;
			FirstSpawn[playerid] = 1;
			print("insidespawn or firstsawpn");
			return 1;
		}
		*/
		else { SetPlayerRandomSpawn(playerid); }
		if (gdebug){printf("DEBUG id = %d gTeam = %d",playerid,gTeam[playerid]);}
		//SetPlayerPos(playerid, 1360.0217,2565.6328,10.8265);///badspawn
		//SetPlayerWorldBounds(playerid,3500.00,66.67,-653.33,-2806.67);
		/*
		switch (MissionActive)
		{
			case 1://Cashbox not picked up
			{
				if ((gTeam[playerid]) == 1)
				{
					SendClientMessageRus(playerid, COLOR_YELLOW, objstore);
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_PICKUP;
				}
				else if (gTeam[playerid] == 2)
				{
					SendClientMessageRus(playerid, TEAM_BLUE_COLOR, cbjstore);
				}
				SetPlayerCheckpointFixed(playerid,cwx, cwy, cwz, 1.0);
			}
			case 2://Cashbox picked up firsttime
			{
				if ((gTeam[playerid]) == 1)
				{
					SendClientMessageRus(playerid, COLOR_YELLOW, objstore);
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
				}
				else if (gTeam[playerid] == 2)
				{
					SendClientMessageRus(playerid, TEAM_BLUE_COLOR, cbjstore);
				}
				SetPlayerCheckpointFixed(playerid,cwx, cwy, cwz, 1.0);
			}
			case 3://Cashbox was dropped
			{

				SetPlayerCheckpointFixed(playerid,cwx,cwy,cwz, 1.0);
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_PICKUP;
				return 1;
			}
			case 5://racewait
			{
				if (gdebug){print("DEBUG Checkp5");}
				if ((gTeam[playerid]) == 1)
				{
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_SR1START;
				}
					SetPlayerCheckpointFixed(playerid,cwx,cwy,cwz, 8.0);
				return 1;
			}
			case 6://racewait
			{
				if (gdebug){print("DEBUG Checkp5");}
				if ((gTeam[playerid]) == 1 || (gTeam[playerid]) == 3)
				{
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_SRA;
				}
					SetPlayerCheckpointFixed(playerid,cwx,cwy,cwz, 8.0);
				return 1;
			}
			case 7://progress
			{
				if (gdebug){print("DEBUG Checkp5");}
				if ((gTeam[playerid]) == 1)
				{
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_SRA;
					SetPlayerCheckpointFixed(playerid,cwx,cwy,cwz, 8.0);
				}
				if ((gTeam[playerid]) == 2 )
				{
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_SR1START;
					SetPlayerCheckpointFixed(playerid,scx,scy,scz, 8.0);
				}
				return 1;
			}
			case 9://Car is waiting first occupent
			{
				if (gTeam[playerid] == 1)
				{
					SendClientMessageRus(playerid, COLOR_YELLOW, objstore);
					SetVehicleParamsForPlayerEx(stealcar,playerid,1,0);
				}
				else if (gTeam[playerid] == 2)
				{
				SendClientMessageRus(playerid, TEAM_BLUE_COLOR, cbjstore);
				SetVehicleParamsForPlayerEx(stealcar,playerid,1,1);
				}
			}
			case 10://Car has been takin by Criminal
			{
				if (gTeam[playerid] == 1)
				{
					SendClientMessageRus(playerid, COLOR_YELLOW, objstore);
				}
				else if (gTeam[playerid] == 2)
				{
					SendClientMessageRus(playerid, TEAM_BLUE_COLOR, cbjstore);
				}
				SetPlayerCheckpointFixed(playerid, cwx, cwy, cwz, 16.0);
				SetVehicleParamsForPlayerEx(stealcar,playerid,1,0);
			}
			case 101://Car is empty but was takin
			{
				SetVehicleParamsForPlayerEx(stealcar,playerid,1,0);
			}
			default:
			{

			}
		}
		*/

	}
	new Float: lwx, Float:lwy, Float:lwz;
	GetPlayerPos(playerid, lwx, lwy, lwz);
	if((lwz > 530.0 && PlayerInfo[playerid][pInt] == 0) || IsPlayerInRangeOfPoint(playerid, 1000.0, -1041.9,-1868.4,79.1)) //the highest land point in sa = 526.8
	{
		SetPlayerRandomSpawn(playerid);
		print("overhight or ob");
	}
	//SetPlayerInterior(playerid,0);
	if(dmweapon > 0 && gPlayerFighter[playerid] != 0)
	{
		GivePlayerWeapon(playerid, dmweapon, 999);
		if(PlayerInfo[playerid][pSHealth] < 50.0)
		{
			SetPlayerHealth(playerid, 100.0);
		}
		else
		{
			SetPlayerHealth(playerid, 50.0+PlayerInfo[playerid][pSHealth]);
		}
	}
	else
	{
		SetPlayerWeapons(playerid);
		SetPlayerHealth(playerid, 50.0+PlayerInfo[playerid][pSHealth]);
	}
	TelePos[playerid][0] = 0.0;
	TelePos[playerid][1] = 0.0;
	gPlayerSpawned[playerid] = 1;
	SafeTime[playerid] = 60;
	//PlayerUpdate(playerid); //spawnsave
	return 1;
}
//---------------------------------------CHECKPOINT----------------------------------------------------
public PayLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\n",string);
	new File:hFile;
	hFile = fopen("pay.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public CmdLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\n",string);
	new File:hFile;
	hFile = fopen("cmd.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public PrePlayerNewMission()
{
	if (gdebug >=1){printf("PrePlayerNewMission");}
	CheckpointReset();
	if (MissionActive == 12)
	{
		gFighters=0;
		gFightLeader=0;
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				DmScore[i] = 0;
				if(gPlayerFighter[i] == 1)
				{
					gPlayerFighter[i] = 0;
					TogglePlayerControllable(i, 1);
					SetPlayerRandomSpawn(i);
				}
			}
		}
	}
	if (MissionActive > 8 && MissionActive < 12)
	{
		if(MissionActive != 0)
		{
			printf("DEBUG: Bad Hotwire: stealcar = %d, stealcardest = %d",stealcar,stealcardest);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(stealcar != -1)
					{
						SetVehicleParamsForPlayerEx(stealcar,i,0,0);
						SetVehicleToRespawn(stealcar);
						stealcar = -1;
					}
				}
			}
		}
	}
	if (MissionActive > 4 && MissionActive <= 7 )
	{
		CheckpointReset();
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				LapCount[i] = 0;
				StartTime[i] = 0;
			}
		}
		gRaceFin = 0;
		gRaceMid = 0;
		gRaceMid2 = 0;
		gRaceEnd = 0;
		gLaps = 0;
		BroadCast(COLOR_WHITE, "НОВОСТИ ГОНКИ: ::: Гонка завершилась :::");
	}
	if (cashbox == 0 && hotwire == 0 && streetrace == 0 && deathmatch == 0)
	{
		MissionActive = -1;
		if (gdebug){print("DEBUG MissionActive = -1");}
		return 1;
	}
	if (cashbox == 0 && hotwire == 0 && streetrace == 1 && deathmatch == 0)
	{
		MissionActive = 4;
		if (gdebug){print("DEBUG MissionActive = 4");}
		SetPlayerNewMission();
		return 1;
	}
	if (cashbox == 0 && hotwire == 0 && streetrace == 0 && deathmatch == 1)
	{
		MissionActive = 12;
		if (gdebug){print("DEBUG MissionActive = 12");}
		SetPlayerNewMission();
		return 1;
	}
	if (MissionActive == 0)
	{
		if (cashbox == 0)
		{
			MissionActive = 4;
			if (gdebug){print("DEBUG MissionActive = 4");}
		}
		else
		{
			MissionActive = 0;
			if (gdebug){print("DEBUG MissionActive = 0");}
		}
		SetPlayerNewMission();
		return 1;
	}
	if (MissionActive > 0 && MissionActive <= 4)
	{
		if (streetrace == 0)
		{
			MissionActive = 8;
			if (gdebug){print("DEBUG MissionActive = 8");}
		}
		else
		{
			MissionActive = 4;
			if (gdebug){print("DEBUG MissionActive = 4");}
		}
		SetPlayerNewMission();
		return 1;
	}
	if (MissionActive > 4 && MissionActive <= 8 )
	{
		if (hotwire == 0)
		{
			MissionActive = 12;
			if (gdebug){print("DEBUG MissionActive = 12");}
		}
		else
		{
			MissionActive = 8;
			if (gdebug){print("DEBUG MissionActive = 8");}
		}
		SetPlayerNewMission();
		return 1;
	}
	if (MissionActive > 8 && MissionActive <= 12)
	{
		if (deathmatch == 0)
		{
			MissionActive = 0;
			if (gdebug){print("DEBUG MissionActive = 0");}
		}
		else
		{
			MissionActive = 12;
			if (gdebug){print("DEBUG MissionActive = 12");}
		}
		SetPlayerNewMission();
		return 1;
	}
	if (MissionActive == 13)
	{
		if (cashbox == 0)
		{
			MissionActive = 4;
			if (gdebug){print("DEBUG MissionActive = 4");}
		}
		else
		{
			MissionActive = 0;
			if (gdebug){print("DEBUG MissionActive = 0");}
		}
		SetPlayerNewMission();
		return 1;
	}
	return 1;
}
public SetPlayerNewMission()
{
	if (gdebug >=1){printf("SetPlayerNewMission");}
	switch (MissionActive)
	{
		case 0:
		{
			new rando = random(5);
			if (rando == 1)
			{
				cwx = 997.7;
				cwy = -921.1;
				cwz = 42.1;
				format(objstore, sizeof(objstore), "SMS: Сегодня зарплата в North Side Gas Station, Отправитель: MOLE (555)");
				format(cbjstore, sizeof(cbjstore), "HQ: 911 10-14 North Side Gas Station.");
			}
			else if(rando == 2)
			{
				cwx = 2421.5;
				cwy = -1221.7;
				cwz = 25.3;
				format(objstore, sizeof(objstore), "SMS: Сегодня зарплата в The Pig Pen, Отправитель: MOLE (555)");
				format(cbjstore, sizeof(cbjstore), "HQ: 911 10-10 At The Pig Pen.");
			}
			else if(rando == 3)
			{
				cwx = 2069.7;
				cwy = -1780.1;
				cwz = 13.5;
				format(objstore, sizeof(objstore), "SMS: Сегодня зарплата в East Side Tattoo, Отправитель: MOLE (555)");
				format(cbjstore, sizeof(cbjstore), "HQ: 911 10-32 At East Side Tatoo.");
			}
			else if(rando == 4)
			{
				cwx = 1352.4;
				cwy = -1756.7;
				cwz = 13.5;
				format(objstore, sizeof(objstore), "SMS: Сегодня зарплата в Roboi's Food Mart, Отправитель: MOLE (555)");
				format(cbjstore, sizeof(cbjstore), "HQ: 911 10-17 At Robbi's Food Mart.");
			}
			else
			{
				cwx = 1831.1;
				cwy = -1842.8;
				cwz = 13.5;
				format(objstore, sizeof(objstore), "SMS: Сегодня зарплата в The 69 Cent Store, Отправитель: MOLE (555)");
				format(cbjstore, sizeof(cbjstore), "HQ: 911 10-94 At The 69 Cent Store.");
			}
			rx = cwx;//storing the store
			ry = cwy;
			rz = cwz;
			MissionActive = 1;
			if (gdebug){print("DEBUG MissionActive = 1;");}
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && gPlayerSpawned[i])
				{
					if (gTeam[i] >= 3)
					{
						if (automission)
						{
							JobGive(i);
						}
						else if (PlayerInfo[i][pPnumber] !=0)
						{
							SendClientMessageRus(i, COLOR_YELLOW, "SMS: У меня есть работа для тебя, Отправь Да на номер 555 чтобы узнать больше, Отправитель: MOLE (555)");
							SendClientMessageRus(i, COLOR_WHITE, "ПОДСКАЗКА: Введи (/sms 555 Да) чтобы получить задание от Mole");
							RingTone[i] =20;
						}
					}
					else if (gPlayerSpawned[i] == 1 && (gTeam[i]) == 2)
					{
						SendClientMessageRus(i, COLOR_DBLUE, cbjstore);
						GameTextForPlayerRus(i, "~w~Маркер установлен ~n~~r~CashBox", 5000, 1);
						SetPlayerCheckpointFixed(i,cwx, cwy, cwz, 1.4);
					}
				}
			}
			return 1;
		}
/*
		case 2:
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if (IsPlayerConnected(i) && i != gSuperCop && i != gPublicEnemy )
				{
						SetPlayerCheckpointFixed(i,cwx,cwy,cwz, 1.0);
						gPlayerCheckpointStatus[i] = CHECKPOINT_NONE;
						if (gdebug){print("DEBUG CHECKPOINT_NONE1");}
				}
			}
			return 1;
		}
		case 3:
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if (IsPlayerConnected(i))
				{
						SetPlayerCheckpointFixed(i,cwx,cwy,cwz, 1.0);
						gPlayerCheckpointStatus[i] = CHECKPOINT_PICKUP;
				}
			}
			return 1;
		}*/
		case 4:
		{
			/*
			if (gdebug){print("DEBUG Checkp2");}
			RStart = random(sizeof(gRaceCheckpoints));
			RNext = random(sizeof(gRaceCheckpoints));
			while (RNext == RStart)
			{
				RNext = random(sizeof(gRaceCheckpoints));
			}
			REnd = random(sizeof(gRaceCheckpoints));
			while (RNext == REnd)
			{
				REnd = random(sizeof(gRaceCheckpoints));
			}
			cwx = gRaceCheckpoints[RStart][0];
			cwy = gRaceCheckpoints[RStart][1];
			cwz = gRaceCheckpoints[RStart][2];
			scx = gRaceCheckpoints[RNext][0];
			scy = gRaceCheckpoints[RNext][1];
			scz = gRaceCheckpoints[RNext][2];
			rx = gRaceCheckpoints[REnd][0];
			ry = gRaceCheckpoints[REnd][1];
			rz = gRaceCheckpoints[REnd][2];
			*/
			gRaceFin = 0;
			gRaceMid = 0;
			gRaceMid2 = 0;
			if(randomrace)
			{
				RNext = random(sizeof(gRaceCheckpoints)-1);
				RNext2 = random(sizeof(gRaceCheckpoints));
				REnd = random(sizeof(gRaceCheckpoints));
				while (RNext == REnd)
				{
					REnd = random(sizeof(gRaceCheckpoints));
				}
				while (RNext2 == RNext)
				{
					RNext2 = random(sizeof(gRaceCheckpoints));
				}
				rsx = gRaceCheckpoints[4][0];
				rsy = gRaceCheckpoints[4][1];
				rsz = gRaceCheckpoints[4][2];
				rmx = gRaceCheckpoints[RNext][0];
				rmy = gRaceCheckpoints[RNext][1];
				rmz = gRaceCheckpoints[RNext][2];
				rm2x = gRaceCheckpoints[RNext2][0];
				rm2y = gRaceCheckpoints[RNext2][1];
				rm2z = gRaceCheckpoints[RNext2][2];
				rex = gRaceCheckpoints[REnd][0];
				rey = gRaceCheckpoints[REnd][1];
				rez = gRaceCheckpoints[REnd][2];
			}
			//printf("racelist1 = %d",racelist);
			/*
			if(racelist > 0)
			{
				if(racelist > 8)
				{
					racelist = 1;
					//printf("racelist2 = %d",racelist);
				}
				new nextrace = racelist-1;
				LoadRace(-1,Races[nextrace]);
				racelist++;
				//printf("racelist3 = %d",racelist);
			}
			*/
			if(racelist > 0)
			{
				new randa = random(sizeof(Races));
				LoadRace(-1,Races[randa]);
			}
			MissionActive = 5;
			if (gdebug){print("DEBUG MissionActive = 5");}
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && (gPlayerSpawned[i] == 1))
				{
					if (gdebug){print("DEBUG Checkp4");}
					if (gTeam[i] >= 3)
					{
						if (automission)
						{
							JobGive(i);
						}
						else if (PlayerInfo[i][pPnumber] !=0)
						{
							SendClientMessageRus(i, COLOR_YELLOW, "SMS: У меня есть работа для тебя, Отправь Да на номер 555 чтобы узнать больше, Отправитель: MOLE (555)");
							SendClientMessageRus(i, COLOR_WHITE, "ПОДСКАЗКА: Введи (/sms 555 Да) чтобы получить задание от Mole");
							RingTone[i] =20;
						}
					}
					else if((gTeam[i]) == 2 && RaceInfo[rLaps] == 0)
					{

						if (gdebug){print("DEBUG Checkp6");}
						format(cbjstore, sizeof(cbjstore), "HQ: 911 10-14 Устройте облаву на красном маркере.");
						GameTextForPlayerRus(i, "~w~Маркер установлен ~n~~r~RoadBlock", 5000, 1);
						SendClientMessageRus(i, COLOR_DBLUE, cbjstore);
						RingTone[i] = 20;
						SetPlayerCheckpointFixed(i,rm2x,rm2y,rm2z, 8.0);
					}
				}
			}
			return 1;
		}
		case 8:
		{
			if (gdebug){print("DEBUG test1");}
			stealcar = random(166)+88;
			GetVehiclePos(stealcar, scx, scy, scz);
			format(objstore, sizeof(objstore), "SMS: У меня есть покупатель, заинтересованый в машине, отмеченой на GPS, Отправитель: MOLE (555)");
			format(cbjstore, sizeof(cbjstore), "HQ: 911 10-64 Заказан угон авто.");
			rx = scx;//storing the car pos
			ry = scy;
			rz = scz;
			if (gdebug){print("DEBUG TEST2");}
			stealcardest = random(166)+88;
			while (stealcardest == stealcar)
			{
				stealcardest = random(166)+88;
			}
			MissionActive = 9;
			if (gdebug){print("DEBUG MissionActive = 9;");}
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && (gPlayerSpawned[i] == 1))
				{
					if (gdebug){print("DEBUG test2");}
					if (gTeam[i] >= 3)
					{
						if (automission)
						{
							JobGive(i);
						}
						else if (PlayerInfo[i][pPnumber] !=0)
						{
							SendClientMessageRus(i, COLOR_YELLOW, "SMS: У меня есть работа для тебя, Отправь Да на номер 555 чтобы узнать больше, Отправитель: MOLE (555)");
							SendClientMessageRus(i, COLOR_WHITE, "ПОДСКАЗКА: Введи (/sms 555 Да) чтобы получить задание от Mole");
							RingTone[i] =20;
						}
					}
					else
					{
						if (gdebug){print("DEBUG test4");}
						SendClientMessageRus(i, COLOR_DBLUE, cbjstore);
						GameTextForPlayerRus(i, "~w~Маркер установлен ~n~~r~Suspect Vehicle", 5000, 1);
						SetVehicleParamsForPlayerEx(stealcar,i,1,1);
						new Float:px, Float:py, Float:pz;
						GetVehiclePos(stealcar, px, py, pz);
						//DisablePlayerCheckpoint(i);
						SetPlayerCheckpointFixed(i, px, py, pz, 4.0);
					}
				}
			}
			if (gdebug){printf("DEBUG HOTWIRE mission started: TargetCar:%d",stealcar);}
			return 1;
		}
		case 12:
		{
			new rand = random(sizeof(DmGun));
			dmweapon = DmGun[rand];
			if(dmlist > 35)
			{
				dmlist = 1;
				//printf("racelist2 = %d",racelist);
			}
			new nextdm = random(sizeof(DeathMatches));
			LoadDM(-1,DeathMatches[nextdm]);
			new sgun1[20];
			new winfo[256];
			if(DmGun[rand] > 0)
			{
				GetWeaponName(DmGun[rand], sgun1, 20);
				format(winfo, sizeof(winfo), "Оружие ДМ: %s",sgun1);
			}
			else
			{
				format(winfo, sizeof(winfo), "Оружие ДМ: своё");
			}
			SendClientMessageToAllRus(COLOR_GREEN, winfo);
			//dmlist++;
			//printf("racelist3 = %d",racelist);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && gPlayerSpawned[i])
				{
					SendClientMessageRus(i, COLOR_YELLOW, "SMS: Скоро начнется дезматч на красном маркере около Аммо, Отправитель: MOLE (555)");
					RingTone[i] = 20;
					SendClientMessageRus(i, COLOR_WHITE, "ПОДСКАЗКА: Отправляйся на красный маркер и жди начала дезматча.");
					SetPlayerCheckpointFixed(i,gRandomDMSpawns[0][0],gRandomDMSpawns[0][1],gRandomDMSpawns[0][2], 4.0);
					GameTextForPlayerRus(i, "~w~Маркер установлен ~n~~r~DeathMatch", 5000, 1);
					gPlayerCheckpointStatus[i] = CHECKPOINT_DM;
				}
			}
			MissionActive = 13;
			return 1;
		}
/*
		case 10:
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if (!IsPlayerInVehicle(i, stealcar))
					{
						SetAllPlayerCheckpoint(cwx, cwy, cwz, 16.0, -1);
						SetVehicleParamsForPlayerEx(stealcar,i,1,0);
					}
				}
			}
			return 1;
		}
		case 101:
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if (!IsPlayerInVehicle(i, stealcar))
					{
						SetAllPlayerCheckpoint(scx, scx, scx, 16.0, -1);
						SetVehicleParamsForPlayerEx(stealcar,i,1,0);
					}
					//SetAllPlayerCheckpoint(scx, scy, scz, 16.0, -1);
				}
			}
			return 1;
		}
		case 102:
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if (!IsPlayerInVehicle(i, stealcar))
					{
						SetVehicleParamsForPlayerEx(stealcar,i,1,0);
					}
				}
			}
			return 1;
		}	*/
		default:
		{
			return 1;
		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if (gdebug >=1){printf("OnPlayerEnterCheckpoint %d",playerid);}
	new string[128];
	new name[MAX_PLAYER_NAME];
	switch (gPlayerCheckpointStatus[playerid])
	{
		case CHECKPOINT_PICKUP:
		    {
				if(GetPlayerState(playerid) != 1)
				{
					GameTextForPlayerRus(playerid, "~w~Вы должны быть~n~~r~пешим", 1000, 1);
					return 1;
				}
				if (gdebug){print("DEBUG CHECKPOINT_PICKUP");}
		  	    GetPlayerName(playerid, name, sizeof(name));
		  	    if (MissionActive == 1)
		  	    {
					RewardCalc(playerid,1000,10000);
					DropOff = random(sizeof(gCBdropoff));
				}
				if (gTeam[playerid] >= 3)
				{
					PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
					CheckpointReset();
					GameTextForPlayerRus(playerid, "~w~Теперь отправляйтесь к ~n~~r~месту встречи", 5000, 1);
					cwx = gCBdropoff[DropOff][0];
					cwy = gCBdropoff[DropOff][1];
					cwz = gCBdropoff[DropOff][2];
					SetAllPlayerCheckpoint(cwx, cwy, cwz, 1.4, 0);
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_DROPOFF;
					if (gdebug){printf("DEBUG gpcs %d",gPlayerCheckpointStatus[playerid]);}
					format(string, sizeof(string), "%s подобрал кейс с $%d.", name ,reward);
					BroadCast(COLOR_YELLOW, string);
					gSuperCop = playerid;
					SetPlayerCriminal(playerid,-1, "Вооруженное ограбление",0,0);
					MissionActive = 2;
					if (gdebug){print("DEBUG MissionActive = 2;");}
				}
				else if ((gTeam[playerid]) == 2)
				{
					PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
					CheckpointReset();
					GameTextForPlayerRus(playerid, "~w~Верните кейс~n~~r~владельцу", 5000, 1);
					cwx = rx;//retrieving the store
					cwy = ry;
					cwz = rz;
					SetAllPlayerCheckpoint(cwx, cwy, cwz, 1.4, 0);
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_DROPOFF;
					format(string, sizeof(string), "Офицер %s подобрал кейс, содержащий $%d.", name ,reward);
					BroadCast(COLOR_YELLOW, string);
	            	gSuperCop = playerid;
	            	MissionActive = 2;
	            	if (gdebug){print("DEBUG MissionActive = 2;");}
				}
			}
		case CHECKPOINT_DROPOFF:
		    {
				if (gdebug){print("DEBUG CHECKPOINT_DROPOFF");}
				GetPlayerName(playerid, name, sizeof(name));
				SafeGivePlayerMoney(playerid, reward);
				preward = reward;
				PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
				if ((gTeam[playerid]) >= 4)
				{
					format(string, sizeof(string), "~g~Хорошая работа~n~~w~Ваше вознаграждение~n~~g~$%d", reward);
					GameTextForPlayerRus(playerid, string, 5000, 6);
					format(string, sizeof(string), "%s вскрыл кейс с $%d наличными.", name,reward);
					gSuperCop = -1;
					SetPlayerCriminal(playerid,-1, "Вооруженное ограбление",1,1);
					gPlayerMission[playerid] = 1;
				}
				else
				{
					format(string, sizeof(string), "~b~Вы вернули кейс~n~~w~вознаграждение~n~~g~$%d", reward);
					GameTextForPlayerRus(playerid, string, 5000, 6);
					format(string, sizeof(string), "%s вернул кейс с $%d наличными.", name,reward);
					SetPlayerToTeamColor(playerid);
					gSuperCop = -1;
					if(PlayerInfo[playerid][pCB] >= 4)
					{
						PlayerInfo[playerid][pExp]++;
						PlayerInfo[playerid][pCB] = 0;
						SendClientMessageRus(playerid, COLOR_YELLOW, "Вы получаете бонус: +1 опыт");
					}
				}
				PlayerPlayMusic(playerid);
				BroadCast(COLOR_YELLOW, string);
				CheckpointReset();
				MissionActive = 4;//srace
				if (gdebug){print("DEBUG MissionActive = 4;");}
		    }
		case CHECKPOINT_SR1START:
		    {
				if (gdebug){print("DEBUG CHECKPOINT_SR1START");}
				if (GetPlayerState(playerid) != 2)
				{
					return 1;
				}
				PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
				if (gTeam[playerid] >= 3)
				{
					new tmpcar = GetPlayerVehicleID(playerid);
					if(IsAPlane(tmpcar))
					{
						GameTextForPlayerRus(playerid, "~w~На гонке не разрешен воздушный транспорт", 2000, 6);
						return 1;
					}
					if (MissionActive == 5)// first to arrive
					{
						gRaceLeader++;
						if (gdebug){printf("gRaceLeader %d",gRaceLeader);}
						if (gRaceLeader == 1)
						{
							format(string, sizeof(string), "~r~Ждите других гонщиков");
							GameTextForPlayerRus(playerid, string, 2000, 6);
							gPlayerCheckpointStatus[playerid] = CHECKPOINT_SRA;
							DisablePlayerCheckpoint(playerid);
							return 1;
						}
						else if (gRaceLeader == 2)
						{
							gRaceLeader = 0;
							if (gdebug){printf("gRaceLeader %d",gRaceLeader);}
							format(string, sizeof(string), "SMS: %d секунд до начала гонки, Отправитель: MOLE (555)",racedelay/1000);
							RingTone[playerid] = 20;
							SendEnemyMessage(COLOR_YELLOW, string);
							format(string, sizeof(string), "~r~Ждите здесь гонщиков");
							gPlayerCheckpointStatus[playerid] = CHECKPOINT_SRA;
							GameTextForPlayerRus(playerid, string, 2000, 6);
						}
						SetTimer("RaceDelay", racedelay, 0);
						DisablePlayerCheckpoint(playerid);
						MissionActive = 6;
						if (gdebug){print("DEBUG MissionActive = 6");}
					}
					else if (MissionActive == 6) //late arrivels
					{
						if (gdebug){print("DEBUG waiting");}
						DisablePlayerCheckpoint(playerid);
						gPlayerCheckpointStatus[playerid] = CHECKPOINT_SRA;
					}
				}
				else
				{
					GameTextForPlayerRus(playerid, "~w~Патрулируйте эту зону", 5000, 1);
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
					return 1;
				}
		    }
		case CHECKPOINT_SRA:
		    {
				if (gdebug){print("DEBUG CHECKPOINT_SRA");}
				if (GetPlayerState(playerid) != 2)
				{
					return 1;
				}
				new tmpcar = GetPlayerVehicleID(playerid);
				if(IsAPlane(tmpcar))
				{
					GameTextForPlayerRus(playerid, "~w~На гонке запрещен воздушный транспорт", 2000, 6);
					return 1;
				}
				if (StartTime[playerid] == 0)
				{
					StartTime[playerid] = Gtickcount;
					if(gTeam[playerid] == 3)
					{
						SetPlayerCriminal(playerid,-1, "Уличные гонки",0,0);
						//if(FlashTime[playerid] == 0){FlashTime[playerid] = 60;}
					}
				}
				LapCount[playerid]++;
				gRaceEnd++;
				if(LapCount[playerid] > gLaps)
				{
					gLaps = LapCount[playerid];
					gRaceEnd = 1;
				}
				if(RaceInfo[rLaps] != 0)
				{
					if(gLaps != (RaceInfo[rLaps]+1) && gLaps > 1)
					{
						//RaceDebug(playerid);
						if(gLaps == 2)
						{
							for(new i = 0; i < MAX_PLAYERS; i++)
							{
								if(IsPlayerConnected(i) && gTeam[i] == 2)
								{
									format(cbjstore, sizeof(cbjstore), "HQ: 911 10-14 Устройте облаву на красном маркере.");
									SendClientMessageRus(i, COLOR_DBLUE, cbjstore);
									RingTone[i] = 20;
									SetPlayerCheckpointFixed(i,rm2x,rm2y,rm2z, 8.0);
								}
							}
							RaceTime[playerid] = Gtickcount;
						}
						if (gRaceEnd == 1 && LapCount[playerid] == gLaps)
						{
							pos1time = RaceTime[playerid] - StartTime[playerid];
							ConvertTicks(pos1time);
							GetPlayerName(playerid, name, sizeof(name));
							format(string, sizeof(string), "НОВОСТИ ГОНКИ: %s лидирует. Время: %d:%d:%d", name,cmins,csecs,cmils);
							BroadCast(COLOR_WHITE, string);
							format(string, sizeof(string), "~w~Круг %d/%d~n~~g~1е место ~n~~y~T: %d:%d:%d",gLaps,RaceInfo[rLaps],cmins,csecs,cmils);
							SetAllCopCheckpoint(rex,rey,rez, 8.0);
						}
						else if (gRaceEnd == 2 && LapCount[playerid] == gLaps)
						{
							pos2time = RaceTime[playerid] - StartTime[playerid];
							new splittime = pos2time - pos1time;
							ConvertTicks(splittime);
							GetPlayerName(playerid, name, sizeof(name));
							format(string, sizeof(string), "НОВОСТИ ГОНКИ: %s идет вторым. Время: +%d:%d:%d", name,cmins,csecs,cmils);
							BroadCast(COLOR_WHITE, string);
							format(string, sizeof(string), "~w~Круг %d/%d~n~~g~2е место ~n~~y~T: %d:%d:%d",gLaps,RaceInfo[rLaps],cmins,csecs,cmils);
						}
						else if (gRaceEnd == 3 && LapCount[playerid] == gLaps)
						{
							pos3time = RaceTime[playerid] - StartTime[playerid];
							new splittime = pos3time - pos1time;
							ConvertTicks(splittime);
							GetPlayerName(playerid, name, sizeof(name));
							format(string, sizeof(string), "НОВОСТИ ГОНКИ: %s идет третьим. Время: +%d:%d:%d", name,cmins,csecs,cmils);
							BroadCast(COLOR_WHITE, string);
							format(string, sizeof(string), "~w~Круг %d/%d~n~~g~3е место ~n~~y~Время: %d:%d:%d",gLaps,RaceInfo[rLaps],cmins,csecs,cmils);
						}
						else
						{
							format(string, sizeof(string), "~w~Круг %d/%d",LapCount[playerid],RaceInfo[rLaps]);
						}
						GameTextForPlayerRus(playerid, string, 5000, 1);
					}
					else if(gLaps == (RaceInfo[rLaps]+1) && gLaps > 1)
					{
						if (gRaceEnd == 1)
						{
							DisablePlayerCheckpoint(playerid);
							PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
							if (gdebug){print("DEBUG RACE OVER");}
							RewardCalc(playerid,1000,10000);
							GetPlayerName(playerid, name, sizeof(name));
							SafeGivePlayerMoney(playerid, reward);
							preward = reward;
							PlayerPlayMusic(playerid);
							format(string, sizeof(string), "~g~Победа~n~~w~Ваш выйгрыш ~n~~g~$%d", reward);
							GameTextForPlayerRus(playerid, string, 5000, 6);
							BroadCast(COLOR_WHITE, "RACENEWS: The Race Will End In 120 secs");
							RaceTime[playerid] = Gtickcount;
							pos1time = RaceTime[playerid] - StartTime[playerid];
							ConvertTicks(pos1time);
							GetPlayerName(playerid, name, sizeof(name));
							raceendtimer = SetTimer("RaceEnd", 120000, 0);
							if(RaceInfo[rBestms] > pos1time || RaceInfo[rBestms] == 0)
							{
								RaceInfo[rBestms] = pos1time;
								strmid(RaceInfo[rBest],name, 0, strlen(name), 255);
								BestTime(CurrentRace);
								format(string, sizeof(string), "НОВОСТИ ГОНКИ: %s выйграл на гонке $%d",name,reward);
								BroadCast(COLOR_WHITE, string);
								format(string, sizeof(string), "НОВОСТИ ГОНКИ: %s установил рекорд %s. Время: %d:%d:%d", name,CurrentRace,cmins,csecs,cmils);
								BroadCast(COLOR_WHITE, string);
							}
							else
							{
								format(string, sizeof(string), "НОВОСТИ ГОНКИ: %s выйграл на гонке $%d. Время: %d:%d:%d", name,reward,cmins,csecs,cmils);
								BroadCast(COLOR_WHITE, string);
							}
							SetPlayerCriminal(playerid,-1, "Уличные гонки",1,1);
							gPlayerMission[playerid] = 2;
							BetWinner(playerid,1);
							return 1;
						}
						else if (gRaceEnd == 2)
						{
							DisablePlayerCheckpoint(playerid);
							PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
							if (gdebug){print("DEBUG RACE OVER");}
							reward = preward/2;
							GetPlayerName(playerid, name, sizeof(name));
							SafeGivePlayerMoney(playerid, reward);
							PlayerPlayMusic(playerid);
							format(string, sizeof(string), "~g~2е место~n~~w~Ваш выйгрыш ~n~~g~$%d", reward);
							GameTextForPlayerRus(playerid, string, 5000, 6);
							RaceTime[playerid] = Gtickcount;
							pos3time = RaceTime[playerid] - StartTime[playerid];
							new splittime = pos3time - pos1time;
							ConvertTicks(splittime);
							GetPlayerName(playerid, name, sizeof(name));
							format(string, sizeof(string), "НОВОСТИ ГОНКИ: %s пришел вторым и получил $%d. Время: +%d:%d:%d", name,reward,cmins,csecs,cmils);
							BroadCast(COLOR_WHITE, string);
							return 1;
						}
						else if (gRaceEnd == 3)
						{
							CheckpointReset();
							PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
							if (gdebug){print("DEBUG RACE OVER");}
							reward = preward/3;
							GetPlayerName(playerid, name, sizeof(name));
							SafeGivePlayerMoney(playerid, reward);
							PlayerPlayMusic(playerid);
							format(string, sizeof(string), "~g~3е место~n~~w~Ваш выйгрыш ~n~~g~$%d", reward);
							GameTextForPlayerRus(playerid, string, 5000, 6);
							RaceTime[playerid] = Gtickcount;
							pos2time = RaceTime[playerid] - StartTime[playerid];
							new splittime = pos2time - pos1time;
							ConvertTicks(splittime);
							GetPlayerName(playerid, name, sizeof(name));
							format(string, sizeof(string), "НОВОСТИ ГОНКИ: %s пришел третьим и получил $%d. Время: +%d:%d:%d", name,reward,cmins,csecs,cmils);
							BroadCast(COLOR_WHITE, string);
							KillTimer(raceendtimer);
							RaceEnd();
							return 1;
						}
					}
					PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
					SetPlayerCheckpointFixed(playerid,rmx,rmy,rmz, 16.0);
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_SRB;
				}
				if(RaceInfo[rLaps] == 0 && LapCount[playerid] == 1)
				{
					PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
					SetPlayerCheckpointFixed(playerid,rmx,rmy,rmz, 16.0);
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_SRB;
				}
		    }
		case CHECKPOINT_SRB:
		    {
				if (GetPlayerState(playerid) != 2)
				{
					return 1;
				}
				new tmpcar = GetPlayerVehicleID(playerid);
				if(IsAPlane(tmpcar))
				{
					GameTextForPlayerRus(playerid, "~w~No aircraft allowed in the race", 2000, 6);
					return 1;
				}
				if(gRaceMid != 1 && LapCount[playerid] > gLaps)
				{
					gRaceMid = 1;
				}
				if (gdebug){print("DEBUG CHECKPOINT_SRB");}
				PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
				SetPlayerCheckpointFixed(playerid,rm2x,rm2y,rm2z, 16.0);
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_SRC;
				gRaceMid++;
				if (gdebug){printf("gRaceLeader %d",gRaceLeader);}
		    }
		case CHECKPOINT_SRC:
		    {
				if (GetPlayerState(playerid) != 2)
				{
					return 1;
				}
				new tmpcar = GetPlayerVehicleID(playerid);
				if(IsAPlane(tmpcar))
				{
					GameTextForPlayerRus(playerid, "~w~No aircraft allowed in the race", 2000, 6);
					return 1;
				}
				if(gRaceMid2 != 1 && LapCount[playerid] > gLaps)
				{
					gRaceMid2 = 1;
				}
				if (gdebug){print("DEBUG CHECKPOINT_SRB");}
				PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
				SetPlayerCheckpointFixed(playerid,rex,rey,rez, 16.0);
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_SRD;
				gRaceMid2++;
				if (gdebug){printf("gRaceLeader %d",gRaceLeader);}
		    }
		case CHECKPOINT_SRD:
		    {
				if (GetPlayerState(playerid) != 2)
				{
					return 1;
				}
				new tmpcar = GetPlayerVehicleID(playerid);
				if(IsAPlane(tmpcar))
				{
					GameTextForPlayerRus(playerid, "~w~No aircraft allowed in the race", 2000, 6);
					return 1;
				}
				if(gRaceFin != 1 && LapCount[playerid] > gLaps)
				{
					gRaceFin = 1;
				}
				if (gdebug){print("DEBUG CHECKPOINT_SRC");}
				gRaceFin++;
				if(RaceInfo[rLaps] > 0)
				{
					PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
					SetPlayerCheckpointFixed(playerid,rsx,rsy,rsz, 16.0);
					gPlayerCheckpointStatus[playerid] = CHECKPOINT_SRA;
					SetAllCopCheckpoint(rex,rey,rez, 8.0);
				}
				if(RaceInfo[rLaps] == 0)
				{
					if (gRaceFin == 1)
					{
						DisablePlayerCheckpoint(playerid);
						PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
						if (gdebug){print("DEBUG RACE OVER");}
						RewardCalc(playerid,1000,10000);
						GetPlayerName(playerid, name, sizeof(name));
						SafeGivePlayerMoney(playerid, reward);
						preward = reward;
						PlayerPlayMusic(playerid);
						format(string, sizeof(string), "~g~YOU WIN~n~~w~Your winnings are ~n~~g~$%d", reward);
						GameTextForPlayerRus(playerid, string, 5000, 6);
						BroadCast(COLOR_WHITE, "НОВОСТИ ГОНКИ: Гонка завершится через 120 секунд");
						RaceTime[playerid] = Gtickcount;
						pos1time = RaceTime[playerid] - StartTime[playerid];
						ConvertTicks(pos1time);
						GetPlayerName(playerid, name, sizeof(name));
						raceendtimer = SetTimer("RaceEnd", 120000, 0);
						if(RaceInfo[rBestms] > pos1time || RaceInfo[rBestms] == 0)
						{
							RaceInfo[rBestms] = pos1time;
							strmid(RaceInfo[rBest],name, 0, strlen(name), 255);
							BestTime(CurrentRace);
							format(string, sizeof(string), "НОВОСТИ ГОНКИ: %s выйграл гонку и получил $%d",name,reward);
							BroadCast(COLOR_WHITE, string);
							format(string, sizeof(string), "НОВОСТИ ГОНКИ: %s Установил рекорд %s. Время: %d:%d:%d", name,CurrentRace,cmins,csecs,cmils);
							BroadCast(COLOR_WHITE, string);
						}
						else
						{
							format(string, sizeof(string), "НОВОСТИ ГОНКИ: %s выйграл гонку и получил $%d. Время: %d:%d:%d", name,reward,cmins,csecs,cmils);
							BroadCast(COLOR_WHITE, string);
						}
						SetPlayerCriminal(playerid,-1, "Уличные гонки",1,1);
						gPlayerMission[playerid] = 2;
						BetWinner(playerid,1);
					}
					else if (gRaceFin == 2)
					{
						DisablePlayerCheckpoint(playerid);
						PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
						if (gdebug){print("DEBUG RACE OVER");}
						reward = preward/2;
						GetPlayerName(playerid, name, sizeof(name));
						SafeGivePlayerMoney(playerid, reward);
						PlayerPlayMusic(playerid);
						format(string, sizeof(string), "~g~2nd place~n~~w~Your winnings are ~n~~g~$%d", reward);
						GameTextForPlayerRus(playerid, string, 5000, 6);
						RaceTime[playerid] = Gtickcount;
						pos3time = RaceTime[playerid] - StartTime[playerid];
						new splittime = pos3time - pos1time;
						ConvertTicks(splittime);
						GetPlayerName(playerid, name, sizeof(name));
						format(string, sizeof(string), "НОВОСТИ ГОНКИ: %s пришел вторым и получил $%d. Время: +%d:%d:%d", name,reward,cmins,csecs,cmils);
						BroadCast(COLOR_WHITE, string);
					}
					else if (gRaceFin == 3)
					{
						CheckpointReset();
						PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
						if (gdebug){print("DEBUG RACE OVER");}
						reward = preward/3;
						GetPlayerName(playerid, name, sizeof(name));
						SafeGivePlayerMoney(playerid, reward);
						PlayerPlayMusic(playerid);
						format(string, sizeof(string), "~g~3rd place~n~~w~Your winnings are ~n~~g~$%d", reward);
						GameTextForPlayerRus(playerid, string, 5000, 6);
						RaceTime[playerid] = Gtickcount;
						pos2time = RaceTime[playerid] - StartTime[playerid];
						new splittime = pos2time - pos1time;
						ConvertTicks(splittime);
						GetPlayerName(playerid, name, sizeof(name));
						format(string, sizeof(string), "НОВОСТИ ГОНКИ: %s пришел третьим и получил $%d. Время: +%d:%d:%d", name,reward,cmins,csecs,cmils);
						BroadCast(COLOR_WHITE, string);
						KillTimer(raceendtimer);
						RaceEnd();
					}
				}
		    }
		case CHECKPOINT_CARDROP:
		    {
				PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
				GameTextForPlayerRus(playerid, "~w~Get out of the ~n~~y~Car", 5000, 1);
				MissionActive = 11;
				if (gdebug){print("DEBUG MissionActive = 11");}
		    }
		case CHECKPOINT_HOME:
		    {
				PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
				DisablePlayerCheckpoint(playerid);
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
				GameTextForPlayerRus(playerid, "~w~You are~n~~y~Home", 5000, 1);
		    }
		case CHECKPOINT_DM:
		    {
				gFightLeader++;
				gFighters++;
				gPlayerFighter[playerid] = 1;
				DisablePlayerCheckpoint(playerid);
				gTeam[playerid] = 4;
				SetPlayerToTeamColor(playerid);
				SetSpawnInfo(playerid, 1, PlayerInfo[playerid][pModel], gRandomDMSpawns[1][0], gRandomDMSpawns[1][1], gRandomDMSpawns[1][2], 1.0, -1, -1, -1, -1, -1, -1);
				if(gFighters >= 21)
				{
					gFighters = 2;
				}
				else
				{
					SetPlayerPos(playerid, gRandomDMSpawns[gFighters][0], gRandomDMSpawns[gFighters][1], gRandomDMSpawns[gFighters][2]); // Warp the player
				}
				if(dmweapon > 0)
				{
					ResetPlayerWeapons(playerid);
					GivePlayerWeapon(playerid, dmweapon, 999);
				}
				//SetPlayerWorldBounds(playerid,gDMWbounds[0],gDMWbounds[1],gDMWbounds[2],gDMWbounds[3]);
				SetPlayerFacingAngle(playerid, 270.0);
				SetPlayerInterior(playerid,0);
				PlayerInfo[playerid][pInt] = 0;
				TogglePlayerControllable(playerid, 0);
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
				format(string, sizeof(string), "~r~DeathMatch~n~~w~Waiting for more players");
				GameTextForPlayerRus(playerid, string, 5000, 3);
				if (gFightLeader == 2)
				{
					SetTimer("DMDelay", racedelay, 0);
					format(string, sizeof(string), "SMS: %d секунд до начала дезматча, Отправитель: MOLE (555)",racedelay/1000);
					RingTone[playerid] = 20;
					BroadCast(COLOR_YELLOW, string);
				}
		    }
  		default:
	        {
				if ((gTeam[playerid]) != 2)
				{
					PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
					format(string, sizeof(string), "~w~Defend This ~n~Position");
					GameTextForPlayerRus(playerid, string, 5000, 1);
					if (gdebug){print("DEBUG crims protect");}
			    }
				if ((gTeam[playerid]) == 2)
				{
					PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
					format(string, sizeof(string), "~w~Patrol This Area~n~ For Suspects");
					GameTextForPlayerRus(playerid, string, 5000, 1);
					if (gdebug){print("DEBUG cops protect");}
			    }
	        }
	}
	return 1;
}

public RaceDebug(playerid)
{
	new string[256];
	format(string, sizeof(string), "gRaceFin(%d) gRaceMid(%d) gRaceMid2(%d) gRaceEnd(%d) gLaps(%d) RaceInfo[rLaps](%d) LapCount[playerid](%d)",gRaceFin,gRaceMid,gRaceMid2,gRaceEnd,gLaps,RaceInfo[rLaps],LapCount[playerid]);
	BroadCast(COLOR_WHITE, string);
}

public RaceEnd()
{
	CheckpointReset();
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			StartTime[i] = 0;
			LapCount[i] = 0;
		}
	}
	gRaceFin = 0;
	gRaceMid = 0;
	gRaceMid2 = 0;
	gRaceEnd = 0;
	gLaps = 0;
	BroadCast(COLOR_WHITE, "RACENEWS: ::: Race Over :::");
	MissionActive = 8;
	if (gdebug){print("DEBUG MissionActive = 8");}
}

public RaceDelay()
{
	if (gdebug >=1){printf("RaceDelay ");}
	new string[32];
	format(string, sizeof(string), "~r~Ready");
	new gdelay=1000;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if ((gPlayerCheckpointStatus[i] == CHECKPOINT_SRA) && gTeam[i] >= 3)
			{
				GameTextForPlayerRus(i, string, gdelay, 6);
				PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			}
		}
	}
	SetTimer("RaceDelayr", gdelay, 0);
	return 1;
}
public RaceDelayr()
{
	if (gdebug >=1){printf("RaceDelayr");}
	new string[32];
	format(string, sizeof(string), "~y~Set");
	new hdelay=1000;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if ((gPlayerCheckpointStatus[i] == CHECKPOINT_SRA) && (gTeam[i] >= 3))
			{
				GameTextForPlayerRus(i, string, hdelay, 6);
				PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			}
		}
	}
	SetTimer("RaceDelayg", hdelay, 0);
	return 1;
}
public RaceDelayg()
{
	if (gdebug >=1){printf("RaceDelayg");}
	new rdelay=1000;
	new string[32];
	format(string, sizeof(string), "~g~GO");
	gLaps = 0;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (gTeam[i] >= 3)
			{
				if (gPlayerCheckpointStatus[i] == CHECKPOINT_SRA)
				{
					GameTextForPlayerRus(i, string, rdelay, 6);
					PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
					SetPlayerCheckpointFixed(i,rsx,rsy,rsz, 16.0);
					gPlayerCheckpointStatus[i] = CHECKPOINT_SRA;
				}
				else
				{
					DisablePlayerCheckpoint(i);
					gPlayerCheckpointStatus[i] = CHECKPOINT_NONE;
				}
			}
		}
	}
	SetAllCopCheckpoint(rm2x,rm2y,rm2z, 8.0);
	MissionActive = 7;
	if (gdebug){print("DEBUG MissionActive = 7");}
	return 1;
}

public DMDelay()
{
	if (gdebug >=1){printf("DMDelay ");}
	new string[32];
	gFightLeader = 1000;
	format(string, sizeof(string), "~r~Ready");
	new gdelay=1000;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		DisablePlayerCheckpoint(i);
		if(IsPlayerConnected(i))
		{
			if (gPlayerFighter[i] == 1)
			{
				GameTextForPlayerRus(i, string, gdelay, 6);
				PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			}
		}
	}
	SetTimer("DMDelayr", gdelay, 0);
	return 1;
}
public DMDelayr()
{
	if (gdebug >=1){printf("DMDelayr");}
	new string[32];
	format(string, sizeof(string), "~y~Set");
	new hdelay=1000;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (gPlayerFighter[i] == 1)
			{
				GameTextForPlayerRus(i, string, hdelay, 6);
				PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
			}
		}
	}
	SetTimer("DMDelayg", hdelay, 0);
	return 1;
}
public DMDelayg()
{
	if (gdebug >=1){printf("DMDelayg");}
	new rdelay=1000;
	new string[32];
	format(string, sizeof(string), "~g~FIGHT");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if (gPlayerFighter[i] == 1)
			{
				GameTextForPlayerRus(i, string, rdelay, 6);
				PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
				TogglePlayerControllable(i, 1);
			}
		}
	}
	MissionActive = 13;
	if (gdebug){print("DEBUG MissionActive = 13");}
	return 1;
}

public DMDetect()
{
	if(gFightLeader == 1000)
	{
		dmtimer++;
		PlayerInArena();
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) == 1 && gPlayerFighter[i] == 1)
			{
				if(dmtime-dmtimer == 60)
				{
					GameTextForPlayerRus(i, "~r~One Minuite Remaining", 5000, 1);
				}
			}
		}
		if(dmtimer == dmtime)
		{
			new ename[MAX_PLAYER_NAME];
			new string[256];
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) == 1 && gPlayerFighter[i] == 1 || IsPlayerConnected(i) == 1 && TVMode[i]>11 && TVMode[i]<20)
				{
					if(TVMode[i]>11 && TVMode[i]<20)
					{
						TVMode[i] = 0;
						Spectate[i] = -1;
					}
					TogglePlayerControllable(i, 0);
					if(IsPlayerConnected(DmHiPlayer) == 1)
					{
						GetPlayerPos(DmHiPlayer, DmeCam[0], DmeCam[1], DmeCam[2]);
						DmeCam[3] = DmeCam[0];
						DmeCam[4] = DmeCam[1]+2;
						DmeCam[5] = DmeCam[2]+0.2;
						DmeCam[2] = DmeCam[2]+0.6;
						SetPlayerFacingAngle(DmHiPlayer, 0.0);
						RewardCalc(DmHiPlayer,1000,10000);
						GetPlayerName(DmHiPlayer, ename, sizeof(ename));
						format(string, sizeof(string), "~r~DeathMatch Over~n~~b~Winner~n~~w~%s~n~kills:%d~n~~g~Prize:$%d", ename,DmHiScore, reward);
					}
					else
					{
						format(string, sizeof(string), "~r~DeathMatch Over~n~~b~No Winner");
						DmeCam[0] = gRandomDMSpawns[1][0];
						DmeCam[1] = gRandomDMSpawns[1][1];
						DmeCam[2] = gRandomDMSpawns[1][2];
						DmeCam[3] = DmeCam[0];
						DmeCam[4] = DmeCam[1];
						DmeCam[5] =DmeCam[2]+30;
					}
					DMEndCam(i,string);
				}
			}
		}
		if(dmtimer == dmtime+10)
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) == 1)
				{
					if(Spectate[i] == -1)
					{
						TogglePlayerControllable(i, 1);
						SetPlayerInterior(i,Unspec[i][sPint]);
						PlayerInfo[i][pInt] = Unspec[i][sPint];
						PlayerInfo[i][pLocal] = Unspec[i][sLocal];
						Unspec[i][sLocal] = -1;
						SetSpawnInfo(i, 1, PlayerInfo[i][pModel], Unspec[i][sPx],  Unspec[i][sPy], Unspec[i][sPz]-1.0, 1.0, -1, -1, -1, -1, -1, -1);
						//SetPlayerPos(i, Unspec[i][sPx], Unspec[i][sPy], Unspec[i][sPz]);
						gTeam[i] = PlayerInfo[i][pTeam];
						SetPlayerToTeamColor(i);
						SpawnPlayer(i);
						Spectate[i] = -1;
					}
					if(gPlayerFighter[i] == 1)
					{
						if(PlayerInfo[i][pTeam] != 3)
						{
							gTeam[i] = PlayerInfo[i][pTeam];
							SetPlayerToTeamColor(i);
						}
						gPlayerFighter[i] = 0;
						DmScore[i] = 0;
						TogglePlayerControllable(i, 1);
						SpawnPlayer(i);
						SetPlayerRandomSpawn(i);
					}
				}
			}
		}
		if(dmtimer == dmtime+11)
		{
			if(IsPlayerConnected(DmHiPlayer) == 1)
			{
				new ename[MAX_PLAYER_NAME];
				new string[256];
				PlayerPlaySound(DmHiPlayer, 1058, 0.0, 0.0, 0.0);
				GetPlayerName(DmHiPlayer, ename, sizeof(ename));
				SafeGivePlayerMoney(DmHiPlayer, reward);
				format(string, sizeof(string), "~g~JOB COMPLETE~n~~w~Your cut was~n~~g~$%d", reward);
				PlayerPlayMusic(DmHiPlayer);
				GameTextForPlayerRus(DmHiPlayer, string, 5000, 6);
				format(string, sizeof(string), "%s выйграл дезматч с %d убийствами и получил $%d", ename,DmHiScore, reward);
				BroadCast(COLOR_YELLOW, string);
				//SetPlayerPos(DmHiPlayer,gRandomDMSpawns[0][0],gRandomDMSpawns[0][1],gRandomDMSpawns[0][2]);
				if(PlayerInfo[DmHiPlayer][pTeam] != 1 && PlayerInfo[DmHiPlayer][pTeam] != 2)
				{
					SetPlayerCriminal(DmHiPlayer,-1, "Mass Murder",1,1);
					gPlayerMission[DmHiPlayer] = 4;
				}
				else
				{
					PlayerInfo[DmHiPlayer][pWA] = PlayerInfo[DmHiPlayer][pWA]+5;
					if(PlayerInfo[DmHiPlayer][pWA] >= 20)
					{
						PlayerInfo[DmHiPlayer][pExp]++;
						PlayerInfo[DmHiPlayer][pWA] = PlayerInfo[DmHiPlayer][pWA]-20;
						SendClientMessageRus(DmHiPlayer, COLOR_YELLOW, "Вы получаете бонус: +1 опыт");
					}
				}
				BetWinner(DmHiPlayer,2);
			}
			gFighters = 0;
			gFightLeader = 0;
			MissionActive = 0;
			if (gdebug){print("DEBUG MissionActive = 0");}
			DmHiScore = 0;
			DmHiPlayer = -1;
			dmtimer = 0;
		}
	}
}

public DMEndCam(playerid,string[])
{
	GameTextForPlayerRus(playerid, string, 5000, 6);
	SetPlayerCameraPos(playerid,DmeCam[3], DmeCam[4], DmeCam[5]);
	SetPlayerCameraLookAt(playerid,DmeCam[0], DmeCam[1], DmeCam[2]);
}

public DMScoreCalc()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1 && gPlayerFighter[i] == 1)
		{
			if(gPlayerFighter[i] == 1)
			{
				new tmp1 = DmScore[i];
				if(tmp1 > DmHiScore)
				{
					DmHiScore = tmp1;
					DmHiPlayer = i;
				}
			}
		}
	}
	return 1;
}


public OnPlayerDropCashBox(playerid)
{
	if (gdebug >=1){printf("OnPlayerDropCashBox %d",playerid);}
	new string[128];
	new dname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, dname, sizeof(dname));
	format(string, sizeof(string), ".: %s потерял кейс! :.", dname);
	BroadCast(COLOR_RED, string);
	GetPlayerPos(playerid, cwx, cwy, cwz);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if (IsPlayerConnected(i))
		{
				SetPlayerCheckpointFixed(i,cwx,cwy,cwz, 1.0);
				gPlayerCheckpointStatus[i] = CHECKPOINT_PICKUP;
		}
	}
	MissionActive = 3;
	if (gdebug){print("DEBUG MissionActive = 3;");}
	return 1;
}

public RewardCalc(playerid,min,max)
{
	reward = (min + (random(max-min)) + ((numplayers + PlayerInfo[playerid][pLevel]) *1000)); //minimum 1000 max 10000 + activeplayers x 1000
	printf("DEBUG RewardCalc = (Random(min=%d)(max=%d))(numplayers=%d)(PlayerInfo[playerid][pLevel]=%d) Total =%d",min,max,numplayers,PlayerInfo[playerid][pLevel],reward);
}

public CheckpointReset()
{
	if (gdebug >= 1){printf("DEBUG CheckpointReset()");}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			DisablePlayerCheckpoint(i);
			gPlayerLapStatus[i] = 0;
			gPlayerCheckpointStatus[i] = CHECKPOINT_NONE;
		}
	}

}

public JobGive(playerid)
{
	if (gdebug >= 1){printf("DEBUG JobGive (%d)",playerid);}
	if(MissionActive == 1)
	{

		SendClientMessageRus(playerid, COLOR_YELLOW, objstore);
		SetPlayerCheckpointFixed(playerid,cwx, cwy, cwz, 1.4);
		gPlayerCheckpointStatus[playerid] = CHECKPOINT_PICKUP;
		RingTone[playerid] = 20;
		SendClientMessageRus(playerid, COLOR_WHITE, "ПОДСКАЗКА: Едь на красный марке и укради кейс.");
		GameTextForPlayerRus(playerid, "~w~Маркер установлен ~n~~r~CashBox", 5000, 1);
		return 1;
	}
	if(MissionActive == 5)
	{
		format(objstore, sizeof(objstore), "SMS: Скоро начнется гонка на красном маркере, Отправитель: MOLE (555)");
		SendClientMessageRus(playerid, COLOR_YELLOW, objstore);
		RingTone[playerid] = 20;
		SetPlayerCheckpointFixed(playerid,rsx,rsy,rsz, 16.0);
		gPlayerCheckpointStatus[playerid] = CHECKPOINT_SR1START;
		SendClientMessageRus(playerid, COLOR_WHITE, "ПОДСКАЗКА: Отправляйся на красный маркер и жди начала гонки.");
		GameTextForPlayerRus(playerid, "~w~Маркер установлен ~n~~r~StreetRace", 5000, 1);
		return 1;
	}
	if(MissionActive == 9)
	{
		SendClientMessageRus(playerid, COLOR_YELLOW, objstore);
		RingTone[playerid] = 20;
		SetVehicleParamsForPlayerEx(stealcar,playerid,1,0);
		new Float:px, Float:py, Float:pz;
		GetVehiclePos(stealcar, px, py, pz);
		DisablePlayerCheckpoint(playerid);
		SetPlayerCheckpointFixed(playerid, px, py, pz, 4.0);
		SendClientMessageRus(playerid, COLOR_WHITE, "ПОДСКАЗКА: Отправляйся на красный маркер и угони машину.");
		GameTextForPlayerRus(playerid, "~w~Маркер установлен ~n~~y~The Car", 5000, 1);
		return 1;
	}
	else
	{
		SendClientMessageRus(playerid, COLOR_YELLOW, "SMS: У меня ничего нет для тебя сейчас, Отправитель: MOLE (555)");
		RingTone[playerid] = 20;
	}
	return 1;
}

public SetAllPlayerCheckpoint(Float:allx, Float:ally, Float:allz, Float:radi, num)
{
	if (gdebug >= 1){printf("DEBUG SetAllPlayerCheckpoint()");}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			SetPlayerCheckpointFixed(i,allx,ally,allz, radi);
			if (num != -1)
			{
				gPlayerCheckpointStatus[i] = num;
			}
		}
	}

}

public SetAllCopCheckpoint(Float:allx, Float:ally, Float:allz, Float:radi)
{
	if (gdebug >= 1){printf("DEBUG SetAllCopCheckpoint()");}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			if(gTeam[i] == 2)
			{
				DisablePlayerCheckpoint(i);
				SetPlayerCheckpointFixed(i,allx,ally,allz, radi);
			}
		}
	}
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if (gdebug >=1){printf("OnPlayerStateChange %d %d %d",playerid, newstate, oldstate);}
	if((newstate == 2 || newstate == 3) && nocarcash)
	{
		if (gPlayerCheckpointStatus[playerid] == CHECKPOINT_DROPOFF)
		{
			if (gdebug){print("DEBUG test6");}
			DisablePlayerCheckpoint(playerid);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
			new check = gPlayerCheckpointStatus[playerid];
			if (gdebug){printf("DEBUG check %d",check);}
			OnPlayerDropCashBox(playerid);
		}
	}
	if(newstate == PLAYER_STATE_ONFOOT)
	{
		TelePos[playerid][0] = 0.0;
		TelePos[playerid][1] = 0.0;
		if(gTeam[playerid] >= 4 && LapCount[playerid] > 0)
		{
			new count;
			new string[256];
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && gTeam[i] == 2 && CrimInRange(50.0, playerid,i))
				{
					count = 1;
					format(string, sizeof(string), "~p~Racer ~w~Jailed~n~Bonus Paycheck ~n~~g~$%d", 10000);
					GameTextForPlayerRus(i, string, 5000, 1);
					SafeGivePlayerMoney(i, 10000);
					PlayerPlaySound(i, 1058, 0.0, 0.0, 0.0);
					PlayerInfo[i][pWA] = PlayerInfo[i][pWA]+2;
					if(PlayerInfo[i][pWA] >= 20)
					{
						PlayerInfo[i][pExp]++;
						PlayerInfo[i][pWA] = 0;
						SendClientMessageRus(i, COLOR_YELLOW, "Вы получаете бонус: +1 опыт");
					}
				}
			}
			if(count == 1)
			{
				new name [MAX_PLAYER_NAME];
				GetPlayerName(playerid, name, sizeof(name));
				format(string, sizeof(string), "НОВОСТИ ГОНКИ: %s был пойман полицией.", name);
				BroadCast(COLOR_WHITE, string);
				SetPlayerInterior(playerid,6);
				LapCount[playerid] = 0;
				PlayerInfo[playerid][pInt] = 6;
				SetPlayerPos(playerid,264.395200,77.564040,1001.039000);
				SendClientMessageRus(playerid, COLOR_GRAD1,"Вы были арестованы за участие в уличных гонках (введите /time).");
				PlayJailSound(1153 , 1154, 2000,264.395200, 77.564040, 1001.039000);
				JailTime[playerid] = 60;
			}
		}
	}
	if(newstate == PLAYER_STATE_DRIVER) //buggy dont finnish
	{
		new newcar = GetPlayerVehicleID(playerid);
		new oldcar = gLastCar[playerid];
		new housecar = PlayerInfo[playerid][pPhousekey]+1;
		TelePos[playerid][0] = 0.0;
		TelePos[playerid][1] = 0.0;
		if (gdebug >=1){printf("oldcar %d, newcar %d",oldcar,newcar);}
		if(IsATruck(newcar))
		{
			new string[256];
			format(string, sizeof(string), "Компоненты: %d/%d", PlayerHaul[newcar][pLoad],PlayerHaul[newcar][pCapasity]);
			SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
			SendClientMessageRus(playerid, COLOR_WHITE, "ИНФО: Вы можете развозить компоненты по бизнесам");
			SendClientMessageRus(playerid, COLOR_WHITE, "ИНФО: Доступные команды: /load /buycomp /sellcomp /bestsale");
		}
		if(newcar >= 71 && newcar <= 74)
		{
			if (HireCar[playerid] != newcar)
			{
				new string[128];
				format(string, sizeof(string), "~w~You can Rent this car~n~Cost:~g~$%d~n~~w~To rent type ~g~/rentcar~w~~n~to get out type ~r~/exit",BizzInfo[8][bEntcost]);
				TogglePlayerControllable(playerid, 0);
				GameTextForPlayerRus(playerid, string, 5000, 3);
			}

		}
		if(newcar >= 75 && newcar <= 77)
		{
			if (HireCar[playerid] != newcar)
			{
				new string[128];
				format(string, sizeof(string), "~w~You can Rent this car~n~Cost:~g~$%d~n~~w~To rent type ~g~/rentcar~w~~n~to get out type ~r~/exit",BizzInfo[9][bEntcost]);
				TogglePlayerControllable(playerid, 0);
				GameTextForPlayerRus(playerid, string, 5000, 3);
			}

		}
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(GetPlayerState(i) == 2 && GetPlayerVehicleID(i) == newcar && i != playerid)
				{
					RemovePlayerFromVehicle(i);
					TogglePlayerControllable(i, 1); //hirecar bug
				}
			}
		}
		/*
		if (HireCar[playerid] != -1 && gTeam[playerid] <= 2) //works on lock command now
		{
			if(newcar != housecar && oldcar != 301)
			{
				gLastDriver[oldcar] = -1;
				gCarLock[oldcar] = 0;
				UnLockCar(oldcar);
				HireCar[playerid] = newcar;
			}
		}
		*/
		if(oldcar != -1)
		{
			if((housecar != oldcar && oldcar != 0) && (HireCar[playerid] != oldcar && newcar != housecar))
			{
				if(gLastDriver[oldcar] == playerid && oldcar != newcar)
				{
					gLastDriver[oldcar] = -1;
					gCarLock[oldcar] = 0;
					UnLockCar(oldcar);
				}
			}
		}
		if(gTeamCarLock[newcar] == 1)
		{
			gTeamCarLock[newcar] = 0;
			UnLockCar(newcar);
		}
		gLastCar[playerid] = newcar;
		if (gdebug >=1){printf("gLastCar[playerid](%d)",gLastCar[playerid]);}
		gLastDriver[newcar] = playerid;
		if ((newcar == stealcar) && (MissionActive == 9))
		{
			RewardCalc(playerid,1000,10000);
		}
		if((newcar == stealcar) && (MissionActive >= 9))
		{
			if (gdebug){print("DEBUG TEST3");}
			if (gTeam[playerid] >= 3 && MissionActive >= 9)
			{
				if (gdebug){print("DEBUG TEST4");}
				new name[MAX_PLAYER_NAME];
				new string[256];
				GetPlayerName(playerid, name, sizeof(name));
				GetVehiclePos(stealcardest, cwx, cwy, cwz);
				GameTextForPlayerRus(playerid, "~w~Now get the ~y~Car~n~~w~to the ~r~Buyer", 5000, 1);
				format(string, sizeof(string), "%s угнал машину стоимостью $%d", name,reward);
				BroadCast(COLOR_YELLOW, string);
				CheckpointReset();
				SetAllPlayerCheckpoint(cwx, cwy, cwz, 16.0, 0);
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_CARDROP;
				MissionActive = 10;
				if (gdebug){print("DEBUG MissionActive = 10;");}
				if (gTeam[playerid] == 3)
				{
					SetPlayerCriminal(playerid,-1, "Угон авто",0,0);
				}
				gSuperCop = playerid;
				OpenDoors();
			}
			if (gTeam[playerid] == 2 && MissionActive >= 10)
			{
				if (gdebug){print("DEBUG TEST6");}
				new name[MAX_PLAYER_NAME];
				new string[256];
				GetPlayerName(playerid, name, sizeof(name));
				cwx = 1539.1;
				cwy = -1668.0;
				cwz = 5.8;
				GameTextForPlayerRus(playerid, "~w~Return the ~y~car ~n~~w~to the ~r~Pound", 5000, 1);
				format(string, sizeof(string), "Офицер %s конфисковал угнанную машину стоимостью $%d", name,reward);
				BroadCast(COLOR_YELLOW, string);
				CheckpointReset();
				SetAllPlayerCheckpoint(cwx, cwy, cwz, 16.0, 0);
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_CARDROP;
				gSuperCop = playerid;
				MissionActive = 10;
				if (gdebug){print("DEBUG MissionActive = 10;");}
			}
		}
	}
	return 1;
}

public HireCost(carid)
{
	switch (carid)
	{
		case 69:
		{
			return 90000; //bullit
		}
		case 70:
		{
			return 130000; //infurnus
		}
		case 71:
		{
			return 100000; //turismo
		}
		case 72:
		{
			return 80000;
		}
		case 73:
		{
			return 70000;
		}
		case 74:
		{
			return 60000;
		}
	}
	return 0;
}

/*public CarCheck()
{
	if (gdebug >= 3){printf("DEBUG CarCheck()");}
	//new foundowner = -1;
	for(new c = 1; c < 254; c++)
	{

		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				if(HireCar[i] == c && foundowner == -1)
				{
					foundowner = i;
				}
			}
		}
		if(foundowner == -1 && c > 34 && gCarLock[c] == 1)
		{
			gCarLock[c] = 0;
			UnLockCar(c);
		}

		if (gLastDriver[c] == -1)
		{
			CarRespawn(c);
		}
		if (gLastDriver[c] >= 300)
		{
			gLastDriver[c]++;
		}
		//foundowner = -1;
	}
	return 1;
}
*/

public CarInit()
{
	if (gdebug >= 3){printf("DEBUG CarCheck()");}
	for(new c = 1; c <= MAX_VEHICLES; c++)
	{
 		gLastDriver[c] = -1;
		gTeamCarLock[c] = 0;
		CreatedCars[c] = 0;
		//gCarLock[c] = 0;
	}
	return 1;
}

public CarTow(carid)
{
	if (gdebug >= 1){printf("DEBUG CarRespawn(%d)",carid);}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(IsPlayerInVehicle(i, carid) || HireCar[i] == carid)
			{
				gLastDriver[carid] = -1;
				return 0;
			}
		}
	}
	// 		CreateVehicle(HouseInfo[h][hVec], HouseCarSpawns[h][0], HouseCarSpawns[h][1], HouseCarSpawns[h][2], HouseCarSpawns[h][3], HouseInfo[h][hVcol1], HouseInfo[h][hVcol2], -1);
	// 				SetVehiclePos(plo,plocx,plocy+4, plocz);
	SetVehiclePos(carid,HouseCarSpawns[carid-1][0], HouseCarSpawns[carid-1][1], HouseCarSpawns[carid-1][2]);
	SetVehicleZAngle(carid, HouseCarSpawns[carid-1][3]);
	return 1;
}

public CarRespawn(carid)
{
	if (gdebug >= 1){printf("DEBUG CarRespawn(%d)",carid);}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(IsPlayerInVehicle(i, carid) || HireCar[i] == carid)
			{
				gLastDriver[carid] = -1;
				return 0;
			}
		}
	}
	SetVehicleToRespawn(carid);
	gLastDriver[carid] = -1;
	TeamLockReset(carid);
	return 1;
}

public LockCar(carid)
{
	if (gdebug >= 1){printf("DEBUG LockCar(%d)",carid);}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(stealcar == carid)
			{
				SetVehicleParamsForPlayerEx(carid,i,1,1);
			}
			else
			{
				SetVehicleParamsForPlayerEx(carid,i,0,1);
			}
		}
	}
}

public UnLockCar(carid)
{
	if (gdebug >= 1){printf("DEBUG UnLockCar(%d)",carid);}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(stealcar == carid)
			{
				SetVehicleParamsForPlayerEx(carid,i,1,0);
			}
			else
			{
				if(!IsAPlane(carid))
				{
					SetVehicleParamsForPlayerEx(carid,i,0,0);
				}
			}
		}
	}
}

public OpenDoors()
{
	if (gdebug >= 1){printf("DEBUG OpenDoors()");}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			SetVehicleParamsForPlayerEx(stealcar,i,1,0);
		}
	}
}

public TeamCarLockInit()
{
	if (gdebug >= 1){printf("DEBUG TeamCarLockInit()");}
	for(new c = 0; c <= 200; c++)
	{
		if ((c >= 23) && (c <= 48))
		{
			gTeamCarLock[c] = 2;
		}
		if ((c >= 49) && (c <= 51))
		{
			gTeamCarLock[c] = 4;
		}
		if ((c >= 52) && (c <= 200))
		{
			gTeamCarLock[c] = 1;
		}
		gCarLock[c] = 0;
	}
	return 1;
}

public TeamLockReset(carid)
{
	if (gdebug >= 3){printf("DEBUG TeamLockReset(carid)",carid);}
	if (!teamcarlock)
	{
		return 0;
	}
	//DebugPrint("TeamLockReset()",0,0,1);
	if ((carid >= 23) && (carid <= 48))
	{
		gTeamCarLock[carid] = 2;
	}
	if ((carid >= 49) && (carid <= 51))
	{
		gTeamCarLock[carid] = 4;
	}
	if ((carid >= 52) && (carid <= 200))
	{
		gTeamCarLock[carid] = 1;
	}
	gCarLock[carid] = 0;
	return 1;
}

public InitLockDoors(playerid)
{
	if (gdebug >= 1){printf("DEBUG1 InitLockDoors(%d)",playerid);}
	new c=1;
	while (c <= MAX_VEHICLES)
	{
		if (gCarLock[c] == 1)
		{
			if (gdebug >= 1){printf("DEBUG3 InitLockDoors(%d)car(%d)",playerid,c);}
			SetVehicleParamsForPlayerEx(c,playerid,0,1);
		}
		c++;
	}
	if(PLicence[playerid] != 1)
	{
		SetVehicleParamsForPlayerEx(66,playerid,0,1);
		SetVehicleParamsForPlayerEx(67,playerid,0,1);
		SetVehicleParamsForPlayerEx(68,playerid,0,1);
		SetVehicleParamsForPlayerEx(69,playerid,0,1);
		SetVehicleParamsForPlayerEx(70,playerid,0,1);
		SetVehicleParamsForPlayerEx(71,playerid,0,1);
	}
	return 1;
}
public TeamLockDoors(playerid)
{
	if (gdebug >= 1){printf("DEBUG TeamLockDoors(%d)",playerid);}
	new c =0;
	while (c <= 200)
	{
		c++;
		if (gCarLock[c] == 1)
		{
			SetVehicleParamsForPlayerEx(c,playerid,0,1);
		}
		if (gTeamCarLock[c] == 1)
		{
			if(gTeam[playerid] != 1 && gTeam[playerid] != 3)
			{
				SetVehicleParamsForPlayerEx(c,playerid,0,1);
			}
			else
			{
				SetVehicleParamsForPlayerEx(c,playerid,0,0);
			}
		}
		if (gTeamCarLock[c] == 2)
		{
			if(gTeam[playerid] != 2)
			{
				SetVehicleParamsForPlayerEx(c,playerid,0,1);
			}
			else
			{
				SetVehicleParamsForPlayerEx(c,playerid,0,0);
			}
		}
		if (gTeamCarLock[c] == 4)
		{
			if(gTeam[playerid] != 4)
			{
				SetVehicleParamsForPlayerEx(c,playerid,0,1);
			}
			else
			{
				SetVehicleParamsForPlayerEx(c,playerid,0,0);
			}
		}
		if (gTeamCarLock[c] == 0)
		{
				SetVehicleParamsForPlayerEx(c,playerid,0,0);
		}
	}
	return 1;
}

public DebugPrint(string[],value1,value2,type)
{
	new formated[256];
	if (gdebug >= 2 && type == 1)
	{
		format(formated, sizeof(formated), "Debug:(%d) %s: %d",value1,string,value2);
		printf("%s",formated);
		SendClientMessageToAllRus(COLOR_WHITE, formated);
	}
	return 1;
}


public OnPlayerExitVehicle(playerid, vehicleid)
{
	if (gdebug >= 1){printf("DEBUG OnPlayerExitVehicle(%d, %d)", playerid, vehicleid);}
	if (GetPlayerState(playerid) == 1)
	{
		return 1;
	}
	new string[256];
	new ename[MAX_PLAYER_NAME];
	if (vehicleid == stealcar && (MissionActive == 10 || MissionActive == 101))
	{
		GameTextForPlayerRus(playerid, "~w~Get back in the ~n~~r~Car", 5000, 1);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				SetVehicleParamsForPlayerEx(stealcar,i,1,0);
			}
		}
		if (playerid == gSuperCop)
		{
			gSuperCop = -1;
		}
		CheckpointReset();
		MissionActive = 101;
		if (gdebug){print("DEBUG MissionActive = 101");}
	}
	else if (gTeam[playerid] >= 4 && vehicleid == stealcar && MissionActive == 11 && gSuperCop == playerid)
	{
		if (gdebug){print("DEBUG CHECKPOINT_CARDROP");}
		PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
		GetPlayerName(playerid, ename, sizeof(ename));
		SafeGivePlayerMoney(playerid, reward);
		preward = reward;
		format(string, sizeof(string), "~g~CAR DELIVERED~n~~w~Your were paid ~n~~g~$%d", reward);
		PlayerPlayMusic(playerid);
		GameTextForPlayerRus(playerid, string, 5000, 6);
		format(string, sizeof(string), "%s продал угнанную машину за $%d.", ename,reward);
		BroadCast(COLOR_YELLOW, string);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				SetVehicleParamsForPlayerEx(stealcar,i,0,0);
			}
		}
		SetVehicleParamsForPlayerEx(stealcar,playerid,0,0);
		if (playerid != gPublicEnemy)
		{
			gPlayerMission[playerid] = 3;
			SetPlayerCriminal(playerid,-1, "Угон авто",1,1);
		}
		stealcar = -1;
		CheckpointReset();
		SetVehicleToRespawn(stealcar);
		MissionActive = 12;
		if (gdebug){print("DEBUG MissionActive = 12");}
	}
	else if (gTeam[playerid] == 2 && vehicleid == stealcar && MissionActive == 11 && gSuperCop == playerid)
	{
		if (gdebug){print("DEBUG CHECKPOINT_CARDROP");}
		PlayerPlaySound(playerid, 1058, 0.0, 0.0, 0.0);
		GetPlayerName(playerid, ename, sizeof(ename));
		SafeGivePlayerMoney(playerid, reward);
		PlayerInfo[playerid][pHW]++;
		if(PlayerInfo[playerid][pHW] >= 3)
		{
			PlayerInfo[playerid][pExp]++;
			PlayerInfo[playerid][pHW] = 0;
			SendClientMessageRus(playerid, COLOR_YELLOW, "Вы получаете бонус: +1 опыт");
		}
		format(string, sizeof(string), "~g~CAR RETURNED~n~~w~Bonus Paycheck ~n~~g~$%d", reward);
		PlayerPlayMusic(playerid);
		GameTextForPlayerRus(playerid, string, 5000, 6);
		format(string, sizeof(string), "Офицер %s вернул угнанную машину стоимостью $%d.", ename,reward);
		BroadCast(COLOR_YELLOW, string);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i))
			{
				SetVehicleParamsForPlayerEx(stealcar,i,0,0);
			}
		}
		SetVehicleParamsForPlayerEx(stealcar,playerid,0,0);
		stealcar = -1;
		CheckpointReset();
		SetVehicleToRespawn(stealcar);
		MissionActive = 12;
		if (gdebug){print("DEBUG MissionActive = 12");}
	}
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	new string[128];
	/*
	if (gPlayerAccount[playerid] == 0)
	{
		GameTextForPlayerRus(playerid, "~w~Welcome.~n~In order to play you need to create an account, type ~n~~r~/regnick (password)~w~ to register", 20000, 3);
		SetPlayerCameraPos(playerid,1460.0, -1324.0, 287.2);
		SetPlayerCameraLookAt(playerid,1374.5, -1291.1, 239.0);
		return 1;
	}
	*/
	PlayerInfo[playerid][pModel] = Peds[classid][0];
	//printf("pppm = %d classid == %d Peds[classid][0]= %d",PlayerInfo[playerid][pModel],classid,Peds[classid][0]);
	if(classid >= 260)
	{
		format(string, sizeof(string), "~b~SAPD~n~ ~r~Objective~w~: Retain Law");
		GameTextForPlayerRus(playerid,string,3500,6);
		DisablePlayerCheckpoint(playerid);
		gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
	}
	else if (classid >= 255 && classid <= 259)
	{
			format(string, sizeof(string), "~g~PARAMEDIC~n~~r~Objective~w~: Save Life");
			GameTextForPlayerRus(playerid,string,3500,6);
	}
	else if (classid >= 1 && classid <= 3)
	{
			format(string, sizeof(string), "~p~BALLAS~n~~r~Objective~w~: Chaos");
			GameTextForPlayerRus(playerid,string,3500,6);
	}
	else if (classid >= 4 && classid <= 6)
	{
			format(string, sizeof(string), "~p~GROVE~n~~r~Objective~w~: Chaos");
			GameTextForPlayerRus(playerid,string,3500,6);
	}
	else if (classid >= 7 && classid <= 9)
	{
			format(string, sizeof(string), "~p~VAGOS~n~~r~Objective~w~: Chaos");
			GameTextForPlayerRus(playerid,string,3500,6);
	}
	else if (classid >= 10 && classid <= 12)
	{
			format(string, sizeof(string), "~p~AZTECAS~n~~r~Objective~w~: Chaos");
			GameTextForPlayerRus(playerid,string,3500,6);
	}
	else if (classid >= 13 && classid <= 15)
	{
			format(string, sizeof(string), "~p~NANG~n~~r~Objective~w~: Chaos");
			GameTextForPlayerRus(playerid,string,3500,6);
	}
 	else if (classid >= 16 && classid <= 21)
	{
			format(string, sizeof(string), "~p~MAFIA~n~~r~Objective~w~: Chaos");
			GameTextForPlayerRus(playerid,string,3500,6);
	}
	else if (classid >= 22 && classid <= 24)
	{
			format(string, sizeof(string), "~p~RUSSIAN MAFIA~n~~r~Objective~w~: Chaos");
			GameTextForPlayerRus(playerid,string,3500,6);
	}
	else if (classid >= 25 && classid <= 27)
	{
			format(string, sizeof(string), "~p~TRIADS~n~~r~Objective~w~: Chaos");
			GameTextForPlayerRus(playerid,string,3500,6);
	}
	else if (classid >= 28 && classid <= 30)
	{
			format(string, sizeof(string), "~p~BIKERS~n~~r~Objective~w~: Chaos");
			GameTextForPlayerRus(playerid,string,3500,6);
	}
	else
	{
		format(string, sizeof(string), "~g~CIVILIAN~n~~r~Objective~w~: Live Life");
		GameTextForPlayerRus(playerid,string,3500,6);
	}
	SetPlayerTeamFromClass(playerid,classid);
	SetupPlayerForClassSelection(playerid);
	return 1;
}

public SetupPlayerForClassSelection(playerid)
{
	switch (gTeam[playerid])
	{
		case TEAM_BLUE:
		{
			SetPlayerInterior(playerid,5);
			SetPlayerPos(playerid,323.4,305.6,999.1);
			SetPlayerFacingAngle(playerid, 90.0);
			SetPlayerCameraPos(playerid,323.4-1.5,305.6,999.1+0.7);
			SetPlayerCameraLookAt(playerid,323.4,305.6,999.1+0.7);

		}
		case TEAM_CYAN:
		{
			SetPlayerInterior(playerid,0);
			SetPlayerPos(playerid,1187.0,-1295.8,13.5);
			SetPlayerFacingAngle(playerid, 270.0);
			SetPlayerCameraPos(playerid,1187.0+1.5,-1295.8,13.5+0.7);
			SetPlayerCameraLookAt(playerid,1187.0,-1295.8,13.5+0.7);
		}
		case TEAM_GREEN:
		{
			SetPlayerInterior(playerid,3);
			SetPlayerPos(playerid,-2654.4,1424.2,912.4);
			SetPlayerFacingAngle(playerid, 90.0);
			SetPlayerCameraPos(playerid,-2654.4-1.5,1424.2,912.4+0.7);
			SetPlayerCameraLookAt(playerid,-2654.4,1424.2,912.4+0.7);
		}
		default:
		{
			/*
			SetPlayerInterior(playerid,2);
			SetPlayerPos(playerid,1216.699000,-6.416779,1001.328000);
			SetPlayerFacingAngle(playerid, 90.0);
			SetPlayerCameraPos(playerid,1216.699000-1.5,-6.416779,1001.328000+0.7);
			SetPlayerCameraLookAt(playerid,1216.699000,-6.416779,1001.328000+0.7);
			*/
			SetPlayerInterior(playerid,3);
			SetPlayerPos(playerid,-2654.4,1424.2,912.4);
			SetPlayerFacingAngle(playerid, 90.0);
			SetPlayerCameraPos(playerid,-2654.4-1.5,1424.2,912.4+0.7);
			SetPlayerCameraLookAt(playerid,-2654.4,1424.2,912.4+0.7);
		}
	}
}

//---------------------------------------------------------

public SetPlayerTeamFromClass(playerid,classid)
{
	if (gdebug >= 2){printf("DEBUG SetPlayerTeamFromClass(%d, %d)", playerid, classid);}
	if(classid >= 260)
	{
		gTeam[playerid] = TEAM_BLUE;
		PlayerInfo[playerid][pTeam] = 2;
	}
	else if (classid >= 255 && classid <= 259)
	{
		gTeam[playerid] = TEAM_CYAN;
		PlayerInfo[playerid][pTeam] = 1;
	}
	else if (classid >= 1 && classid <= 3)
	{
		gTeam[playerid] = TEAM_BALLAS;
		PlayerInfo[playerid][pTeam] = 5;
	}
	else if (classid >= 4 && classid <= 6)
	{
		gTeam[playerid] = TEAM_GROVE;
		PlayerInfo[playerid][pTeam] = 6;
	}
	else if (classid >= 7 && classid <= 9)
	{
		gTeam[playerid] = TEAM_VAGOS;
		PlayerInfo[playerid][pTeam] = 7;
	}
	else if (classid >= 10 && classid <= 12)
	{
		gTeam[playerid] = TEAM_AZTECAS;
		PlayerInfo[playerid][pTeam] = 8;
	}
	else if (classid >= 13 && classid <= 15)
	{
		gTeam[playerid] = TEAM_NANG;
		PlayerInfo[playerid][pTeam] = 9;
	}
 	else if (classid >= 16 && classid <= 21)
	{
		gTeam[playerid] = TEAM_MAFIA;
		PlayerInfo[playerid][pTeam] = 11;
	}
	else if (classid >= 22 && classid <= 24)
	{
		gTeam[playerid] = TEAM_RMAFIA;
		PlayerInfo[playerid][pTeam] = 12;
	}
	else if (classid >= 25 && classid <= 27)
	{
		gTeam[playerid] = TEAM_TRIADS;
		PlayerInfo[playerid][pTeam] = 13;
	}
	else if (classid >= 28 && classid <= 30)
	{
		gTeam[playerid] = TEAM_BIKERS;
		PlayerInfo[playerid][pTeam] = 14;
	}
	else
	{
	    gTeam[playerid] = TEAM_GREEN;
	    PlayerInfo[playerid][pTeam] = 3;
	}
}

//---------------------------------------------------------

public SetPlayerCriminal(playerid,declare,reason[],pe,flash)
{
	if (gdebug >= 1){printf("DEBUG SetPlayerCriminal(%d, %d ,%s ,%d ,%d)", playerid,declare,reason,pe,flash);}
	new turned[MAX_PLAYER_NAME];
	new turner[MAX_PLAYER_NAME];
	new turnmes[128];
	//new tmpstring[32];
	//format(tmpstring, sizeof(tmpstring), reason);
	strmid(PlayerCrime[playerid][pAccusedof], reason, 0, strlen(reason), 255);
	GetPlayerName(playerid, turned, sizeof(turned));
	if (declare == -1)
	{
		//print("DEBUG: 4");
		format(turner, sizeof(turner), "Unknown");
		strmid(PlayerCrime[playerid][pVictim], turner, 0, strlen(turner), 255);
	}
	else
	{
		//print("DEBUG: 5");
		GetPlayerName(declare, turner, sizeof(turner));
		strmid(PlayerCrime[playerid][pVictim], turner, 0, strlen(turner), 255);
		strmid(PlayerCrime[declare][pBplayer], turned, 0, strlen(turned), 255);
		strmid(PlayerCrime[declare][pAccusing], reason, 0, strlen(reason), 255);
	}
	if (pe == 1)
	{
		if (gPublicEnemy != -1 && gPublicEnemy != playerid)
		{
			OffTheHook();
			KillTimer(offhook);
	    }
		gPublicEnemy = playerid;
		format(turnmes, sizeof(turnmes), "SMS: %s, Теперь вы Враг Народа Номер 1 за %s. Избегайте смерти %d минут, Отправитель: MOLE (555)",turned,reason,petime/60000);
		RingTone[playerid] = 20;
		SendClientMessageRus(playerid, COLOR_YELLOW, turnmes);
		format(cbjstore, sizeof(cbjstore), "HQ: Всем подразделениям - поймать Врага Народа Номер 1 %s",turned);
		SendTeamBeepMessage(2, COLOR_DBLUE, cbjstore);
		format(turnmes, sizeof(turnmes), "HQ: разыскивается за %s. У вас %d минут.",reason,petime/60000);
		format(objstore, sizeof(objstore), "SMS: Убей этого сосунка %s и забери его бабки, Отправитель: MOLE (555)",turned);
		SendTeamMessage(2, COLOR_DBLUE, turnmes);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && gPublicEnemy != i && gTeam[i] >= 3)
			{
				SendClientMessageRus(i, COLOR_YELLOW, objstore);
				RingTone[i] = 20;
			}
		}
		SendTeamMessage(2, COLOR_WHITE, "ПОДСКАЗКА: Убей игрока помеченного мигающим маркером, чтобы получить выйгрыш.");
		offhook = SetTimer("OffTheHook", petime, 0);

	}
    else
    {
		if ((gTeam[playerid]) == 1)//med kill criminal
		{
			format(turnmes, sizeof(turnmes), "ВНИМАНИЕ: %s, полиция охотится за тобой за %s. Привилегии медика больше не действуют. Доложил: %s",turned,reason,turner);
		}
		else
		{
			format(turnmes, sizeof(turnmes), "ВНИМАНИЕ: %s, полиция охотится за тобой за %s. Доложил: %s",turned,reason,turner);
		}
		gTeam[playerid] = 4;//lawbreaker
		if (flash)
		{
			FlashTime[playerid] = 10;
		}
		else
		{
			SetPlayerToTeamColor(playerid);
		}
		SendClientMessageRus(playerid, COLOR_RED, turnmes);
	}
	print("DEBUG: 5");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && (gTeam[i]) == 2 && gPublicEnemy != playerid)
		{
			format(cbjstore, sizeof(turnmes), "HQ: Всем подразделениям внимание! Доложил: %s",turner);
			SendClientMessageRus(i, TEAM_BLUE_COLOR, cbjstore);
			format(cbjstore, sizeof(turnmes), "HQ: Преступление: %s, Подозреваемый: %s",reason,turned);
			SendClientMessageRus(i, TEAM_BLUE_COLOR, cbjstore);
		}
	}
}
//---------------------------------------------------------

public SetPlayerFree(playerid,declare,reason[],pe,flash)
{
	if (gdebug >= 1){printf("DEBUG SetPlayerFree(%d, %d ,%d ,%d)", playerid,declare,pe,flash);}
	ClearCrime(playerid);
	new turned[MAX_PLAYER_NAME];
	new turner[MAX_PLAYER_NAME];
	new turnmes[128];
	new crbjstore[128];
	if (declare == -1)
	{
		format(turner, sizeof(turner), "911");
	}
	else
	{
		GetPlayerName(declare, turner, sizeof(turner));
	}
	GetPlayerName(playerid, turned, sizeof(turned));
	if (PlayerInfo[playerid][pTeam] == 1)
	{
		gTeam[playerid] = 1;
	}
	else
	{
		gTeam[playerid] = 3;
	}
	if (flash)
	{
		FlashTime[playerid] = 10;
	}
	else
	{
		SetPlayerToTeamColor(playerid);
	}
	format(turnmes, sizeof(turnmes), "SMS: %s, Вы больше не преступник, т.к. %s, Отправитель: MOLE (555)",turned,reason);
	RingTone[playerid] = 20;
	SendClientMessageRus(playerid, COLOR_YELLOW, turnmes);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) && (gTeam[i]) == 2)
		{
			format(crbjstore, sizeof(crbjstore), "HQ: Всем подразделениям! %s более не разыскивается",turner);
			SendClientMessageRus(i, COLOR_DBLUE, crbjstore);
			format(crbjstore, sizeof(crbjstore), "HQ: %s был обработан, %s",turned,reason);
			SendClientMessageRus(i, COLOR_DBLUE, crbjstore);
		}
	}
}
public OffTheHook()
{
	if (gdebug >= 1){printf("DEBUG OffTheHook()");}
	new hookoff[128];
	new offhookn[MAX_PLAYER_NAME];
	new mission = gPlayerMission[gPublicEnemy];
	if(mission == 4)
	{
		mission = random(3)+1;
	}
	switch (mission)
	{
		case 1:
		{
			PlayerInfo[gPublicEnemy][pCB]++;
			if(PlayerInfo[gPublicEnemy][pCB] >= 4)
			{
				PlayerInfo[gPublicEnemy][pExp]++;
				PlayerInfo[gPublicEnemy][pCB] = 0;
				SendClientMessageRus(gPublicEnemy, COLOR_YELLOW, "Вы получаете бонус: +1 опыт");
			}
		}
		case 2:
		{
			PlayerInfo[gPublicEnemy][pSR]++;
			if(PlayerInfo[gPublicEnemy][pSR] >= 4)
			{
				PlayerInfo[gPublicEnemy][pExp]++;
				PlayerInfo[gPublicEnemy][pSR] = 0;
				SendClientMessageRus(gPublicEnemy, COLOR_YELLOW, "Вы получаете бонус: +1 опыт");
			}
		}
		case 3:
		{
			PlayerInfo[gPublicEnemy][pHW]++;
			if(PlayerInfo[gPublicEnemy][pHW] >= 4)
			{
				PlayerInfo[gPublicEnemy][pExp]++;
				PlayerInfo[gPublicEnemy][pHW] = 0;
				SendClientMessageRus(gPublicEnemy, COLOR_YELLOW, "Вы получаете бонус: +1 опыт");
			}
		}
		default:
		{
		}
	}
	SetPlayerToTeamColor(gPublicEnemy);
	GetPlayerName(gPublicEnemy, offhookn, sizeof(offhookn));
	format(hookoff, sizeof(hookoff), "НОВОСТИ: %s ушел от полиции и больше не Враг Народа Номер 1",offhookn);
	RingTone[gPublicEnemy] = 20;
	SendClientMessageToAllRus(COLOR_PURPLE, hookoff);
	gPublicEnemy = -1;
	return 1;
}

public CellPhoneTimer()
{
	if (gdebug >= 3){printf("DEBUG CellPhoneTimer()");}
	new string[64];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
			if(CellTime[i] > 0)
			{
				if (CellTime[i] == cchargetime)
				{
					CellTime[i] = 1;
					if(Mobile[Mobile[i]] == i)
					{
						CallCost[i] = CallCost[i]+callcost;
					}
				}
				//printf("CellTime %d %d",i,CellTime[i]);
				CellTime[i] = CellTime[i] +1;
				//printf("callers line %d called %d caller %d",Mobile[Mobile[i]],Mobile[i],i);
				if (Mobile[Mobile[i]] == -1 && CellTime[i] == 5)
				{
					new called[MAX_PLAYER_NAME];
					GetPlayerName(Mobile[i], called, sizeof(called));
					format(string, sizeof(string), "* У %s звонит телефон.", called);
					RingTone[Mobile[i]] = 10;
					ProxDetector(30.0, Mobile[i], string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
			}
			if(CellTime[i] == 0 && CallCost[i] > 0)
			{
				format(string, sizeof(string), "~w~The call cost~n~~r~$%d",CallCost[i]);
				SafeGivePlayerMoney(i, -CallCost[i]);
				BizzInfo[10][bTakings] += CallCost[i];
				GameTextForPlayerRus(i, string, 5000, 1);
				CallCost[i] = 0;
			}

		}
	}
}

public SetPlayerFlash()
{
//if (gdebug >= 2){printf("DEBUG SetPlayerFlash()");}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if (gPublicEnemy == i || gSuperCop == i)
		{
			FlashTime[i] = 3;
		}
		if(IsPlayerConnected(i) == 1 && FlashTime[i] > 0)
		{
			//printf("flashtime %d %d",i,FlashTime[i]);
			FlashTime[i]--;
			SetPlayerToTeamColorFlash(i);
		}
	}
	SetTimer("SetPlayerFlashRev", 1000, 0);
	return 1;
}

public SetPlayerFlashRev()
{
//if (gdebug >= 2){printf("DEBUG SetPlayerFlashRev()");}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1 && FlashTime[i] > 1)
		{
			FlashTime[i]--;
			//printf("flashtime %d %d",i,FlashTime[i]);
			SetPlayerColor(i,COLOR_INVIS); // invisibil
		}
	}
	SetTimer("SetPlayerFlash", 1000, 0);
	return 1;
}


public RingToner()
{
//if (gdebug >= 2){printf("DEBUG RingToner()");}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1 && RingTone[i] != 6 && RingTone[i] != 0 && RingTone[i] < 11)
		{
			//printf("RingTone %d %d",i,RingTone[i]);
			RingTone[i] = RingTone[i] -1;
			PlayerPlaySound(i, 1138, 0.0, 0.0, 0.0);
		}
		if(IsPlayerConnected(i) == 1 && RingTone[i] == 6)
		{
			RingTone[i] = RingTone[i] -1;
		}
		if(IsPlayerConnected(i) == 1 && RingTone[i] == 20)
		{
			//printf("RingTone %d %d",i,RingTone[i]);
			RingTone[i] = RingTone[i] -1;
			PlayerPlaySound(i, 1139, 0.0, 0.0, 0.0);
		}
	}
	//RingTonerRev();
	SetTimer("RingTonerRev", 200, 0);
	return 1;
}

public RingTonerRev()
{
//if (gdebug >= 2){printf("DEBUG SetPlayerFlashRev()");}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1  && RingTone[i] != 5 && RingTone[i] != 0 && RingTone[i] < 10)
		{
			RingTone[i] = RingTone[i] -1;
			PlayerPlaySound(i, 1137, 0.0, 0.0, 0.0);
		}
		if(IsPlayerConnected(i) == 1 && RingTone[i] == 5)
		{
			RingTone[i] = RingTone[i] -1;
		}
		if(IsPlayerConnected(i) == 1 && RingTone[i] == 19)
		{
			//printf("RingTone %d %d",i,RingTone[i]);
			PlayerPlaySound(i, 1139, 0.0, 0.0, 0.0);
			RingTone[i] = 0;
		}
	}
	SetTimer("RingToner", 500, 0);
	return 1;
}

public SetPlayerUnjail()
{
	if (gdebug >= 3){printf("DEBUG SetPlayerUnjail()");}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1 && JailTime[i] < 0)
		{
			JailTime[i]++;
			//printf("JailTime %d %d",i,JailTime[i]);
		}
		if(IsPlayerConnected(i) == 1 && JailTime[i] > 0)
		{
			JailTime[i]--;
			//printf("JailTime %d %d",i,JailTime[i]);
		}
		if(IsPlayerConnected(i) == 1 && JailTime[i] == 10)
		{
			new string[128];
			//printf("JailTime %d %d",i,JailTime[i]);
			FlashTime[i] = 0;
			SetPlayerPos(i,268.3,77.4,1001.0);
			SendClientMessageRus(i, COLOR_GRAD1,"Вы заплатили свой долг обществу.");
			format(string, sizeof(string), "~g~Freedom~n~~w~Try to be a better citizen");
			GameTextForPlayerRus(i, string, 5000, 1);
			PlayJailSound(1165 , 1166, 1000,264.395200, 77.564040, 1001.039000);
		}
	}
}

public VoteKickTimer()
{
	if (gdebug >= 3){printf("DEBUG VoteKickTimer()");}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1 && VoteKick[i] > 0)
		{
			VoteKick[i]++;
			//printf("VoteKick %d VoteKick[%d] KickVote[%d]",i,VoteKick[i],KickVote[i]);
			if(IsPlayerConnected(i) == 1 && VoteKick[i] == 20)
			{
				if(KickVote[i] >= numplayers/4)
				{
					new string[128];
					new accused[MAX_PLAYER_NAME];
					GetPlayerName(i, accused, sizeof(accused));
					format(string, sizeof(string), "ГОЛОСОВАНИЕ УСПЕШНО: %s будет кикнут с сервера",accused);
					BroadCast(COLOR_RED,string);
					ClearVote(i);
					Kick(i);
				}
				else
				{
					new string[128];
					new accused[MAX_PLAYER_NAME];
					GetPlayerName(i, accused, sizeof(accused));
					format(string, sizeof(string), "ГОЛОСОВАНИЕ ПРОВАЛЕНО: %s не будет кикнут",accused);
					BroadCast(COLOR_RED,string);
					ClearVote(i);
				}
			}
		}
	}
}

public ClearVote(kickedid)
{
	KickVote[kickedid] = 0;
	VoteKick[kickedid] = 0;
	for(new j = 0; j < MAX_PLAYERS; j++)
	{
		if(IsPlayerConnected(j) == 1 && LastVote[j] == kickedid)
		{
			LastVote[j] = -1;
		}
	}
}



public SetPlayerWeapons(playerid)
{
	if (gdebug >= 1){printf("DEBUG SetPlayerWeapons(%d)",playerid);}
	//ResetPlayerWeapons(playerid);
	if(PlayerInfo[playerid][pGun1] == 0)
	{
    PlayerInfo[playerid][pGun1] = 24;
    }
	if (PlayerInfo[playerid][pGun1] > 0)
	{
		GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun1], PlayerInfo[playerid][pAmmo1]);
	}
	if(gTeam[playerid] == 1)
	{
		GivePlayerWeapon(playerid, 4, 0);
	}
	if(gTeam[playerid] == 2)
	{
		GivePlayerWeapon(playerid, 3, 0);
		//GivePlayerWeapon(playerid, 41, 500); //spray
	}
	if(gTeam[playerid] >= 3)
	{
		GivePlayerWeapon(playerid, 32, 100);
	}
	if (PlayerInfo[playerid][pGun2] > 0)
	{
		GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun2], PlayerInfo[playerid][pAmmo2]);
	}
	if (PlayerInfo[playerid][pGun3] > 0)
	{
		GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun3], PlayerInfo[playerid][pAmmo3]);
	}
	if (PlayerInfo[playerid][pGun4] > 0)
	{
		GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun4], PlayerInfo[playerid][pAmmo4]);
	}
	if (PlayerInfo[playerid][pGun5] > 0)
	{
		GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun5], PlayerInfo[playerid][pAmmo5]);
	}
	if (PlayerInfo[playerid][pGun6] > 0)
	{
		GivePlayerWeapon(playerid, PlayerInfo[playerid][pGun6], PlayerInfo[playerid][pAmmo6]);
	}
}

public PrintSBizInfo(playerid,targetid)
{
	new coordsstring[256];
	SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
	format(coordsstring, sizeof(coordsstring),"*** %s ***",SBizzInfo[targetid][sbDiscription]);
	SendClientMessageRus(playerid, COLOR_WHITE,coordsstring);
	format(coordsstring, sizeof(coordsstring), "Закрыт: %d Стоимость входа: $%d Баланс: $%d", SBizzInfo[targetid][sbLock], SBizzInfo[targetid][sbEntcost], SBizzInfo[targetid][sbTakings]);
	SendClientMessageRus(playerid, COLOR_GRAD1,coordsstring);
	format(coordsstring, sizeof(coordsstring), "Продукты: %d/%d Компоненты: %d/%d", SBizzInfo[targetid][sbProd],SBizzInfo[targetid][sbProdCap],SBizzInfo[targetid][sbComp],SBizzInfo[targetid][sbCompCap]);
	SendClientMessageRus(playerid, COLOR_GRAD2,coordsstring);
	format(coordsstring, sizeof(coordsstring), "Продуктов на 1 компонент: %d Закупочная цена: $%d",SBizzInfo[targetid][sbProdCost],SBizzInfo[targetid][sbPayComp]);
	SendClientMessageRus(playerid, COLOR_GRAD3,coordsstring);
	format(coordsstring, sizeof(coordsstring), "Стоимость продукта: $%d",(SBizzInfo[targetid][sbPayComp]/SBizzInfo[targetid][sbProdCost]));
	SendClientMessageRus(playerid, COLOR_GRAD4,coordsstring);
	SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
}

public PrintBizInfo(playerid,targetid)
{
	new coordsstring[256];
	SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
	format(coordsstring, sizeof(coordsstring),"*** %s ***",BizzInfo[targetid][bDiscription]);
	SendClientMessageRus(playerid, COLOR_WHITE,coordsstring);
	format(coordsstring, sizeof(coordsstring), "Закрыт: %d Стоимость входа: $%d Till: $%d", BizzInfo[targetid][bLock], BizzInfo[targetid][bEntcost], BizzInfo[targetid][bTakings]);
	SendClientMessageRus(playerid, COLOR_GRAD1,coordsstring);
	format(coordsstring, sizeof(coordsstring), "Продукты: %d/%d Компоненты: %d/%d", BizzInfo[targetid][bProd],BizzInfo[targetid][bProdCap],BizzInfo[targetid][bComp],BizzInfo[targetid][bCompCap]);
	SendClientMessageRus(playerid, COLOR_GRAD2,coordsstring);
	format(coordsstring, sizeof(coordsstring), "Продуктов на 1 компонент: %d Закупочная цена: $%d",BizzInfo[targetid][bProdCost],BizzInfo[targetid][bPayComp]);
	SendClientMessageRus(playerid, COLOR_GRAD3,coordsstring);
	format(coordsstring, sizeof(coordsstring), "Стоимость продукта: $%d Процент стоимости: %d%",(BizzInfo[targetid][bPayComp]/BizzInfo[targetid][bProdCost]), BizzInfo[targetid][bPriceMod]);
	SendClientMessageRus(playerid, COLOR_GRAD4,coordsstring);
	SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
}

public PrintPlayerWeapons(playerid,targetid)
{
	if (gdebug >= 1){printf("DEBUG PrintPlayerWeapons(%d %d)",playerid,targetid);}
	new cash =  GetPlayerMoney(targetid);
	//new admin = PlayerInfo[targetid][pAdmin];
	new level = PlayerInfo[targetid][pLevel];
	new exp = PlayerInfo[targetid][pExp];
	new gun1 = PlayerInfo[targetid][pGun1];
	new gun2 = PlayerInfo[targetid][pGun2];
	new gun3 = PlayerInfo[targetid][pGun3];
	new gun4 = PlayerInfo[targetid][pGun4];
	new gun5 = PlayerInfo[targetid][pGun5];
	new gun6 = PlayerInfo[targetid][pGun6];
	new ammo1 = PlayerInfo[targetid][pAmmo1];
	new ammo2 = PlayerInfo[targetid][pAmmo2];
	new ammo3 = PlayerInfo[targetid][pAmmo3];
	new ammo4 = PlayerInfo[targetid][pAmmo4];
	new ammo5 = PlayerInfo[targetid][pAmmo5];
	new ammo6 = PlayerInfo[targetid][pAmmo6];
	new kills = PlayerInfo[targetid][pKills];
	new pcb = PlayerInfo[targetid][pCB];
	new phw = PlayerInfo[targetid][pHW];
	new psr = PlayerInfo[targetid][pSR];
	new pwa = PlayerInfo[targetid][pWA] ;
	new ppen = PlayerInfo[targetid][pPEN];
	new pnumber = PlayerInfo[targetid][pPnumber];
	new account = PlayerInfo[targetid][pAccount];
	new nxtlevel = PlayerInfo[targetid][pLevel]+1;
	new expamount = nxtlevel*levelexp;
	new costlevel = nxtlevel*levelcost;//10k for testing purposes
	new housekey = PlayerInfo[targetid][pPhousekey];
	new bizkey = PlayerInfo[targetid][pPbiskey];
	new intir = PlayerInfo[playerid][pInt];
	new local = PlayerInfo[playerid][pLocal];
	new Float:shealth = PlayerInfo[targetid][pSHealth];
	new Float:health;
	new name[MAX_PLAYER_NAME];
	new sgun1[20];
	new sgun2[20];
	new sgun3[20];
	new sgun4[20];
	new sgun5[20];
	new sgun6[20];
	GetWeaponName(gun1, sgun1, 20);
	GetWeaponName(gun2, sgun2, 20);
	GetWeaponName(gun3, sgun3, 20);
	GetWeaponName(gun4, sgun4, 20);
	GetWeaponName(gun5, sgun5, 20);
	GetWeaponName(gun6, sgun6, 20);
	GetPlayerName(targetid, name, sizeof(name));
	GetPlayerHealth(targetid,health);
	new Float:px,Float:py,Float:pz;
	GetPlayerPos(targetid, px, py, pz);
	new coordsstring[256];
	//format(coordsstring, sizeof(coordsstring), "%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%.1f,%.1f,%.1f,%.1f,%.1f", PlayerInfo[playerid][pPassword], cash, admin, level,gun1,gun2,gun3,gun4,gun5,gun6,ammo1,ammo2,ammo3,ammo4,ammo5,ammo6,shealth,health, px, py, pz);
	//SendClientMessageRus(playerid, TEAM_BLUE_COLOR, coordsstring);
	SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
	format(coordsstring, sizeof(coordsstring),"*** %s ***",name);
	SendClientMessageRus(playerid, COLOR_WHITE,coordsstring);
	format(coordsstring, sizeof(coordsstring), "Уровень: [%d] Здоровье: %.1f Наличные: [$%d] Денег в банке: [$%d] Телефон: [%d]", level, shealth+50, cash, account, pnumber);
	SendClientMessageRus(playerid, COLOR_GRAD1,coordsstring);
	format(coordsstring, sizeof(coordsstring), "Оружие: %s %s %s %s %s %s", sgun1,sgun2,sgun3,sgun4,sgun5,sgun6);
	SendClientMessageRus(playerid, COLOR_GRAD2,coordsstring);
	format(coordsstring, sizeof(coordsstring), "Боезапас1: [%d] Боезапас2: [%d] Боезапас3: [%d] Боезапас4: [%d] Боезапас5: [%d] Боезапас6: [%d]", ammo1,ammo2,ammo3,ammo4,ammo5,ammo6);
	SendClientMessageRus(playerid, COLOR_GRAD3,coordsstring);
	if (stats)
	{
		format(coordsstring, sizeof(coordsstring), "Кейсы: [%d/4] Автомобили: [%d/4] Гонки: [%d/4] Сервисы: [%d/20] ",pcb,phw,psr,pwa);
		SendClientMessageRus(playerid, COLOR_GRAD4,coordsstring);
		format(coordsstring, sizeof(coordsstring), "Убийства: [%d/30] Убийства ВНН1: [%d/4]  След. уровень: [$%d] Опыт: [%d/%d]",kills,ppen,costlevel,exp,expamount);
		SendClientMessageRus(playerid, COLOR_GRAD5,coordsstring);
		/*
		if(expamount <= exp)
		{
			SendClientMessageRus(playerid, COLOR_RED,coordsstring);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD5,coordsstring);
		}
		*/
	}
	if ( PlayerInfo[playerid][pAdmin] >= 1)
	{
		format(coordsstring, sizeof(coordsstring), "Дом: [%d] Бизнес: [%d] Аренд. авто: [%d] Интерьер: [%d] Локация: [%d]", housekey,bizkey,HireCar[targetid],intir,local);
		SendClientMessageRus(playerid, COLOR_GRAD6,coordsstring);
	}
	//SendClientMessageRus(playerid, COLOR_GRAD6,"Hint: use /level <playerid> to see another players stats");
	SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
}
//---------------------------------------------------------

public SetPlayerToTeamColor(playerid)
{
	if(gTeam[playerid] == TEAM_GREEN)
	{
		SetPlayerColor(playerid,TEAM_GREEN_COLOR); // red
	}
	else if(gTeam[playerid] == TEAM_BLUE)
	{
	    SetPlayerColor(playerid,TEAM_BLUE_COLOR); // blue
	}
	else if(gTeam[playerid] == TEAM_ORANGE)
	{
	    SetPlayerColor(playerid,TEAM_ORANGE10_COLOR); // blue
	}
	else if(gTeam[playerid] == TEAM_BALLAS)
	{
	    SetPlayerColor(playerid,TEAM_BALLAS10_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_GROVE)
	{
	    SetPlayerColor(playerid,TEAM_GROVE10_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_VAGOS)
	{
	    SetPlayerColor(playerid,TEAM_VAGOS10_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_AZTECAS)
	{
	    SetPlayerColor(playerid,TEAM_AZTECAS10_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_NANG)
	{
	    SetPlayerColor(playerid,TEAM_NANG10_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_RIFA)
	{
	    SetPlayerColor(playerid,TEAM_RIFA10_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_MAFIA)
	{
	    SetPlayerColor(playerid,TEAM_MAFIA10_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_RMAFIA)
	{
	    SetPlayerColor(playerid,TEAM_RMAFIA10_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_TRIADS)
	{
	    SetPlayerColor(playerid,TEAM_TRIADS10_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_BIKERS)
	{
	    SetPlayerColor(playerid,TEAM_BIKERS10_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_CYAN)
	{
	    SetPlayerColor(playerid,TEAM_CYAN_COLOR); // blue
	}
}

public SetPlayerToTeamColorFlash(playerid)
{
	if(gTeam[playerid] == TEAM_GREEN)
	{
		SetPlayerColor(playerid,TEAM_GREEN_COLOR); // red
	}
	else if(gTeam[playerid] == TEAM_BLUE)
	{
	    SetPlayerColor(playerid,TEAM_BLUE_COLOR); // blue
	}
	else if(gTeam[playerid] == TEAM_ORANGE)
	{
	    SetPlayerColor(playerid,TEAM_ORANGE_COLOR); // blue
	}
	else if(gTeam[playerid] == TEAM_BALLAS)
	{
	    SetPlayerColor(playerid,TEAM_BALLAS_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_GROVE)
	{
	    SetPlayerColor(playerid,TEAM_GROVE_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_VAGOS)
	{
	    SetPlayerColor(playerid,TEAM_VAGOS_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_AZTECAS)
	{
	    SetPlayerColor(playerid,TEAM_AZTECAS_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_NANG)
	{
	    SetPlayerColor(playerid,TEAM_NANG_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_RIFA)
	{
	    SetPlayerColor(playerid,TEAM_RIFA_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_MAFIA)
	{
	    SetPlayerColor(playerid,TEAM_MAFIA_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_RMAFIA)
	{
	    SetPlayerColor(playerid,TEAM_RMAFIA_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_TRIADS)
	{
	    SetPlayerColor(playerid,TEAM_TRIADS_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_BIKERS)
	{
	    SetPlayerColor(playerid,TEAM_BIKERS_COLOR); // purple
	}
	else if(gTeam[playerid] == TEAM_CYAN)
	{
	    SetPlayerColor(playerid,TEAM_CYAN_COLOR); // blue
	}
}

//---------------------------------------------------------

public GameModeInitExitFunc()
{
	if (gdebug >= 1){printf("DEBUG GameModeInitExitFunc()");}
	new string[128];
	format(string, sizeof(string), "Traveling...");
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			DisablePlayerCheckpoint(i);
			gPlayerCheckpointStatus[i] = CHECKPOINT_NONE;
			if (gdebug){print("DEBUG CHECKPOINT_NONE3");}
			GameTextForPlayerRus(i, string, 4000, 5);
			if (gdebug){printf("DEBUG %s", string);}
			SetPlayerCameraPos(i,1460.0, -1324.0, 287.2);
			SetPlayerCameraLookAt(i,1374.5, -1291.1, 239.0);
			PlayerUpdate(i);
			gPlayerLogged[i] = 0;
		}
	}
	SetTimer("GameModeExitFunc", 4000, 0);
	return 1;
}

public GameModeExitFunc()
{
	KillTimer(synctimer);
	KillTimer(newmistimer);
	KillTimer(unjailtimer);
	KillTimer(playertimer);
	KillTimer(cartimer);
	KillTimer(celltimer);
	GameModeExit();
}

//--------------------------------Config--------------------------------------------------------------
public LoadConfig()
{
	print(" ");
	print("Loading Config......");
	if (gdebug){print("DEBUG is on");}
	new valtmp[128];
	new File: file = fopen("pen01.cfg", io_read);
	fread(file, valtmp);strmid(motd, valtmp, 0, strlen(valtmp)-1, 255);
	fread(file, valtmp);GetVal(valtmp);fow = RetVal;
	fread(file, valtmp);GetVal(valtmp);radardist = RetVal;
	fread(file, valtmp);GetVal(valtmp);radarfreq = RetVal;
	fread(file, valtmp);GetVal(valtmp);addtimer = RetVal*1000;
	fread(file, valtmp);GetVal(valtmp);stats = RetVal;
	fread(file, valtmp);GetVal(valtmp);dollah = RetVal;
	fread(file, valtmp);GetVal(valtmp);realtime = RetVal;
	fread(file, valtmp);GetVal(valtmp);timeshift = RetVal;
	fread(file, valtmp);GetVal(valtmp);wtime = RetVal;
	fread(file, valtmp);GetVal(valtmp);gRoundTime = RetVal*60000;
	fread(file, valtmp);GetVal(valtmp);cashbox = RetVal;
	fread(file, valtmp);GetVal(valtmp);streetrace = RetVal;
	fread(file, valtmp);GetVal(valtmp);hotwire = RetVal;
	fread(file, valtmp);GetVal(valtmp);levelcost = RetVal;
	fread(file, valtmp);GetVal(valtmp);basedcost = RetVal;
	fread(file, valtmp);GetVal(valtmp);deathcost = RetVal;
	fread(file, valtmp);GetVal(valtmp);suecost = RetVal;
	fread(file, valtmp);GetVal(valtmp);paycheck = RetVal;
	fread(file, valtmp);GetVal(valtmp);jobdelay = RetVal;
	fread(file, valtmp);GetVal(valtmp);petime = RetVal*60000;
	fread(file, valtmp);GetVal(valtmp);realchat = RetVal;
	fread(file, valtmp);GetVal(valtmp);forceteam = RetVal;
	fread(file, valtmp);GetVal(valtmp);cchargetime = RetVal;
	fread(file, valtmp);GetVal(valtmp);callcost = RetVal;
	fread(file, valtmp);GetVal(valtmp);txtcost = RetVal;
	fread(file, valtmp);GetVal(valtmp);jailtime = RetVal;
	fread(file, valtmp);GetVal(valtmp);intrate = RetVal;
	fread(file, valtmp);GetVal(valtmp);teamcarlock = RetVal;
	fread(file, valtmp);GetVal(valtmp);levelexp = RetVal;
	fread(file, valtmp);GetVal(valtmp);nocasino = RetVal;
	fread(file, valtmp);GetVal(valtmp);automission = RetVal;
	fread(file, valtmp);GetVal(valtmp);civnokill = RetVal;
	fread(file, valtmp);GetVal(valtmp);accountplay = RetVal;
	fread(file, valtmp);GetVal(valtmp);mediccharge = RetVal;
	fread(file, valtmp);GetVal(valtmp);rconmakeadmin = RetVal;
	fclose(file);
	print(".....Config Settings Loaded");
	printf("%s %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d %d",motd,dollah,realtime,timeshift,wtime,gRoundTime,cashbox,streetrace,hotwire,levelcost,deathcost,paycheck,jobdelay,petime,realchat,forceteam, rconmakeadmin);
}
//------------------------------------------------------------------------------------------------------
public GetVal(string[])
{
	new tmp[32];
	new idx;
	tmp = strtok(string, idx);
	tmp = strtok(string, idx);
	RetVal = strval(tmp);
	strmid(string, string, 0, strlen(string)-1, 255);
	printf("%s",string);
}

public SaveRace(playerid,name[])
{
		new coordsstring[256];
		new racename[64];
		new makername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, makername, sizeof(makername));
		format(coordsstring, sizeof(coordsstring), "%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%s,%s,%d,%d",
		RaceInfo[rStartx],
		RaceInfo[rStarty],
		RaceInfo[rStartz],
		RaceInfo[rMidx],
		RaceInfo[rMidy],
		RaceInfo[rMidz],
		RaceInfo[rMid2x],
		RaceInfo[rMid2y],
		RaceInfo[rMid2z],
		RaceInfo[rEndx],
		RaceInfo[rEndy],
		RaceInfo[rEndz],
		makername,
		"none",
		0,
		RaceInfo[rLaps]);
		format(racename, sizeof(racename), "%s.race",name);
		new File: file2 = fopen(racename, io_write);
		fwrite(file2, coordsstring);
		fclose(file2);
		format(coordsstring, sizeof(coordsstring), "%s Race Saved",name);
		SendClientMessageRus(playerid, COLOR_GREEN,coordsstring);
		return 1;
}

public BestTime(name[])
{
		print("BestTime");
		new coordsstring[256];
		new racename[64];
		format(coordsstring, sizeof(coordsstring), "%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%f,%s,%s,%d,%d",
		RaceInfo[rStartx],
		RaceInfo[rStarty],
		RaceInfo[rStartz],
		RaceInfo[rMidx],
		RaceInfo[rMidy],
		RaceInfo[rMidz],
		RaceInfo[rMid2x],
		RaceInfo[rMid2y],
		RaceInfo[rMid2z],
		RaceInfo[rEndx],
		RaceInfo[rEndy],
		RaceInfo[rEndz],
		RaceInfo[rName],
		RaceInfo[rBest],
		RaceInfo[rBestms],
		RaceInfo[rLaps]);
		format(racename, sizeof(racename), "%s.race",name);
		new File: file2 = fopen(racename, io_write);
		fwrite(file2, coordsstring);
		fclose(file2);
		return 1;
}

public LoadTmp()
{
	new arrCoords[4][64];
	new strFromFile2[64];
	new File: file = fopen("tmppos.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(Teletmp))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, ',');
			Teletmp[idx][pTmpposx] = floatstr(arrCoords[0]);
			Teletmp[idx][pTmpposy] = floatstr(arrCoords[1]);
			Teletmp[idx][pTmpposz] = floatstr(arrCoords[2]);
			Teletmp[idx][pTmpint] = strval(arrCoords[3]);
			idx++;
		}
	}
	fclose(file);
	return 1;
}


public LoadRace(playerid,name[])
{
	if (gdebug >= 1){printf("DEBUG Loadrace(%d,%s)",playerid,name);}
	new arrCoords[16][64];
	new strFromFile2[256];
	new racename[64];
	strmid(CurrentRace, name, 0, strlen(name), 255);
	format(racename, sizeof(racename), "%s.race",name);
	new File: file = fopen(racename, io_read);
	if (file)
	{
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, ',');
		RaceInfo[rStartx] = floatstr(arrCoords[0]);
		RaceInfo[rStarty] = floatstr(arrCoords[1]);
		RaceInfo[rStartz] = floatstr(arrCoords[2]);
		RaceInfo[rMidx] = floatstr(arrCoords[3]);
		RaceInfo[rMidy] = floatstr(arrCoords[4]);
		RaceInfo[rMidz] = floatstr(arrCoords[5]);
		RaceInfo[rMid2x] = floatstr(arrCoords[6]);
		RaceInfo[rMid2y] = floatstr(arrCoords[7]);
		RaceInfo[rMid2z] = floatstr(arrCoords[8]);
		RaceInfo[rEndx] = floatstr(arrCoords[9]);
		RaceInfo[rEndy] = floatstr(arrCoords[10]);
		RaceInfo[rEndz] = floatstr(arrCoords[11]);
		strmid(RaceInfo[rName], arrCoords[12], 0, strlen(arrCoords[12]), 255);
		strmid(RaceInfo[rBest], arrCoords[13], 0, strlen(arrCoords[13]), 255);
		RaceInfo[rBestms] = strval(arrCoords[14]);
		RaceInfo[rLaps] = strval(arrCoords[15]);
		rsx = RaceInfo[rStartx];rsy = RaceInfo[rStarty];rsz =RaceInfo[rStartz];
		rmx = RaceInfo[rMidx];rmy = RaceInfo[rMidy];rmz = RaceInfo[rMidz];
		rm2x = RaceInfo[rMid2x];rm2y = RaceInfo[rMid2y];rm2z = RaceInfo[rMid2z];
		rex = RaceInfo[rEndx];rey = RaceInfo[rEndy];rez = RaceInfo[rEndz];
		fclose(file);
		format(strFromFile2, sizeof(strFromFile2), "Гонка %s загружена",name);
		ConvertTicks(RaceInfo[rBestms]);
		SendClientMessageRus(playerid, COLOR_GREEN,strFromFile2);
		if(RaceInfo[rLaps] > 0)
		{
			format(strFromFile2, sizeof(strFromFile2), "След. гонка: %s, Автор : %s | Рекорд: %s : %d:%d:%d Круги: %d",name,RaceInfo[rName],RaceInfo[rBest],cmins,csecs,cmils,RaceInfo[rLaps]);
		}
		else
		{
			format(strFromFile2, sizeof(strFromFile2), "След. гонка: %s, Автор : %s | Рекорд: %s : %d:%d:%d",name,RaceInfo[rName],RaceInfo[rBest],cmins,csecs,cmils);
		}
		SendEnemyMessage(COLOR_GREEN, strFromFile2);
		randomrace = 0;
	}
	else
	{
		if(playerid != -1)
		{
			SendClientMessageRus(playerid, COLOR_GREEN,"Файл не найден");
		}
	}
	return 1;
}

public LoadProperty()
{
	new arrCoords[29][64];
	new strFromFile2[256];
	new File: file = fopen("property.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(HouseInfo))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, ',');
			HouseInfo[idx][hEntrancex] = floatstr(arrCoords[0]);
			HouseInfo[idx][hEntrancey] = floatstr(arrCoords[1]);
			HouseInfo[idx][hEntrancez] = floatstr(arrCoords[2]);
			HouseInfo[idx][hExitx] = floatstr(arrCoords[3]);
			HouseInfo[idx][hExity] = floatstr(arrCoords[4]);
			HouseInfo[idx][hExitz] = floatstr(arrCoords[5]);
			HouseInfo[idx][hHealthx] = strval(arrCoords[6]);
			HouseInfo[idx][hHealthy] = strval(arrCoords[7]);
			HouseInfo[idx][hHealthz] = strval(arrCoords[8]);
			HouseInfo[idx][hArmourx] = strval(arrCoords[9]);
			HouseInfo[idx][hArmoury] = strval(arrCoords[10]);
			HouseInfo[idx][hArmourz] = strval(arrCoords[11]);
			//printf("HouseInfo hEntrancez %f",HouseInfo[idx][hEntrancez]);
			strmid(HouseInfo[idx][hOwner], arrCoords[12], 0, strlen(arrCoords[12]), 255);
			strmid(HouseInfo[idx][hDiscription], arrCoords[13], 0, strlen(arrCoords[13]), 255);
			HouseInfo[idx][hValue] = strval(arrCoords[14]);
			HouseInfo[idx][hHel] = strval(arrCoords[15]);
			HouseInfo[idx][hArm] = strval(arrCoords[16]);
			HouseInfo[idx][hInt] = strval(arrCoords[17]);
			HouseInfo[idx][hLock] = strval(arrCoords[18]);
			HouseInfo[idx][hOwned] = strval(arrCoords[19]);
			HouseInfo[idx][hRooms] = strval(arrCoords[20]);
			HouseInfo[idx][hRent] = strval(arrCoords[21]);
			HouseInfo[idx][hRentabil] = strval(arrCoords[22]);
			HouseInfo[idx][hTakings] = strval(arrCoords[23]);
			HouseInfo[idx][hVec] = strval(arrCoords[24]);
  	        if(HouseInfo[idx][hVec] == 457)
			{
				HouseInfo[idx][hVec] = 411;
			}
			HouseInfo[idx][hVcol1] = strval(arrCoords[25]);
			HouseInfo[idx][hVcol2] = strval(arrCoords[26]);
			HouseInfo[idx][hDate] = strval(arrCoords[27]);
			HouseInfo[idx][hLevel] = strval(arrCoords[28]);
			printf("HouseInfo:%d Owner:%s hTakings %d hVec %d",idx,HouseInfo[idx][hOwner],HouseInfo[idx][hTakings],HouseInfo[idx][hVec]);
			idx++;
		}
	}
	fclose(file);
	return 1;
}

public LoadDM(playerid,name[])
{
	new arrCoords[4][64];
	new strFromFile2[256];
	new dmname[64];
	format(dmname, sizeof(dmname), "%s.dm",name);
	new File: file = fopen(dmname, io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(gRandomDMSpawns))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, ',');
			gRandomDMSpawns[idx][0] = floatstr(arrCoords[0]);
			gRandomDMSpawns[idx][1] = floatstr(arrCoords[1]);
			gRandomDMSpawns[idx][2] = floatstr(arrCoords[2]);
			idx++;
		}
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, ',');
		gDMWbounds[0] = floatstr(arrCoords[0]);
		gDMWbounds[1] = floatstr(arrCoords[1]);
		gDMWbounds[2] = floatstr(arrCoords[2]);
		gDMWbounds[3] = floatstr(arrCoords[3]);
		fclose(file);
		format(strFromFile2, sizeof(strFromFile2), "След. ДМ: %s",name);
		SendClientMessageToAllRus(COLOR_GREEN, strFromFile2);
	}
	else
	{
		if(playerid != -1)
		{
			SendClientMessageRus(playerid, COLOR_GREEN,"Файл не найден");
		}
	}
	return 1;
}

public SaveDM(playerid,name[])
{
		new coordsstring[256];
		new racename[64];
		format(racename, sizeof(racename), "%s.dm",name);
		new File: file2 = fopen(racename, io_write);
		new idx;
		while (idx < sizeof(gRandomDMSpawns))
		{
			format(coordsstring, sizeof(coordsstring), "%f,%f,%f\n",gRandomDMSpawns[idx][0],gRandomDMSpawns[idx][1],gRandomDMSpawns[idx][2]);
			fwrite(file2, coordsstring);
			idx++;
		}
		format(coordsstring, sizeof(coordsstring), "%f,%f,%f,%f\n",gDMWbounds[0],gDMWbounds[1],gDMWbounds[2],gDMWbounds[3]);
		fwrite(file2, coordsstring);
		fclose(file2);
		format(coordsstring, sizeof(coordsstring), "%s DM Saved",name);
		SendClientMessageRus(playerid, COLOR_GREEN,coordsstring);
		return 1;
}

public LoadRaceList(playerid,name[])
{
	new arrCoords[4][64];
	new strFromFile2[256];
	new dmname[64];
	format(dmname, sizeof(dmname), "%s.dm",name);
	new File: file = fopen(dmname, io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(gRandomDMSpawns))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, ',');
			gRandomDMSpawns[idx][0] = floatstr(arrCoords[0]);
			gRandomDMSpawns[idx][1] = floatstr(arrCoords[1]);
			gRandomDMSpawns[idx][2] = floatstr(arrCoords[2]);
			idx++;
		}
		fread(file, strFromFile2);
		split(strFromFile2, arrCoords, ',');
		gDMWbounds[0] = floatstr(arrCoords[0]);
		gDMWbounds[1] = floatstr(arrCoords[1]);
		gDMWbounds[2] = floatstr(arrCoords[2]);
		gDMWbounds[3] = floatstr(arrCoords[3]);
		fclose(file);
		format(strFromFile2, sizeof(strFromFile2), "След. ДМ: %s",name);
		SendClientMessageToAllRus(COLOR_GREEN, strFromFile2);
	}
	else
	{
		if(playerid != -1)
		{
			SendClientMessageRus(playerid, COLOR_GREEN,"Файл не найден");
		}
	}
	return 1;
}

public SaveRaceList(playerid,name[])
{
		new coordsstring[256];
		new racename[64];
		format(racename, sizeof(racename), "%s.dm",name);
		new File: file2 = fopen(racename, io_write);
		new idx;
		while (idx < sizeof(gRandomDMSpawns))
		{
			format(coordsstring, sizeof(coordsstring), "%f,%f,%f\n",gRandomDMSpawns[idx][0],gRandomDMSpawns[idx][1],gRandomDMSpawns[idx][2]);
			fwrite(file2, coordsstring);
			idx++;
		}
		format(coordsstring, sizeof(coordsstring), "%f,%f,%f,%f\n",gDMWbounds[0],gDMWbounds[1],gDMWbounds[2],gDMWbounds[3]);
		fwrite(file2, coordsstring);
		fclose(file2);
		format(coordsstring, sizeof(coordsstring), "%s ДМ Сохранен",name);
		SendClientMessageRus(playerid, COLOR_GREEN,coordsstring);
		return 1;
}


public LoadBizz()
{
	new arrCoords[31][64];
	new strFromFile2[256];
	new File: file = fopen("bizz.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(BizzInfo))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, ',');
			BizzInfo[idx][bEntrancex] = floatstr(arrCoords[0]);
			BizzInfo[idx][bEntrancey] = floatstr(arrCoords[1]);
			BizzInfo[idx][bEntrancez] = floatstr(arrCoords[2]);
			BizzInfo[idx][bExitx] = floatstr(arrCoords[3]);
			BizzInfo[idx][bExity] = floatstr(arrCoords[4]);
			BizzInfo[idx][bExitz] = floatstr(arrCoords[5]);
			BizzInfo[idx][bHealthx] = strval(arrCoords[6]);
			BizzInfo[idx][bHealthy] = strval(arrCoords[7]);
			BizzInfo[idx][bHealthz] = strval(arrCoords[8]);
			BizzInfo[idx][bArmourx] = strval(arrCoords[9]);
			BizzInfo[idx][bArmoury] = strval(arrCoords[10]);
			BizzInfo[idx][bArmourz] = strval(arrCoords[11]);
			strmid(BizzInfo[idx][bOwner], arrCoords[12], 0, strlen(arrCoords[12]), 255);
			strmid(BizzInfo[idx][bDiscription], arrCoords[13], 0, strlen(arrCoords[13]), 255);
			BizzInfo[idx][bValue] = strval(arrCoords[14]);
			BizzInfo[idx][bHel] = strval(arrCoords[15]);
			BizzInfo[idx][bArm] = strval(arrCoords[16]);
			BizzInfo[idx][bInt] = strval(arrCoords[17]);
			BizzInfo[idx][bLock] = strval(arrCoords[18]);
			BizzInfo[idx][bOwned] = strval(arrCoords[19]);
			BizzInfo[idx][bEntcost] = strval(arrCoords[20]);
			BizzInfo[idx][bTakings] = strval(arrCoords[21]);
			BizzInfo[idx][bDate] = strval(arrCoords[22]);
			BizzInfo[idx][bLevel] = strval(arrCoords[23]);
			BizzInfo[idx][bProd] = strval(arrCoords[24]);
			BizzInfo[idx][bProdCap] = strval(arrCoords[25]);
			BizzInfo[idx][bComp] = strval(arrCoords[26]);
			BizzInfo[idx][bCompCap] = strval(arrCoords[27]);
			BizzInfo[idx][bProdCost] = strval(arrCoords[28]);
			BizzInfo[idx][bPayComp] = strval(arrCoords[29]);
			BizzInfo[idx][bPriceMod] = strval(arrCoords[30]);

			printf("BizzInfo:%d [%s] Owner:%s Entfee:%d Takings:%d Products:%d/%d Components: %d/%d",
			idx,
			BizzInfo[idx][bDiscription],
			BizzInfo[idx][bOwner],
			BizzInfo[idx][bEntcost],
			BizzInfo[idx][bTakings],
			BizzInfo[idx][bProd],
			BizzInfo[idx][bProdCap],
			BizzInfo[idx][bComp],
			BizzInfo[idx][bCompCap]);
			idx++;
		}
	}
	fclose(file);
	return 1;
}


public LoadSBizz()
{
	new arrCoords[21][64];
	new strFromFile2[256];
	new File: file = fopen("sbizz.cfg", io_read);
	if (file)
	{
		new idx;
		while (idx < sizeof(SBizzInfo))
		{
			fread(file, strFromFile2);
			split(strFromFile2, arrCoords, ',');
			SBizzInfo[idx][sbEntrancex] = floatstr(arrCoords[0]);
			SBizzInfo[idx][sbEntrancey] = floatstr(arrCoords[1]);
			SBizzInfo[idx][sbEntrancez] = floatstr(arrCoords[2]);
			//printf("HouseInfo hEntrancez %f",HouseInfo[idx][hEntrancez]);
			strmid(SBizzInfo[idx][sbOwner], arrCoords[3], 0, strlen(arrCoords[3]), 255);
			strmid(SBizzInfo[idx][sbDiscription], arrCoords[4], 0, strlen(arrCoords[4]), 255);
			SBizzInfo[idx][sbValue] = strval(arrCoords[5]);
			SBizzInfo[idx][sbHel] = strval(arrCoords[6]);
			SBizzInfo[idx][sbArm] = strval(arrCoords[7]);
			SBizzInfo[idx][sbInt] = strval(arrCoords[8]);
			SBizzInfo[idx][sbLock] = strval(arrCoords[9]);
			SBizzInfo[idx][sbOwned] = strval(arrCoords[10]);
			SBizzInfo[idx][sbEntcost] = strval(arrCoords[11]);
			SBizzInfo[idx][sbTakings] = strval(arrCoords[12]);
			SBizzInfo[idx][sbDate] = strval(arrCoords[13]);
			SBizzInfo[idx][sbLevel] = strval(arrCoords[14]);
			SBizzInfo[idx][sbProd] = strval(arrCoords[15]);
			SBizzInfo[idx][sbProdCap] = strval(arrCoords[16]);
			SBizzInfo[idx][sbComp] = strval(arrCoords[17]);
			SBizzInfo[idx][sbCompCap] = strval(arrCoords[18]);
			SBizzInfo[idx][sbProdCost] = strval(arrCoords[19]);
			SBizzInfo[idx][sbPayComp] = strval(arrCoords[20]);
			printf("SmallBizzInfo:%d [%s] Owner:%s Entfee:%d Takings:%d Products:%d/%d Components: %d/%d",
			idx,
			SBizzInfo[idx][sbDiscription],
			SBizzInfo[idx][sbOwner],
			SBizzInfo[idx][sbEntcost],
			SBizzInfo[idx][sbTakings],
			SBizzInfo[idx][sbProd],
			SBizzInfo[idx][sbProdCap],
			SBizzInfo[idx][sbComp],
			SBizzInfo[idx][sbCompCap]);
			idx++;
		}
	}
	fclose(file);
	return 1;
}

//------------------------------------------------------------------------------------------------------
public OnGameModeInit()
{
	LoadConfig();
	LoadTmp();
	LoadProperty();
	LoadBizz();
	LoadSBizz();
	//PlayerHaul[78][pLoad] = 10000;
	PlayerHaul[78][pCapasity] = 10;
	//PlayerHaul[79][pLoad] = 10000;
	PlayerHaul[79][pCapasity] = 10;
	//PlayerHaul[80][pLoad] = 10000;
	PlayerHaul[80][pCapasity] = 5;
	//PlayerHaul[81][pLoad] = 10000;
	PlayerHaul[81][pCapasity] = 5;
	SetGameModeText("Public Enemy: LS");
	format(objstore, sizeof(objstore), "MOLE: У меня нет для тебя работы. Обращайся позже.");
	format(cbjstore, sizeof(cbjstore), "HQ: Пока нет приказов, конец связи.");
	gettime(ghour, gminute, gsecond);
	FixHour(ghour);
	ghour = shifthour;
	if(!realtime)
	{
		SetWorldTime(wtime);
	}
	ShowPlayerMarkers(1);
	ShowNameTags(1);
	// Player Class's
	for(new i = 0; i <= sizeof(Peds)-1; i++)
	{
		AddPlayerClass(Peds[i][0],1958.3783,1343.1572,1100.3746,269.1425,-1,-1,-1,-1,-1,-1);
		//if (gdebug){printf("DEBUG ped (%d) added", i);}
	}
	// Car Spawns
	//cops cars
	for(new h = 0; h < sizeof(HouseInfo); h++)
	{
		if (gdebug >= 1){printf("HouseInfo[%d][hVec] %d",h,HouseInfo[h][hVec]);}
		CreateVehicle(HouseInfo[h][hVec], HouseCarSpawns[h][0], HouseCarSpawns[h][1], HouseCarSpawns[h][2], HouseCarSpawns[h][3], HouseInfo[h][hVcol1], HouseInfo[h][hVcol2], 300);
		gCarLock[h+1] = 1;
	}//34
	CreateVehicle(601,1530.753000,-1683.450000,6.274824,270.0, -1, -1, 300);//copcar
	CreateVehicle(528,1558.392000,-1710.859000,5.466783,1.0, -1, -1, 300);
	CreateVehicle(596,1569.639000,-1710.859000,5.466783,1.0, -1, -1, 300);
	CreateVehicle(596,1249.4,-2042.1,59.7,268.8, -1, -1, 300); //sf
	CreateVehicle(596,1589.639000,-1710.859000,5.466783,1.0, -1, -1, 300);
	CreateVehicle(596,1601.308000,-1628.710000,13.056540,90.0, -1, -1, 300);
	CreateVehicle(596,1601.308000,-1621.916000,13.056540,90.0, -1, -1, 300);
	CreateVehicle(596,1535.8275,-1678.0283,13.1680,359.9876, -1, -1, 300);
	CreateVehicle(596,1561.860000,-1694.905000,6.139762,222.0,-1, -1, 300);
	CreateVehicle(596,1601.660000,-1696.529000,6.139762,89.0,-1, -1, 300);
	CreateVehicle(497,1116.5,-2053.9,74.4,358.5, -1, -1, 300); //copjeep/chop//sf
	CreateVehicle(497,1116.0,-2017.9,74.4,0.7, -1, -1, 300);//sf
	CreateVehicle(599,614.8,-588.5,17.4,240.0, -1, -1, 300);
	CreateVehicle(599,635.1,-561.5,16.5,180.0, -1, -1, 300);
	CreateVehicle(599, 1247.9,-2031.2,59.7,270.1, -1, -1, 300);//sf
	CreateVehicle(427,1539.392000,-1646.262000,6.274928,180.0, -1, -1, 300);//enforcer
	CreateVehicle(427,1531.254000,-1647.431000,6.274976,200.0, -1, -1, 300);
	CreateVehicle(490,1546.324000,-1658.402000,6.274824,180.0, -1, -1, 300);//fbiranch
	CreateVehicle(490,1546.324000,-1672.156000,6.274824,180.0, -1, -1, 300);
	CreateVehicle(490,1535.8459,-1668.7560,13.2653,359.7447,-1, -1, 300);
	CreateVehicle(523,612.6,-597.3,16.7,270.0, -1, -1, 300); // copbike
	CreateVehicle(523,1249.2,-2022.0,59.7,267.3, -1, -1, 300); //sf
	CreateVehicle(523,1528.1152,-1679.0033,5.4564,241.9187, -1, -1, 300);
	CreateVehicle(523,1530.1611,-1676.0326,5.4563,231.7766, -1, -1, 300);
	CreateVehicle(523,1568.483000,-1694.808000,6.138681,222.0,-1, -1, 300);
	CreateVehicle(497, 1517.8,-1656.1,13.7,0.0, -1, -1, 300);//police mavric
	CreateVehicle(416,1181.463501,-1308.673706,13.939081,270.0, -1, -1, 300);//ambulance
	CreateVehicle(416, 1181.7,-1339.2,13.8,270.0, -1, -1, 300);
	CreateVehicle(416, 1183.0,-1329.7,13.7,1.0, -1, -1, 300);
	CreateVehicle(407,1172.5,-1795.5,13.1,0.0, -1, -1, 300);//fire 407
	CreateVehicle(407,1182.1,-1795.9,13.1,0.0, -1, -1, 300);
	CreateVehicle(476,1935.763794,-2416.733887,13.846451,89.0,-1, -1, 300);//dodos//ls
	CreateVehicle(511,1848.121704,-2435.860352,13.754265,89.0,-1, -1, 300);//ls
	CreateVehicle(476,-1297.811279,-457.169250,14.448013,89.0,-1, -1, 300);//lv
	CreateVehicle(511,-1286.913696,-394.913086,14.448013,89.0,-1, -1, 300);//lv
	CreateVehicle(476,1586.432007,1615.842651,11.119888,89.0,-1, -1, 300);//sf
	CreateVehicle(511,1634.947388,1555.917969,11.109032,89.0,-1, -1, 300);//sf
	CreateVehicle(541,551.7929,-1285.5260,16.9303,0.4147,-1, -1, 300);//? bullit
	CreateVehicle(429,536.9888,-1286.5275,16.9993,359.1704,-1, -1, 300); //? infurnus //nowcheeta
	CreateVehicle(451,544.1793,-1286.1422,16.9492,7.3116,-1, -1, 300);//turismo
	CreateVehicle(429,2128.2063,-1141.5492,24.8090,42.9799,-1, -1, 300); //banshee
	CreateVehicle(415,2131.3589,-1138.5345,25.1992,40.9620,-1, -1, 300); //cheeta
	CreateVehicle(480,2134.7695,-1134.7576,25.4289,46.3918,-1, -1, 300); //comet
	//CreateVehicle(420, 1672.876587,-2251.854736,13.674889,271.2,-1, -1, -1);//taxi
	//CreateVehicle(420, 1754.525635,-1857.888306,13.713638,271.2,-1, -1, -1);
	//CreateVehicle(420, -1421.801880,-300.223724,14.299576,44.2,-1, -1, -1);
	//CreateVehicle(420, 1708.555786,1435.376587,10.863876,287.2,-1, -1, -1);
    CreateVehicle(456, 2795.2,-2417.8,13.4,90.8,-1,-1,300);
    CreateVehicle(456, 2783.9,-2417.9,13.4,90.8,-1,-1,300);
    CreateVehicle(440, 2794.1,-2455.9,13.4,90.8,-1,-1,300);
    CreateVehicle(440, 2782.9,-2455.6,13.4,90.8,-1,-1,300);
	CreateVehicle(470, 1105.7,-2070.5,69.0,185.7,-1, -1, 300);//patriot
	CreateVehicle(481, 1885.2,-1360.1,18.6,90.0,0, 1, 300);//bmx
	CreateVehicle(481, 1886.0,-1363.1,18.6,90.0,1, 0, 300);//bmx
	CreateVehicle(481, 1886.0,-1365.1,18.6,90.0,-1, -1, 300);//bmx jail
	CreateVehicle(493, 720.1,-1694.0,-0.4,179.4,-1,-1,300);
	CreateVehicle(493, 721.2,-1629.4,-0.4,180.9,-1,-1,300);
	CreateVehicle(468, 976.3570,-814.0229,97.8475, 29.2329,0,16,300); //mower
	CreateVehicle(468, 1424.7,-880.6,49.8,0.0,0,-1,300);//dozer
	CreateVehicle(463, 1513.4,-690.7,94.5,91.3,86,-1,300); //paulcar harly
	CreateVehicle(493, 739.5,-1670.5,-0.6,177.5,-1,-1,300);// new jetmax
	CreateVehicle(493, 737.7,-1639.9,-0.6,178.1,-1,-1,300);
	CreateVehicle(493, 714.3,-1672.0,-0.5,182.2,-1,-1,300);
	CreateVehicle(560, 249.9507,-1229.3521,74.5567,1.1,-1,-1,300);
	//end new jetmax
	//CreateVehicle(522, 1654.8,-1636.9,83.7,90.0,0, 6, -1);//fcr
	//CreateVehicle(522, 1228.7,-1266.2,64.5,90.0,0, 6, -1);//fcr
	//CreateVehicle(487, 1767.0,-2285.9,26.9,359.9,-1, -1, -1); //airportmavrik
	//CreateVehicle(577,1585.1444,1187.9630,10.7343,179.9691,-1,-1,-1); // at400 = crash when you walk up to it
	
	CreateVehicle(522,1542.8453,-1362.2898,329.0298,357.4759,0,3, 300); // NRG1
	CreateVehicle(522,1543.6589,-1362.3474,329.0296,359.5350,3,0, 300); // NRG2
	CreateVehicle(522,1544.4764,-1362.3495,329.0295,359.1479,0,3, 300); // NRG3
	CreateVehicle(522,1545.2312,-1362.3508,329.0294,359.1151,3,0, 300); // NRG4
	CreateVehicle(522,1545.9802,-1362.3392,329.0294,359.0108,0,3, 300); // NRG5
	CreateVehicle(522,1546.7017,-1362.3260,329.0295,357.8051,3,0, 300); // NRG6
	CreateVehicle(522,1547.4628,-1362.3361,329.0294,359.2368,0,3, 300); // NRG7
	CreateVehicle(522,1548.1338,-1362.3939,329.0290,358.6906,3,0, 300); // NRG8
	CreateVehicle(522,1548.8008,-1362.4564,329.0293,358.7705,0,3, 300); // NRG9
	CreateVehicle(521,1389.3872,-1256.3298,33.1263,174.8282,6,0, 300); // FCR1
	CreateVehicle(521,1390.4741,-1256.2101,33.1261,177.2685,0,6, 300); // FCR2
	CreateVehicle(521,1391.7761,-1256.0663,33.1258,185.0072,6,0, 300); // FCR3
	CreateVehicle(521,1393.1321,-1256.0179,33.1230,179.2145,0,6, 300); // FCR4
	
	for(new h = 0; h < sizeof(HouseInfo); h++)
	{
		/*
		if(HouseInfo[h][hHel] == 1)
		{
			AddStaticPickup(1240, 2, HouseInfo[h][hHealthx], HouseInfo[h][hHealthy], HouseInfo[h][hHealthz]);
			pickups++;
		}
		if(HouseInfo[h][hArm] == 1)
		{
			AddStaticPickup(1242, 2, HouseInfo[h][hArmourx], HouseInfo[h][hArmoury], HouseInfo[h][hArmourz]);
			pickups++;
		}
		*/
		if(HouseInfo[h][hOwned] == 0)
		{
			AddStaticPickup(1273, 2, HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez]);
			pickups++;
		}
		if(HouseInfo[h][hOwned] == 1)
		{
			AddStaticPickup(1239, 2, HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez]);
			pickups++;
		}
	}
	for(new h = 0; h < sizeof(BizzInfo); h++)
	{
		/*
		if(BizzInfo[h][bHel] == 1)
		{
			AddStaticPickup(1240, 2, BizzInfo[h][bHealthx], BizzInfo[h][bHealthy], BizzInfo[h][bHealthz]);
			pickups++;
		}
		if(BizzInfo[h][bArm] == 1)
		{
			AddStaticPickup(1242, 2, BizzInfo[h][bArmourx], BizzInfo[h][bArmoury], BizzInfo[h][bArmourz]);
			pickups++;
		}
		*/
		if(BizzInfo[h][bOwned] == 0)
		{
			AddStaticPickup(1272, 2, BizzInfo[h][bEntrancex], BizzInfo[h][bEntrancey], BizzInfo[h][bEntrancez]);
			pickups++;
		}
		if(BizzInfo[h][bOwned] == 1)
		{
			AddStaticPickup(1239, 2, BizzInfo[h][bEntrancex], BizzInfo[h][bEntrancey], BizzInfo[h][bEntrancez]);
			pickups++;
		}
	}
	for(new h = 0; h < sizeof(SBizzInfo); h++)
	{
		/*
		if(BizzInfo[h][bHel] == 1)
		{
			AddStaticPickup(1240, 2, BizzInfo[h][bHealthx], BizzInfo[h][bHealthy], BizzInfo[h][bHealthz]);
			pickups++;
		}
		if(BizzInfo[h][bArm] == 1)
		{
			AddStaticPickup(1242, 2, BizzInfo[h][bArmourx], BizzInfo[h][bArmoury], BizzInfo[h][bArmourz]);
			pickups++;
		}
		*/
		if(SBizzInfo[h][sbOwned] == 0)
		{
			AddStaticPickup(1272, 2, SBizzInfo[h][sbEntrancex], SBizzInfo[h][sbEntrancey], SBizzInfo[h][sbEntrancez]);
			pickups++;
		}
		if(SBizzInfo[h][sbOwned] == 1)
		{
			AddStaticPickup(1239, 2, SBizzInfo[h][sbEntrancex], SBizzInfo[h][sbEntrancey], SBizzInfo[h][sbEntrancez]);
			pickups++;
		}
	}
	AddStaticPickup(1274, 2, BizzInfo[4][bEntrancex], BizzInfo[4][bEntrancey], BizzInfo[4][bEntrancez]);pickups++; //thebank
	//56
	//Rooftop 1
	/*
	AddStaticPickup(1550, 2, 2217.2,-1179.7,29.7);//moneybag
	AddStaticPickup(1550, 2, 1098.1, -1428.0, 22.7);
	AddStaticPickup(1550, 2, 2484.2,-1961.8,16.7);
	AddStaticPickup(1550, 2, 733.2,-1357.9,23.5);
	AddStaticPickup(1550, 2, 1411.6,-1455.1,20.4);
	AddStaticPickup(1550, 2, 1080.6,-1605.0,20.4);
	AddStaticPickup(1550, 2, 382.0,-2058.7,10.7);
	AddStaticPickup(1550, 2, 656.1,-1646.6,15.4);
	AddStaticPickup(1550, 2, 816.2,-1380.5,23.5);
	AddStaticPickup(1550, 2, 853.3,-1388.2,-0.5);
	AddStaticPickup(1550, 2, 915.4,-1235.1,17.2);
	AddStaticPickup(1550, 2, 1153.7,-1180.4,32.8);
	AddStaticPickup(1550, 2, 1183.9,-1257.3,18.8);
	AddStaticPickup(1550, 2, 1441.3,-926.8,39.6);
	AddStaticPickup(1550, 2, 1527.5,-893.5,57.6);
	AddStaticPickup(1550, 2, 1292.1,-770.7,95.9);
	AddStaticPickup(1550, 2, 1907.9,-1318.6,14.1);
	AddStaticPickup(1550, 2, 1971.7,-1284.5,28.4);
	AddStaticPickup(1550, 2, 2687.1,-1144.6,71.3);
	AddStaticPickup(1550, 2, 2654.1,-1317.5,58.9);
	AddStaticPickup(1550, 2, 2771.0,-1388.5,27.1);
	AddStaticPickup(1550, 2, 2793.3,-1945.0,17.3);
	AddStaticPickup(1550, 2, 2447.5,-2209.8,26.6);
	AddStaticPickup(1550, 2, 197.9,-1206.0,78.3);
	AddStaticPickup(1550, 2, 1342.1,-1624.3,17.7);
	*/
	AddStaticPickup(371, 2, 1544.2,-1353.4,329.4); //ls towertop
	AddStaticPickup(371, 2, 1536.0, -1360.0, 1150.0);
	AddStaticPickup(3013, 2, 997.7,-921.1,42.1);//cashbox
	AddStaticPickup(3013, 2, 2421.5, -1221.7, 25.3);
	AddStaticPickup(3013, 2, 2069.7,-1780.1,13.5);
	AddStaticPickup(3013, 2, 1352.4,-1756.7,13.5);
	AddStaticPickup(3013, 2, 1831.1,-1842.8,13.5);
	AddStaticPickup(1242, 2, 1527.5,-12.1,1002.0); //binco armor
	/*
	AddStaticPickup(335, 2, -35.1,-49.7,1003.5);//24-7
	AddStaticPickup(366, 2, -18.6,-49.8,1003.5);
	AddStaticPickup(335, 2, -36.5,-75.3,1003.5);
	AddStaticPickup(366, 2, -16.0,-75.3,1003.5);
	AddStaticPickup(335, 2, -34.0,-3.2,1003.5);
	AddStaticPickup(366, 2, -27.7,-3.8,1003.5);
	AddStaticPickup(335, 2, 434.6,-85.1,999.5);//0
	AddStaticPickup(351, 2, 439.1,-82.0,999.5);
	AddStaticPickup(352, 2, 445.3,-84.2,999.5);
	AddStaticPickup(365, 2, 451.2,-84.1,999.5);
	AddStaticPickup(346, 2, 454.3,-91.5,999.5);
	AddStaticPickup(372, 2, 373.4,-184.8,1001.4);//1
	AddStaticPickup(372, 2, 373.4,-184.8,1001.4);
	AddStaticPickup(355, 2, 375.6,-181.8,1001.4);
	AddStaticPickup(335, 2, 379.9,-182.0,1000.6);
	AddStaticPickup(350, 2, 375.5,-189.0,1001.4);
	AddStaticPickup(350, 2, 375.5,-189.0,1001.4);
	AddStaticPickup(356, 2, 931.4,-5.6,1001.5);//2
	AddStaticPickup(352, 2, 931.3,-2.9,1001.5);
	AddStaticPickup(348, 2, 931.3,-0.4,1001.5);
	AddStaticPickup(350, 2, 934.8,6.6,1000.9);
	AddStaticPickup(335, 2, 938.5,6.8,1000.9);
	AddStaticPickup(365, 2, 949.9,-5.9,1001.1);
	AddStaticPickup(348, 2, 962.9,-55.2,1001.1);//3
	AddStaticPickup(350, 2, 966.8,-48.1,1001.9);
	AddStaticPickup(351, 2, 966.7,-45.3,1001.9);
	AddStaticPickup(352, 2, 958.7,-61.1,1001.1);
	AddStaticPickup(372, 2, 963.4,-60.4,1001.1);
	AddStaticPickup(353, 2, 964.0,-43.7,1001.1);
	AddStaticPickup(355, 2, 946.3,-57.8,1001.1);
	AddStaticPickup(356, 2, 943.9,-55.4,1001.1);
	AddStaticPickup(350, 2, 1296.9,4.9,1001.0); //bizz9
	AddStaticPickup(352, 2, 1292.3,4.4,1001.0);
	AddStaticPickup(356, 2, 1288.5,4.9,1001.0);
	AddStaticPickup(351, 2, 1285.1,4.6,1001.0);
	AddStaticPickup(370, 2, 1496.7,-1562.1,23.5);
	AddStaticPickup(348, 2, 1294.3,4.9,1001.0);
	AddStaticPickup(343, 2, -783.0,500.8,1371.7);//bizz 11
	*/
	pickups=pickups+9;

	printf("Pickups Max = 100, Current Pickups = %d",pickups);
	new randa = random(sizeof(RandCars));
	randa = random(sizeof(RandCars));carselect[0] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[1] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[2] = RandCars[randa][0];
	randa = random(sizeof(RandLow));carselect[3] = RandLow[randa][0];
	randa = random(sizeof(RandCars));carselect[4] = RandCars[randa][0];
	randa = random(sizeof(RandAngles));carselect[5] = RandAngles[randa][0];
	randa = random(sizeof(RandCars));carselect[6] = RandCars[randa][0];
	randa = random(sizeof(RandLow));carselect[7] = RandLow[randa][0];
	randa = random(sizeof(RandCars));carselect[8] = RandCars[randa][0];
	randa = random(sizeof(RandAngles));carselect[9] = RandAngles[randa][0];
	randa = random(sizeof(RandCars));carselect[10] = RandCars[randa][0];
	randa = random(sizeof(RandCars));carselect[11] = RandCars[randa][0];
	randa = random(sizeof(RandBikes));carselect[12] = RandBikes[randa][0];
	randa = random(sizeof(RandBikes));carselect[13] = RandBikes[randa][0];
	randa = random(sizeof(RandLCars));carselect[14] = RandLCars[randa][0];
	CreateVehicle(carselect[14], 1279.4,-1337.0,13.5,1.0,-1, -1, 300);//long
	//printf("DEBUG: Rando Cars %d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,",carselect[0],carselect[1],carselect[2],carselect[3],carselect[4],carselect[5],carselect[6],carselect[7],carselect[8],carselect[9],carselect[10],carselect[11],carselect[12],carselect[13],carselect[14]);
	if (gRoundTime > 0)
	{
		SetTimer("GameModeInitExitFunc", gRoundTime, 0);
	}
	if (realtime)
	{
		new tmphour;
		new tmpminute;
		new tmpsecond;
		gettime(tmphour, tmpminute, tmpsecond);
		FixHour(tmphour);
		tmphour = shifthour;
		SetWorldTime(tmphour);
	}
	if (fow)
	{
		SetTimer("CopScanner", radarfreq, 1);
	}
	synctimer = SetTimer("SyncUp", 60000, 1);
	newmistimer = SetTimer("PrePlayerNewMission", jobdelay, 1);
	unjailtimer = SetTimer("SetPlayerUnjail", 1000, 1);
	if (nocasino)
	{
		playertimer = SetTimer("PlayerInArea", 1000, 1);
	}
//	cartimer = SetTimer("CarCheck", 30000, 1);
	celltimer = SetTimer("CellPhoneTimer", 1000, 1);
	SetTimer("RingToner", 500, 0);
	SetTimer("SetPlayerFlash", 1000, 0);
	SetTimer("CustomPickups", 1000, 1);
	SetTimer("InHouse", 1000, 1);
	SetTimer("GameTicks", 500, 1);
	SetTimer("VoteKickTimer", 1000, 1);
	SetTimer("DMDetect", 1000, 1);
	SetTimer("Spectator", 2000, 1);
	SetTimer("PenInArea", 2000, 1);
	SetTimer("IdleKick", idletime, 1);
	SetTimer("AntiTeleport", 1000, 1);
	SetTimer("AntiCamp", 1000, 1);
	SetTimer("SkyDive", 1000, 1);
	SetTimer("Production", 300000, 1); //5 mins
	//for(new i = 0; i < sizeof(CarSpawns); i++)
	for(new i = 0; i < sizeof(CarSpawns); i++)
	{
		AddCar(i);
		if (gdebug){printf("DEBUG car (%d) spawned", i);}
	}
	CarInit();
	TeamCarLockInit();
	return 1;
}

public SyncUp()
{
	if (gdebug >= 3){printf("DEBUG SyncUp()");}
	SyncTime();
	DollahScoreUpdate();
}

public SyncTime()
{
	if (gdebug >= 3){printf("DEBUG SyncTime()");}
	new string[64];
	new tmphour;
	new tmpminute;
	new tmpsecond;
	gettime(tmphour, tmpminute, tmpsecond);
	FixHour(tmphour);
	tmphour = shifthour;
	if ((tmphour > ghour) || (tmphour == 0 && ghour == 23))
	{
		format(string, sizeof(string), "СЕРВЕР: Время установлено на %d:00",tmphour);
		BroadCast(COLOR_WHITE,string);
		if (numplayers == 0)
		{
			GameModeInitExitFunc();
		}
		if (gdebug){printf("DEBUG tmphour=%d ghour=%d",tmphour,ghour);}
		ghour = tmphour;
		PayDay();
		if (realtime)
		{
			SetWorldTime(tmphour);
		}
	}
}

public SkyDive()
{
	skydivecount--;
	new string[256];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1 && gSkyDive[i] == 1)
		{
			if(skydivecount > 10)
			{
				format(string, sizeof(string), "~W~%d",skydivecount);
			}
			else
			{
				format(string, sizeof(string), "~r~%d",skydivecount);
			}
			GameTextForPlayerRus(i, string, 2000, 6);
			if(skydivecount == 0)
			{
				GivePlayerWeapon(i, 46, 0);
				SetPlayerPos(i,SBizzInfo[0][sbEntrancex]+i, SBizzInfo[0][sbEntrancey], 1350.0);
				SetPlayerInterior(i,0);
				PlayerInfo[i][pInt] = 0;
				SendClientMessageRus(i, TEAM_GROVE_COLOR, "GO!! GO!! GO!!");
				gSkyDive[i] = 0;
			}
		}
	}
	if(skydivecount == 0)
	{
		skydivecount = 60;
	}
}
/*
public Production()
{
	for(new i = 0; i < sizeof(BizzInfo); i++)
	{
		if(BizzInfo[i][bComp] >= BizzInfo[i][bProdCost])
		{
			//printf("BizzInfo[i][bComp] %d BizzInfo[i][bProdCost] %d",BizzInfo[i][bComp],BizzInfo[i][bProdCost])
			if(BizzInfo[i][bProd] < BizzInfo[i][bProdCap])
			{
				//printf("BizzInfo[i][bProd] %d BizzInfo[i][bProdCap] %d",BizzInfo[i][bProd],BizzInfo[i][bProdCap])
				BizzInfo[i][bComp] = BizzInfo[i][bComp]-BizzInfo[i][bProdCost];
				BizzInfo[i][bProd]++;
			}
		}
	}
	for(new i = 0; i < sizeof(SBizzInfo); i++)
	{
		if(SBizzInfo[i][sbComp] >= SBizzInfo[i][sbProdCost])
		{
			if(SBizzInfo[i][sbProd] < SBizzInfo[i][sbProdCap])
			{
				SBizzInfo[i][sbComp] = SBizzInfo[i][sbComp]-SBizzInfo[i][sbProdCost];
				SBizzInfo[i][sbProd]++;
			}
		}
	}
}
*/
public Production()
{
	for(new i = 0; i < sizeof(BizzInfo); i++)
	{
		if(BizzInfo[i][bComp] > 0)
		{
			//printf("BizzInfo[i][bComp] %d BizzInfo[i][bProdCost] %d",BizzInfo[i][bComp],BizzInfo[i][bProdCost])
			if(BizzInfo[i][bProd] < BizzInfo[i][bProdCap])
			{
				//printf("BizzInfo[i][bProd] %d BizzInfo[i][bProdCap] %d",BizzInfo[i][bProd],BizzInfo[i][bProdCap])
				BizzInfo[i][bProd] = BizzInfo[i][bProd]+BizzInfo[i][bProdCost];
				BizzInfo[i][bComp]--;
			}
		}
	}
	for(new i = 0; i < sizeof(SBizzInfo); i++)
	{
		if(SBizzInfo[i][sbComp] > 0)
		{
			if(SBizzInfo[i][sbProd] < SBizzInfo[i][sbProdCap])
			{
				SBizzInfo[i][sbProd] = SBizzInfo[i][sbProd]+SBizzInfo[i][sbProdCost];
				SBizzInfo[i][sbComp]--;
			}
		}
	}
}

public DateProp(playerid)
{
	new playername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, playername, sizeof(playername));
	new curdate = getdate();
	for(new h = 0; h < sizeof(HouseInfo); h++)
	{
		if (strcmp(playername, HouseInfo[h][hOwner], true) == 0)
		{
			HouseInfo[h][hDate] = curdate;
			OnPropUpdate();
		}
	}
	for(new b = 0; b < sizeof(BizzInfo); b++)
	{
		if (strcmp(playername, BizzInfo[b][bOwner], true) == 0)
		{
			BizzInfo[b][bDate] = curdate;
			OnPropUpdate();
		}
	}
	for(new c = 0; c < sizeof(SBizzInfo); c++)
	{
		if (strcmp(playername, SBizzInfo[c][sbOwner], true) == 0)
		{
			SBizzInfo[c][sbDate] = curdate;
			OnPropUpdate();
		}
	}
	return 1;
}

public Checkprop()
{
	new olddate;
	new string[256];
	new curdate = getdate();
	for(new h = 0; h < sizeof(HouseInfo); h++)
	{
		if(HouseInfo[h][hOwned] == 1 && HouseInfo[h][hDate] > 9)
		{
			olddate = HouseInfo[h][hDate];
			if(curdate-olddate >= 3)
			{
				HouseInfo[h][hHel] = 0;
				HouseInfo[h][hArm] = 0;
				HouseInfo[h][hHealthx] = 0;
				HouseInfo[h][hHealthy] = 0;
				HouseInfo[h][hHealthz] = 0;
				HouseInfo[h][hArmourx] = 0;
				HouseInfo[h][hArmoury] = 0;
				HouseInfo[h][hArmourz] = 0;
				HouseInfo[h][hLock] = 1;
				HouseInfo[h][hOwned] = 0;
				HouseInfo[h][hVec] = 418;
				HouseInfo[h][hVcol1] = -1;
				HouseInfo[h][hVcol2] = -1;
				strmid(HouseInfo[h][hOwner], "The State", 0, strlen("The State"), 255);
				format(string, sizeof(string), "РЕКЛАМА: Продается дом по цене $%d",HouseInfo[h][hValue]);
				SendClientMessageToAllRus(TEAM_BALLAS_COLOR, string);
				OnPropUpdate();
			}
		}
	}
	for(new b = 0; b < sizeof(BizzInfo); b++)
	{
		if(BizzInfo[b][bOwned] == 1 && BizzInfo[b][bDate] > 9)
		{
			olddate = BizzInfo[b][bDate];
			if(curdate-olddate >= 3)
			{
				BizzInfo[b][bHel] = 0;
				BizzInfo[b][bArm] = 0;
				BizzInfo[b][bLock] = 1;
				BizzInfo[b][bOwned] = 0;
				strmid(BizzInfo[b][bOwner], "The State", 0, strlen("The State"), 255);
				format(string, sizeof(string), "РЕКЛАМА: Продается бизнес по цене $%d",BizzInfo[b][bValue]);
				SendClientMessageToAllRus(TEAM_BALLAS_COLOR, string);
				OnPropUpdate();
			}
		}
	}
	for(new c = 0; c < sizeof(SBizzInfo); c++)
	{
		if(SBizzInfo[c][sbOwned] == 1 && SBizzInfo[c][sbDate] > 9)
		{
			olddate = SBizzInfo[c][sbDate];
			if(curdate-olddate >= 3)
			{
				SBizzInfo[c][sbHel] = 0;
				SBizzInfo[c][sbArm] = 0;
				SBizzInfo[c][sbLock] = 1;
				SBizzInfo[c][sbOwned] = 0;
				strmid(SBizzInfo[c][sbOwner], "The State", 0, strlen("The State"), 255);
				format(string, sizeof(string), "РЕКЛАМА: Продается бизнес по цене $%d",SBizzInfo[c][sbValue]);
				SendClientMessageToAllRus(TEAM_BALLAS_COLOR, string);
				OnPropUpdate();
			}
		}
	}
	return 1;
}

public PayDay()
{
	if (gdebug >= 1){printf("DEBUG PayDay()");}
	new string[128];
	new pay,account,interest;
	new rent = 0;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1 && PlayerInfo[i][pLevel] > 0)
		{
			new playername2[MAX_PLAYER_NAME];
			GetPlayerName(i, playername2, sizeof(playername2));
			account = PlayerInfo[i][pAccount];
			new key = PlayerInfo[i][pPhousekey];
			if(key != -1)
			{
				rent = HouseInfo[key][hRent];
				if(strcmp(playername2, HouseInfo[key][hOwner], true) == 0)
				{
					rent = 0;
				}
				else if(rent > GetPlayerMoney(i))
				{
					PlayerInfo[i][pPhousekey] = -1;
					SendClientMessageRus(i, COLOR_WHITE, "Вы были выселены");
					rent = 0;
				}
				HouseInfo[key][hTakings] = HouseInfo[key][hTakings]+rent;
			}
			new tmpintrate;
			if (key != -1 && strcmp(playername2, HouseInfo[key][hOwner], true) == 0)
			{
				tmpintrate = intrate+HouseInfo[key][hLevel];
			}
			else
			{
				tmpintrate = 1;
			}
			interest = (PlayerInfo[i][pAccount]/1000)*(tmpintrate);
			pay = PlayerInfo[i][pLevel]*paycheck;
			PlayerInfo[i][pExp]++;
			PlayerPlayMusic(i);
			SafeGivePlayerMoney(i,pay-rent);
			PlayerInfo[i][pAccount] = account+interest;
			BizzInfo[4][bTakings] = BizzInfo[4][bTakings]+((PlayerInfo[i][pAccount]/1000)+intrate);
			SendClientMessageRus(i, COLOR_WHITE, "|___ БАНКОВСКИЙ ОТЧЕТ ___|");
			format(string, sizeof(string), "Баланс: $%d", account);
			SendClientMessageRus(i, COLOR_GRAD1, string);
			format(string, sizeof(string), "Процентная ставка: 0.%d процента",tmpintrate);
			SendClientMessageRus(i, COLOR_GRAD2, string);
			format(string, sizeof(string), "Прибыль: $%d", interest);
			SendClientMessageRus(i, COLOR_GRAD3, string);
			SendClientMessageRus(i, COLOR_GRAD4, "|--------------------------------------|");
			format(string, sizeof(string), "Новый баланс: $%d", PlayerInfo[i][pAccount]);
			SendClientMessageRus(i, COLOR_GRAD5, string);
			format(string, sizeof(string), "Арендная плата: -$%d", rent);
			SendClientMessageRus(i, COLOR_GRAD5, string);
			format(string, sizeof(string), "~y~PayDay~n~~w~Paycheck ~n~~g~$%d", pay);
			GameTextForPlayerRus(i, string, 5000, 1);
			rent = 0;
		}
	}
	Checkprop();
	return 1;
}

strtok(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ' '))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}
/*strtik(const string[], &index)
{
	new length = strlen(string);
	while ((index < length) && (string[index] <= ','))
	{
		index++;
	}

	new offset = index;
	new result[20];
	while ((index < length) && (string[index] > ',') && ((index - offset) < (sizeof(result) - 1)))
	{
		result[index - offset] = string[index];
		index++;
	}
	result[index - offset] = EOS;
	return result;
}*/
split(const strsrc[], strdest[][], delimiter)
{
	new i, li;
	new aNum;
	new len;

	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}

public DelPrint(string1[])
{
	strmid(string1, string1, 0, strlen(string1)-1, 255);
	printf("%s", string1);
}

public LoadPlayer(loaderid,const string[])
{
	new string2[64];
	new loaded = loaderid;
	new valtmp[128];
	format(string2, sizeof(string2), "%s.cer", string);
	new File: file = fopen(string2, io_read);
	if (file)
	{
			fread(file, valtmp);strmid(PLlayerInfo[loaded][plPassword], valtmp, 0, strlen(valtmp)-1, 255);
			fread(file, valtmp);PLlayerInfo[loaded][plCash] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plAccount] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plAdmin] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plLevel] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plExp] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][glPupgrade] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plKills] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plCB] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plHW] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plSR] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plWA] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plPEN] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plGun1] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plGun2] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plGun3] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plGun4] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plGun5] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plGun6] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plAmmo1] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plAmmo2] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plAmmo3] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plAmmo4] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plAmmo5] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plAmmo6] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plSHealth] = floatstr(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plHealth] = floatstr(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plPos_x] = floatstr(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plPos_y] = floatstr(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plPos_z] = floatstr(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plInt] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plLocal] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plTeam] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plModel] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plPnumber] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plPhousekey] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PLlayerInfo[loaded][plPbiskey] = strval(valtmp);DelPrint(valtmp);
			SendClientMessageRus(loaderid, COLOR_WHITE, "СЕРВЕР: Аккаунт загружен");
	}
	else
	{
		SendClientMessageRus(loaderid, COLOR_WHITE, "СЕРВЕР: Нет аккаунта с таким именем");
		return 0;
	}
	return 1;
}

public SavePlayer(loaderid,const string[])
{
	new string3[32];
	new saved = loaderid;
	format(string3, sizeof(string3), "%s.cer", string);
	new File: pFile = fopen(string3, io_write);
	if (pFile)
	{
		new var[32];
		format(var, 32, "%s\n", PLlayerInfo[saved][plPassword]);fwrite(pFile, var);
		fclose(pFile);
		new File: hFile = fopen(string3, io_append);
		format(var, 32, "%d pCash\n",PLlayerInfo[saved][plCash]);fwrite(hFile, var);
		format(var, 32, "%d pAccount\n",PLlayerInfo[saved][plAccount]);fwrite(hFile, var);
		format(var, 32, "%d pAdmin\n",PLlayerInfo[saved][plAdmin]);fwrite(hFile, var);
		format(var, 32, "%d pLevel\n",PLlayerInfo[saved][plLevel]);fwrite(hFile, var);
		format(var, 32, "%d pExp\n",PLlayerInfo[saved][plExp]);fwrite(hFile, var);
		format(var, 32, "%d gPupgrade\n",PLlayerInfo[saved][glPupgrade]);fwrite(hFile, var);
		format(var, 32, "%d pKills\n",PLlayerInfo[saved][plKills]);fwrite(hFile, var);
		format(var, 32, "%d pCB\n",PLlayerInfo[saved][plCB]);fwrite(hFile, var);
		format(var, 32, "%d pHW\n",PLlayerInfo[saved][plHW]);fwrite(hFile, var);
		format(var, 32, "%d pSR\n",PLlayerInfo[saved][plSR]);fwrite(hFile, var);
		format(var, 32, "%d pWA\n",PLlayerInfo[saved][plWA]);fwrite(hFile, var);
		format(var, 32, "%d pPEN\n",PLlayerInfo[saved][plPEN]);fwrite(hFile, var);
		format(var, 32, "%d pGun1\n",PLlayerInfo[saved][plGun1]);fwrite(hFile, var);
		format(var, 32, "%d pGun2\n",PLlayerInfo[saved][plGun2]);fwrite(hFile, var);
		format(var, 32, "%d pGun3\n",PLlayerInfo[saved][plGun3]);fwrite(hFile, var);
		format(var, 32, "%d pGun4\n",PLlayerInfo[saved][plGun4]);fwrite(hFile, var);
		format(var, 32, "%d pGun5\n",PLlayerInfo[saved][plGun5]);fwrite(hFile, var);
		format(var, 32, "%d pGun6\n",PLlayerInfo[saved][plGun6]);fwrite(hFile, var);
		format(var, 32, "%d pAmmo1\n",PLlayerInfo[saved][plAmmo1]);fwrite(hFile, var);
		format(var, 32, "%d pAmmo2\n",PLlayerInfo[saved][plAmmo2]);fwrite(hFile, var);
		format(var, 32, "%d pAmmo3\n",PLlayerInfo[saved][plAmmo3]);fwrite(hFile, var);
		format(var, 32, "%d pAmmo4\n",PLlayerInfo[saved][plAmmo4]);fwrite(hFile, var);
		format(var, 32, "%d pAmmo5\n",PLlayerInfo[saved][plAmmo5]);fwrite(hFile, var);
		format(var, 32, "%d pAmmo6\n",PLlayerInfo[saved][plAmmo6]);fwrite(hFile, var);
		format(var, 32, "%.1f pSHealth\n", PLlayerInfo[saved][plSHealth]);fwrite(hFile, var);
		format(var, 32, "%.1f pHealth\n", PLlayerInfo[saved][plHealth]);fwrite(hFile, var);
		format(var, 32, "%.1f pPos_x\n", PLlayerInfo[saved][plPos_x]);fwrite(hFile, var);
		format(var, 32, "%.1f pPos_y\n", PLlayerInfo[saved][plPos_y]);fwrite(hFile, var);
		format(var, 32, "%.1f pPos_z\n", PLlayerInfo[saved][plPos_z]);fwrite(hFile, var);
		format(var, 32, "%d pInt\n",PLlayerInfo[saved][plInt]);fwrite(hFile, var);
		format(var, 32, "%d pLocal\n",PLlayerInfo[saved][plLocal]);fwrite(hFile, var);
		format(var, 32, "%d pTeam\n",PLlayerInfo[saved][plTeam]);fwrite(hFile, var);
		format(var, 32, "%d pModel\n",PLlayerInfo[saved][plModel]);fwrite(hFile, var);
		format(var, 32, "%d pPnumber\n",PLlayerInfo[saved][plPnumber]);fwrite(hFile, var);
		format(var, 32, "%d pPhousekey\n",PLlayerInfo[saved][plPhousekey]);fwrite(hFile, var);
		format(var, 32, "%d pPbiskey\n",PLlayerInfo[saved][plPbiskey]);fwrite(hFile, var);
		fclose(hFile);
	}
	return 1;
}


public OnPlayerLogin(playerid,const string[])
{
	if (gdebug >= 1){printf("DEBUG OnPlayerLogin(%d) (%s)", playerid,string);}
	new string2[64];
	new playername2[MAX_PLAYER_NAME];
	//new password[64];
	new tmp2[256];
	/*
	if (gPlayerSpawned[playerid] == 1)
	{
		SetPlayerHealth(playerid,0.0);
	}
	*/
	GetPlayerName(playerid, playername2, sizeof(playername2));
	format(string2, sizeof(string2), "%s.cer", playername2);
	new File: file = fopen(string2, io_read);
	if (file)
	{
		new valtmp[128];
		fread(file, valtmp);strmid(PlayerInfo[playerid][pPassword], valtmp, 0, strlen(valtmp)-1, 255);
		if (gdebug){printf("DEBUG password from file= (%s) pass enterd =  (%s)",PlayerInfo[playerid][pPassword] ,string );}
		//fread(file, valtmp);strmid(password, valtmp, 0, strlen(string), 255);
		if ((strcmp(PlayerInfo[playerid][pPassword], string, true, strlen(valtmp)-1) == 0))// && (strlen(string) == strlen(password)))
		{
			fread(file, valtmp);PlayerInfo[playerid][pCash] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pAccount] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pAdmin] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pLevel] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pExp] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][gPupgrade] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pKills] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pCB] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pHW] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pSR] = strval(valtmp);DelPrint(valtmp);
			if(PlayerInfo[playerid][pKills] < 0){PlayerInfo[playerid][pKills] = 0;}//patch
			if(PlayerInfo[playerid][pCB] < 0){PlayerInfo[playerid][pCB] = 0;}//patch
			if(PlayerInfo[playerid][pHW] < 0){PlayerInfo[playerid][pHW] = 0;}//patch
			if(PlayerInfo[playerid][pSR] < 0){PlayerInfo[playerid][pSR] = 0;}//patch
			fread(file, valtmp);PlayerInfo[playerid][pWA] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pPEN] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pGun1] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pGun2] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pGun3] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pGun4] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pGun5] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pGun6] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pAmmo1] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pAmmo2] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pAmmo3] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pAmmo4] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pAmmo5] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pAmmo6] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pSHealth] = floatstr(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pHealth] = floatstr(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pPos_x] = floatstr(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pPos_y] = floatstr(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pPos_z] = floatstr(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pInt] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pLocal] = strval(valtmp);DelPrint(valtmp);
			if(PlayerInfo[playerid][pModel] == 264){fread(file, valtmp);PlayerInfo[playerid][pTeam] = strval(valtmp);DelPrint(valtmp);}else{fread(file, valtmp);}
			if(PlayerInfo[playerid][pModel] == 264){fread(file, valtmp);PlayerInfo[playerid][pModel] = strval(valtmp);DelPrint(valtmp);}else{fread(file, valtmp);}
			fread(file, valtmp);PlayerInfo[playerid][pPnumber] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pPhousekey] = strval(valtmp);DelPrint(valtmp);
			fread(file, valtmp);PlayerInfo[playerid][pPbiskey] = strval(valtmp);DelPrint(valtmp);
			fclose(file);
			ResetPlayerMoney(playerid);
			SafeGivePlayerMoney(playerid,PlayerInfo[playerid][pCash]);

			//if (gdebug){printf("DEBUG phonenumber = %d",pnumber);}
			if(PlayerInfo[playerid][pLevel] == -999) //autoban
			{
				Ban(playerid);
			}
			format(string2, sizeof(string2), "СЕРВЕР: Добро пожаловать, %s",playername2);
			SendClientMessageRus(playerid, COLOR_WHITE,string2);
			SetPlayerWeapons(playerid);
			printf("%s has logged in",playername2);
			if (PlayerInfo[playerid][pAdmin] > 0)
			{
				format(string2, sizeof(string2), "СЕРВЕР: Вы авторизовались как админ %d уровня",PlayerInfo[playerid][pAdmin]);
				SendClientMessageRus(playerid, COLOR_WHITE,string2);
			}
			SetSpawnInfo(playerid, 1, PlayerInfo[playerid][pModel], PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z], 1.0, -1, -1, -1, -1, -1, -1);
			if(gTeam[playerid] == 0)
			{
				gTeam[playerid] = 3;
			}
			else
			{
				gTeam[playerid] = PlayerInfo[playerid][pTeam];
			}
			gPlayerLogged[playerid] = 1;
			if(accountplay)
			{
				gPlayerSpawned[playerid] = 0;
			}
			SpawnPlayer(playerid);
			GetPlayerName(playerid, playername2, sizeof(playername2));
			format(tmp2, sizeof(tmp2), "~w~Welcome ~n~~y~   %s", playername2);
			DateProp(playerid);
			GameTextForPlayerRus(playerid, tmp2, 5000, 1);
//			SendClientMessageRus(playerid, COLOR_YELLOW, motd);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "СЕРВЕР: Неверный пароль");
			printf("%s is hacking a password",playername2);
			fclose(file);
			return 1;
		}
//		return 1;
	}
	else
	{
		SendClientMessageRus(playerid, COLOR_WHITE, "СЕРВЕР: Вы еще не зарегистрированы, введите /regnick <password>");
	}
	return 1;
}

public CopCheck(playerid)
{
	if (gdebug >= 1){printf("DEBUG CopCheck(%d) (%s)", playerid);}
	new playername2[MAX_PLAYER_NAME];
	new storedcopname[64];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("cops.cfg", io_read);
	if (file)
	{
		new valtmp[MAX_PLAYER_NAME];
		while (fread(file, valtmp) > 0)
		{
			//printf("%s",valtmp);
			strmid(storedcopname, valtmp, 0, strlen(playername2), 255);
			if ((strcmp(storedcopname, playername2, true, strlen(playername2)) == 0) && (strlen(playername2) == strlen(storedcopname)))
			{
				fclose(file);
				return 1;
			}
		}
	}
	fclose(file);
	return 0;
}
public MedCheck(playerid)
{
	if (gdebug >= 1){printf("DEBUG MedCheck(%d) (%s)", playerid);}
	new playername2[MAX_PLAYER_NAME];
	new storedcopname[64];
	GetPlayerName(playerid, playername2, sizeof(playername2));
	new File: file = fopen("meds.cfg", io_read);
	if (file)
	{
		new valtmp[MAX_PLAYER_NAME];
		while (fread(file, valtmp) > 0)
		{
			//printf("%s",valtmp);
			strmid(storedcopname, valtmp, 0, strlen(playername2), 255);
			if ((strcmp(storedcopname, playername2, true, strlen(playername2)) == 0) && (strlen(playername2) == strlen(storedcopname)))
			{
				fclose(file);
				return 1;
			}
		}
	}
	fclose(file);
	return 0;
}
public PlayerUpdate(playerid)
{
	if (gdebug >= 1){printf("DEBUG PlayerUpdate(%d)", playerid);}
	if (gPlayerLogged[playerid] != 0)
	{
		new string3[32];
		new playername3[MAX_PLAYER_NAME];
		GetPlayerName(playerid, playername3, sizeof(playername3));
		format(string3, sizeof(string3), "%s.cer", playername3);
		new File: pFile = fopen(string3, io_write);
		if (gdebug){printf("DEBUG PlayerUpdate(%d)8.5", playerid);}
		if (pFile)
		{
			new var[32];
			format(var, 32, "%s\n", PlayerInfo[playerid][pPassword]);fwrite(pFile, var);
			fclose(pFile);
			new File: hFile = fopen(string3, io_append);
			PlayerInfo[playerid][pCash] = GetPlayerMoney(playerid);
			format(var, 32, "%d pCash\n",PlayerInfo[playerid][pCash]);fwrite(hFile, var);
			format(var, 32, "%d pAccount\n",PlayerInfo[playerid][pAccount]);fwrite(hFile, var);
			format(var, 32, "%d pAdmin\n",PlayerInfo[playerid][pAdmin]);fwrite(hFile, var);
			format(var, 32, "%d pLevel\n",PlayerInfo[playerid][pLevel]);fwrite(hFile, var);
			format(var, 32, "%d pExp\n",PlayerInfo[playerid][pExp]);fwrite(hFile, var);
			format(var, 32, "%d gPupgrade\n",PlayerInfo[playerid][gPupgrade]);fwrite(hFile, var);
			format(var, 32, "%d pKills\n",PlayerInfo[playerid][pKills]);fwrite(hFile, var);
			format(var, 32, "%d pCB\n",PlayerInfo[playerid][pCB]);fwrite(hFile, var);
			format(var, 32, "%d pHW\n",PlayerInfo[playerid][pHW]);fwrite(hFile, var);
			format(var, 32, "%d pSR\n",PlayerInfo[playerid][pSR]);fwrite(hFile, var);
			format(var, 32, "%d pWA\n",PlayerInfo[playerid][pWA]);fwrite(hFile, var);
			format(var, 32, "%d pPEN\n",PlayerInfo[playerid][pPEN]);fwrite(hFile, var);
			format(var, 32, "%d pGun1\n",PlayerInfo[playerid][pGun1]);fwrite(hFile, var);
			format(var, 32, "%d pGun2\n",PlayerInfo[playerid][pGun2]);fwrite(hFile, var);
			format(var, 32, "%d pGun3\n",PlayerInfo[playerid][pGun3]);fwrite(hFile, var);
			format(var, 32, "%d pGun4\n",PlayerInfo[playerid][pGun4]);fwrite(hFile, var);
			format(var, 32, "%d pGun5\n",PlayerInfo[playerid][pGun5]);fwrite(hFile, var);
			format(var, 32, "%d pGun6\n",PlayerInfo[playerid][pGun6]);fwrite(hFile, var);
			format(var, 32, "%d pAmmo1\n",PlayerInfo[playerid][pAmmo1]);fwrite(hFile, var);
			format(var, 32, "%d pAmmo2\n",PlayerInfo[playerid][pAmmo2]);fwrite(hFile, var);
			format(var, 32, "%d pAmmo3\n",PlayerInfo[playerid][pAmmo3]);fwrite(hFile, var);
			format(var, 32, "%d pAmmo4\n",PlayerInfo[playerid][pAmmo4]);fwrite(hFile, var);
			format(var, 32, "%d pAmmo5\n",PlayerInfo[playerid][pAmmo5]);fwrite(hFile, var);
			format(var, 32, "%d pAmmo6\n",PlayerInfo[playerid][pAmmo6]);fwrite(hFile, var);
			format(var, 32, "%.1f pSHealth\n", PlayerInfo[playerid][pSHealth]);fwrite(hFile, var);
			GetPlayerHealth(playerid,PlayerInfo[playerid][pHealth]);
			format(var, 32, "%.1f pHealth\n", PlayerInfo[playerid][pHealth]);fwrite(hFile, var);
			GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
			if ((PlayerInfo[playerid][pPos_x]==0.0 && PlayerInfo[playerid][pPos_y]==0.0 && PlayerInfo[playerid][pPos_z]==0.0) || (gPlayerFighter[playerid] != 0))
			{
				PlayerInfo[playerid][pPos_x] = 1684.9;
				PlayerInfo[playerid][pPos_y] = -2244.5;
				PlayerInfo[playerid][pPos_z] = 13.5;
			}
			if(Spectate[playerid] != -1)
			{
				PlayerInfo[playerid][pPos_x] = Unspec[playerid][sPx];
				PlayerInfo[playerid][pPos_y] = Unspec[playerid][sPy];
				PlayerInfo[playerid][pPos_z] = Unspec[playerid][sPz];
				PlayerInfo[playerid][pInt] = Unspec[playerid][sPint];
				PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
			}
			format(var, 32, "%.1f pPos_x\n", PlayerInfo[playerid][pPos_x]);fwrite(hFile, var);
			format(var, 32, "%.1f pPos_y\n", PlayerInfo[playerid][pPos_y]);fwrite(hFile, var);
			format(var, 32, "%.1f pPos_z\n", PlayerInfo[playerid][pPos_z]);fwrite(hFile, var);
			format(var, 32, "%d pInt\n",PlayerInfo[playerid][pInt]);fwrite(hFile, var);
			format(var, 32, "%d pLocal\n",PlayerInfo[playerid][pLocal]);fwrite(hFile, var);
			format(var, 32, "%d pTeam\n",PlayerInfo[playerid][pTeam]);fwrite(hFile, var);
			format(var, 32, "%d pModel\n",PlayerInfo[playerid][pModel]);fwrite(hFile, var);
			format(var, 32, "%d pPnumber\n",PlayerInfo[playerid][pPnumber]);fwrite(hFile, var);
			format(var, 32, "%d pPhousekey\n",PlayerInfo[playerid][pPhousekey]);fwrite(hFile, var);
			format(var, 32, "%d pPbiskey\n",PlayerInfo[playerid][pPbiskey]);fwrite(hFile, var);
			fclose(hFile);
		}
	}
	else
	{
		SendClientMessageRus(playerid, COLOR_YELLOW, "Вы не зарегистрированы, введите /regnick <password>");
	}
	if (gdebug){printf("DEBUG PlayerUpdate(%d)End", playerid);}
	return 1;
}

public OnPlayerRename(name[],string[],playerid)
{
	if (gdebug >= 1){printf("DEBUG OnPlayerRename(%d)", playerid);}
	if (gPlayerLogged[playerid] != 0)
	{
		new File: pFile = fopen(string, io_write);
		if (gdebug){printf("DEBUG PlayerUpdate(%d)8.5", playerid);}
		if (pFile)
		{
			new var[32];
			format(var, 32, "%s\n", PlayerInfo[playerid][pPassword]);fwrite(pFile, var);
			fclose(pFile);
			new File: hFile = fopen(string, io_append);
			PlayerInfo[playerid][pCash] = GetPlayerMoney(playerid);
			format(var, 32, "%d pCash\n",PlayerInfo[playerid][pCash]);fwrite(hFile, var);
			format(var, 32, "%d pAccount\n",PlayerInfo[playerid][pAccount]);fwrite(hFile, var);
			format(var, 32, "%d pAdmin\n",PlayerInfo[playerid][pAdmin]);fwrite(hFile, var);
			format(var, 32, "%d pLevel\n",PlayerInfo[playerid][pLevel]);fwrite(hFile, var);
			format(var, 32, "%d pExp\n",PlayerInfo[playerid][pExp]);fwrite(hFile, var);
			format(var, 32, "%d gPupgrade\n",PlayerInfo[playerid][gPupgrade]);fwrite(hFile, var);
			format(var, 32, "%d pKills\n",PlayerInfo[playerid][pKills]);fwrite(hFile, var);
			format(var, 32, "%d pCB\n",PlayerInfo[playerid][pCB]);fwrite(hFile, var);
			format(var, 32, "%d pHW\n",PlayerInfo[playerid][pHW]);fwrite(hFile, var);
			format(var, 32, "%d pSR\n",PlayerInfo[playerid][pSR]);fwrite(hFile, var);
			format(var, 32, "%d pWA\n",PlayerInfo[playerid][pWA]);fwrite(hFile, var);
			format(var, 32, "%d pPEN\n",PlayerInfo[playerid][pPEN]);fwrite(hFile, var);
			format(var, 32, "%d pGun1\n",PlayerInfo[playerid][pGun1]);fwrite(hFile, var);
			format(var, 32, "%d pGun2\n",PlayerInfo[playerid][pGun2]);fwrite(hFile, var);
			format(var, 32, "%d pGun3\n",PlayerInfo[playerid][pGun3]);fwrite(hFile, var);
			format(var, 32, "%d pGun4\n",PlayerInfo[playerid][pGun4]);fwrite(hFile, var);
			format(var, 32, "%d pGun5\n",PlayerInfo[playerid][pGun5]);fwrite(hFile, var);
			format(var, 32, "%d pGun6\n",PlayerInfo[playerid][pGun6]);fwrite(hFile, var);
			format(var, 32, "%d pAmmo1\n",PlayerInfo[playerid][pAmmo1]);fwrite(hFile, var);
			format(var, 32, "%d pAmmo2\n",PlayerInfo[playerid][pAmmo2]);fwrite(hFile, var);
			format(var, 32, "%d pAmmo3\n",PlayerInfo[playerid][pAmmo3]);fwrite(hFile, var);
			format(var, 32, "%d pAmmo4\n",PlayerInfo[playerid][pAmmo4]);fwrite(hFile, var);
			format(var, 32, "%d pAmmo5\n",PlayerInfo[playerid][pAmmo5]);fwrite(hFile, var);
			format(var, 32, "%d pAmmo6\n",PlayerInfo[playerid][pAmmo6]);fwrite(hFile, var);
			format(var, 32, "%.1f pSHealth\n", PlayerInfo[playerid][pSHealth]);fwrite(hFile, var);
			GetPlayerHealth(playerid,PlayerInfo[playerid][pHealth]);
			format(var, 32, "%.1f pHealth\n", PlayerInfo[playerid][pHealth]);fwrite(hFile, var);
			GetPlayerPos(playerid, PlayerInfo[playerid][pPos_x], PlayerInfo[playerid][pPos_y], PlayerInfo[playerid][pPos_z]);
			if ((PlayerInfo[playerid][pPos_x]==0.0 && PlayerInfo[playerid][pPos_y]==0.0 && PlayerInfo[playerid][pPos_z]==0.0) || (gPlayerFighter[playerid] != 0))
			{
				PlayerInfo[playerid][pPos_x] = 1684.9;
				PlayerInfo[playerid][pPos_y] = -2244.5;
				PlayerInfo[playerid][pPos_z] = 13.5;
			}
			if(Spectate[playerid] != -1)
			{
				PlayerInfo[playerid][pPos_x] = Unspec[playerid][sPx];
				PlayerInfo[playerid][pPos_y] = Unspec[playerid][sPy];
				PlayerInfo[playerid][pPos_z] = Unspec[playerid][sPz];
				PlayerInfo[playerid][pInt] = Unspec[playerid][sPint];
				PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
			}
			format(var, 32, "%.1f pPos_x\n", PlayerInfo[playerid][pPos_x]);fwrite(hFile, var);
			format(var, 32, "%.1f pPos_y\n", PlayerInfo[playerid][pPos_y]);fwrite(hFile, var);
			format(var, 32, "%.1f pPos_z\n", PlayerInfo[playerid][pPos_z]);fwrite(hFile, var);
			format(var, 32, "%d pInt\n",PlayerInfo[playerid][pInt]);fwrite(hFile, var);
			format(var, 32, "%d pLocal\n",PlayerInfo[playerid][pLocal]);fwrite(hFile, var);
			format(var, 32, "%d pTeam\n",PlayerInfo[playerid][pTeam]);fwrite(hFile, var);
			format(var, 32, "%d pModel\n",PlayerInfo[playerid][pModel]);fwrite(hFile, var);
			format(var, 32, "%d pPnumber\n",PlayerInfo[playerid][pPnumber]);fwrite(hFile, var);
			format(var, 32, "%d pPhousekey\n",PlayerInfo[playerid][pPhousekey]);fwrite(hFile, var);
			format(var, 32, "%d pPbiskey\n",PlayerInfo[playerid][pPbiskey]);fwrite(hFile, var);
			fclose(hFile);
		}
		new bkey = PlayerInfo[playerid][pPbiskey];
		new hkey = PlayerInfo[playerid][pPhousekey];
		new playername[32];
		if(bkey != -1)
		{
			if(bkey >= 100)
			{
				strmid(SBizzInfo[bkey-100][sbOwner], name, 0, strlen(name), 255);
			}
			else
			{
				strmid(BizzInfo[bkey][bOwner], name, 0, strlen(name), 255);
			}
		}
		GetPlayerName(playerid, playername, sizeof(playername));
		if (hkey != -1 && strcmp(playername, HouseInfo[hkey][hOwner], true) == 0)
		{
			strmid(HouseInfo[hkey][hOwner], name, 0, strlen(name), 255);
		}
		OnPropUpdate();
	}
	else
	{
		SendClientMessageRus(playerid, COLOR_YELLOW, "Вы не зарегистрированы, введите /regnick <password>");
	}
	if (gdebug){printf("DEBUG PlayerUpdate(%d)End", playerid);}
	return 1;
}

public OnPropUpdate()
{
	if (gdebug >= 1){printf("DEBUG OnPropUpdate()");}
	new idx;
	new File: file2;
	while (idx < sizeof(HouseInfo))
	{
		new coordsstring[256];
		format(coordsstring, sizeof(coordsstring), "%f,%f,%f,%f,%f,%f,%d,%d,%d,%d,%d,%d,%s,%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
		HouseInfo[idx][hEntrancex],
		HouseInfo[idx][hEntrancey],
		HouseInfo[idx][hEntrancez],
		HouseInfo[idx][hExitx],
		HouseInfo[idx][hExity],
		HouseInfo[idx][hExitz],
		HouseInfo[idx][hHealthx],
		HouseInfo[idx][hHealthy],
		HouseInfo[idx][hHealthz],
		HouseInfo[idx][hArmourx],
		HouseInfo[idx][hArmoury],
		HouseInfo[idx][hArmourz],
		HouseInfo[idx][hOwner],
		HouseInfo[idx][hDiscription],
		HouseInfo[idx][hValue],
		HouseInfo[idx][hHel],
		HouseInfo[idx][hArm],
		HouseInfo[idx][hInt],
		HouseInfo[idx][hLock],
		HouseInfo[idx][hOwned],
		HouseInfo[idx][hRooms],
		HouseInfo[idx][hRent],
		HouseInfo[idx][hRentabil],
		HouseInfo[idx][hTakings],
		HouseInfo[idx][hVec],
		HouseInfo[idx][hVcol1],
		HouseInfo[idx][hVcol2],
		HouseInfo[idx][hDate],
		HouseInfo[idx][hLevel]);
		if(idx == 0)
		{
			file2 = fopen("property.cfg", io_write);
		}
		else
		{
			file2 = fopen("property.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	idx = 0;
	while (idx < sizeof(BizzInfo))
	{
		new coordsstring[256];
		format(coordsstring, sizeof(coordsstring), "%f,%f,%f,%f,%f,%f,%d,%d,%d,%d,%d,%d,%s,%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
		BizzInfo[idx][bEntrancex],
		BizzInfo[idx][bEntrancey],
		BizzInfo[idx][bEntrancez],
		BizzInfo[idx][bExitx],
		BizzInfo[idx][bExity],
		BizzInfo[idx][bExitz],
		BizzInfo[idx][bHealthx],
		BizzInfo[idx][bHealthy],
		BizzInfo[idx][bHealthz],
		BizzInfo[idx][bArmourx],
		BizzInfo[idx][bArmoury],
		BizzInfo[idx][bArmourz],
		BizzInfo[idx][bOwner],
		BizzInfo[idx][bDiscription],
		BizzInfo[idx][bValue],
		BizzInfo[idx][bHel],
		BizzInfo[idx][bArm],
		BizzInfo[idx][bInt],
		BizzInfo[idx][bLock],
		BizzInfo[idx][bOwned],
		BizzInfo[idx][bEntcost],
		BizzInfo[idx][bTakings],
		BizzInfo[idx][bDate],
		BizzInfo[idx][bLevel],
		BizzInfo[idx][bProd],
		BizzInfo[idx][bProdCap],
		BizzInfo[idx][bComp],
		BizzInfo[idx][bCompCap],
		BizzInfo[idx][bProdCost],
		BizzInfo[idx][bPayComp],
		BizzInfo[idx][bPriceMod]);
		if(idx == 0)
		{
			file2 = fopen("bizz.cfg", io_write);
		}
		else
		{
			file2 = fopen("bizz.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	idx = 0;
	while (idx < sizeof(SBizzInfo))
	{
		new coordsstring[256];
		format(coordsstring, sizeof(coordsstring), "%f,%f,%f,%s,%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n",
		SBizzInfo[idx][sbEntrancex],
		SBizzInfo[idx][sbEntrancey],
		SBizzInfo[idx][sbEntrancez],
		SBizzInfo[idx][sbOwner],
		SBizzInfo[idx][sbDiscription],
		SBizzInfo[idx][sbValue],
		SBizzInfo[idx][sbHel],
		SBizzInfo[idx][sbArm],
		SBizzInfo[idx][sbInt],
		SBizzInfo[idx][sbLock],
		SBizzInfo[idx][sbOwned],
		SBizzInfo[idx][sbEntcost],
		SBizzInfo[idx][sbTakings],
		SBizzInfo[idx][sbDate],
		SBizzInfo[idx][sbLevel],
		SBizzInfo[idx][sbProd],
		SBizzInfo[idx][sbProdCap],
		SBizzInfo[idx][sbComp],
		SBizzInfo[idx][sbCompCap],
		SBizzInfo[idx][sbProdCost],
		SBizzInfo[idx][sbPayComp]);
		if(idx == 0)
		{
			file2 = fopen("sbizz.cfg", io_write);
		}
		else
		{
			file2 = fopen("sbizz.cfg", io_append);
		}
		fwrite(file2, coordsstring);
		idx++;
		fclose(file2);
	}
	return 1;
}

public BroadCast(color, string[])
{
	printf("%s", string);
	SendClientMessageToAllRus(color, string);
	return 1;
}

public ABroadCast(color, string[],level)
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			if ((IsPlayerAdmin(i)) || PlayerInfo[i][pAdmin] >= level)
			{
				SendClientMessageRus(i, color, string);
				printf("%s", string);
			}
		}
	}
	return 1;
}

public OOCOff(color, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1 && !gOoc[i])
		{
			SendClientMessageRus(i, color, string);
		}
	}
}

public PlaySoundAll(playerid, soundid, Float:psx ,Float:psy ,Float:psz)
{
	if (gdebug >= 1){printf("DEBUG PlaySoundAll(%d)", playerid);}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			PlayerPlaySound(i, soundid, psx, psy, psz);
		}
	}
}

public SendTeamMessage(team, color, string[])
{
	if (gdebug >= 1){printf("DEBUG SendTeamMessage(%d)", team);}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1 && gTeam[i] == team)
		{
			SendClientMessageRus(i, color, string);
		}
	}
}

public SendTeamBeepMessage(team, color, string[])
{
	if (gdebug >= 1){printf("DEBUG SendTeamMessage(%d)", team);}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1 && gTeam[i] == team)
		{
			SendClientMessageRus(i, color, string);
			RingTone[i] = 20;
		}
	}
}

public SendEnemyMessage(color, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1 && gTeam[i] >= 3)
		{
			SendClientMessageRus(i, color, string);
		}
	}
}


public SendAdminMessage(color, string[])
{
	if (gdebug >= 1){printf("DEBUG SendAdminMessage()");}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1 && PlayerInfo[i][pAdmin] > 1)
		{
			SendClientMessageRus(i, color, string);
		}
	}
}



public AddCar(carcoords)
{
	new randcol = random(126);
	new randcol2 = 1;
	CreateVehicle(carselect[random(sizeof(carselect))], CarSpawns[carcoords][pos_x], CarSpawns[carcoords][pos_y], CarSpawns[carcoords][pos_z], CarSpawns[carcoords][z_angle], randcol, randcol2, 300);
	//AddStaticVehicle(carselect[rccounter], CarSpawns[carindex][pos_x], CarSpawns[carindex][pos_y], CarSpawns[carindex][pos_z], CarSpawns[carindex][z_angle],randcol,randcol2); // nm
	return 1;
}

public PlayerPlayMusic(playerid)
{
	if (gdebug >= 1){printf("DEBUG PlayerPlayMusic(%d)",playerid);}
	SetTimer("StopMusic", 5000, 0);
	PlayerPlaySound(playerid, 1068, 0.0, 0.0, 0.0);
}

public StopMusic()
{
	if (gdebug >= 1){printf("DEBUG StopMusic()");}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			PlayerPlaySound(i, 1069, 0.0, 0.0, 0.0);
		}
	}
}

public PlayerFixRadio(playerid)
{
	if (gdebug >= 1){printf("DEBUG PlayerPlayMusic(%d)",playerid);}
	SetTimer("PlayerFixRadio2", 50, 0);
	PlayerPlaySound(playerid, 1068, 0.0, 0.0, 0.0);
	Fixr[playerid] = 1;
}

public PlayerFixRadio2()
{
	if (gdebug >= 1){printf("DEBUG StopMusic()");}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			if(Fixr[i])
			{
				PlayerPlaySound(i, 1069, 0.0, 0.0, 0.0);
				Fixr[i] = 0;
			}
		}
	}
}

public PlayJailSound(sound , stopsound, duration, Float:jailx, Float:jaily, Float:jailz)
{
	if (gdebug >= 1){printf("DEBUG PlayJailSound()");}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			PlayerPlaySound(i, sound, jailx, jaily, jailz);
			//printf("startjail %d",i);
			stopsoundt = stopsound;
			jailxt = jailx;
			jailyt = jaily;
			jailzt = jailz;
		}
	}
	SetTimer("StopJail", duration, 0);
}

public StopJail()
{
	if (gdebug >= 1){printf("DEBUG StopJail()");}
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			PlayerPlaySound(i, stopsoundt, jailxt, jailyt, jailzt);
			//printf("stopjail %d",i);
		}
	}
}

//---------------------------<[ OnPlayerCommandText ]>--------------------------------------------------------

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (gdebug >= 1){printf("DEBUG OnPlayerCommandText(%d)",playerid);}
	CmdLog(cmdtext);
	new string[256];
	new playermoney;
	new sendername[MAX_PLAYER_NAME];
	new giveplayer[MAX_PLAYER_NAME];
	new playername[MAX_PLAYER_NAME];
	new cmd[256];
	new tmp[256];
	new giveplayerid, moneys, idx;
	cmd = strtok(cmdtext, idx);


    if(strcmp(cmd,"/kill",true) == 0)
	{
	    SetPlayerHealth(playerid, 0);
	    return 1;
	}
	if(strcmp(cmd,"/pm",true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp) || strlen(tmp) > 5)
			return SendClientMessage(playerid,0xF8DA07FF,"USAGE: /pm [playerid] [text]");
		new receiverid = strval(tmp);
		if(!IsPlayerConnected(receiverid))
			return SendClientMessage(playerid,0xF8DA07FF," Неправильный ID игрока!");
		if(!strlen(cmdtext[idx+1]))
			return SendClientMessage(playerid,0xF8DA07FF,"USAGE: /pm [playerid] [text]");
		OnPlayerPrivmsg(playerid, receiverid, cmdtext[idx+1]);
		return 1;
	}
	if(strcmp(cmd, "/gotoc", true) == 0)
	{
	    if(IsPlayerConnected(playerid) && PlayerInfo[playerid][pAdmin] > 5)
	    {
			new Float:x_c, Float:y_c, Float:z_c;
			tmp = strtok(cmdtext, idx);
			x_c = floatstr(tmp);
			tmp = strtok(cmdtext, idx);
			y_c = floatstr(tmp);
			tmp = strtok(cmdtext, idx);
			z_c = floatstr(tmp);
			SetPlayerPos(playerid, x_c, y_c, z_c);
		}
		return 1;
	}
	if(strcmp(cmd, "/about", true) == 0)
	{
	    SendClientMessage(playerid, 0x00FF0000, "=============================Об этом моде===========================");
	    SendClientMessage(playerid, 0xAAAAAAAA, " Данный мод появился в результате попытки сделать стабильную версию ");
	    SendClientMessage(playerid, 0xAAAAAAAA, " оригинального Public Enemy: LS by Denver, при этом не внося сущес- ");
		SendClientMessage(playerid, 0xAAAAAAAA, " твенных изменений в игровой процесс. ");
		SendClientMessage(playerid, 0xAAAAAAAA, " Автор оригинального мода: Denver ");
		SendClientMessage(playerid, 0xAAAAAAAA, " Русская локализация и модификация: D0lph1N ");
		SendClientMessage(playerid, 0xAAAAAAAA, " Последняя версия мода доступна на форуме http://j-actio.pp.ru/forum");
		format(string, sizeof(string), " На сервере установлена версия Public Enemy: LS v.%s", SCRIPT_VERSION);
		SendClientMessage(playerid, 0xAAAAAAAA, string);
	    SendClientMessage(playerid, 0x00FF0000, "====================================================================");
	    return 1;
	}

	if(strcmp(cmd, "/veh", true) == 0)
	{
	    if(IsPlayerConnected(playerid))
	    {
	        if (PlayerInfo[playerid][pAdmin] < 6)
			{
			    SendClientMessageRus(playerid, COLOR_GRAD1, " Вы не можете использовать эту команду");
			    return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /veh [ID машины] [цвет 1] [цвет 2]");
				return 1;
			}
			new car;
			car = strval(tmp);
			if(car < 400 || car > 611) { SendClientMessageRus(playerid, COLOR_GREY, "Номер машины не может быть ниже 400 или выше 611 !"); return 1; }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /veh [ID машины] [цвет 1] [цвет 2]");
				return 1;
			}
			new color1;
			color1 = strval(tmp);
			if(color1 < 0 || color1 > 126) { SendClientMessageRus(playerid, COLOR_GREY, " Номер цвета не может быть ниже 0 или выше 126 !"); return 1; }
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /veh [ID машины] [цвет 1] [цвет 2]");
				return 1;
			}
			new color2;
			color2 = strval(tmp);
			if(color2 < 0 || color2 > 126) { SendClientMessageRus(playerid, COLOR_GREY, " Номер цвета не может быть ниже 0 или выше 126 !"); return 1; }
			new Float:X,Float:Y,Float:Z,Float:A;
			GetPlayerPos(playerid, X,Y,Z);
			GetPlayerFacingAngle(playerid, A);
			new carint;
			carint = GetPlayerInterior(playerid);
			new carid = CreateVehicle(car, X,Y,Z, A, color1, color2, 60000);
			LinkVehicleToInterior(carid,carint);
			SetVehicleNumberPlate(carid,"-ADMIN");
	     	SetVehicleToRespawn(carid);
	     	CreatedCars[carid] = 1;
			CreatedCar ++;
			format(string, sizeof(string), " Машина %d появилась.", carid);
			SendClientMessageRus(playerid, COLOR_GREY, string);
		}
		return 1;
	}
	if(strcmp(cmd, "/destroycars", true) == 0)
	{
	    if (PlayerInfo[playerid][pAdmin] < 6)
		{
		    SendClientMessageRus(playerid, COLOR_GRAD1, " Вы не можете использовать эту команду");
		    return 1;
		}
		if(CreatedCar)
		{
		    for(new i = 1; i <= MAX_VEHICLES; i++)
		    {
				if(CreatedCars[i])
				{
				    DestroyVehicle(i);
				    CreatedCars[i] = 0;
				    if(!(--CreatedCar)) break;
				}
		    }
		}
	    return 1;
	}
	
//-------------------------------[Pay]--------------------------------------------------------------------------
	if(strcmp(cmd, "/pay", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /pay [playerid/PartOfName] [amount]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, 0xAAAAAAAA, "Неправильный ID");
		if(PlayerInfo[giveplayerid][pLocal] == 106)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Эта команда не работает в данной локации");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /pay [playerid/PartOfName] [amount]");
			return 1;
		}
		moneys = strval(tmp);
		if(moneys > 1000 && PlayerInfo[playerid][pLevel] < 3)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы должны быть 3 уровня, чтобы передавать больше $1000");
			return 1;
		}
		//if (gdebug){printf("DEBUG givecash_command: %d %d",giveplayerid,moneys);}
		if (IsPlayerConnected(giveplayerid))
		{
			if (ProxDetectorS(5.0, playerid, giveplayerid))
			{
				GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				playermoney = GetPlayerMoney(playerid);
				if (moneys > 0 && playermoney >= moneys)
				{
					SafeGivePlayerMoney(playerid, (0 - moneys));
					SafeGivePlayerMoney(giveplayerid, moneys);
					format(string, sizeof(string), "Вы передали %s(ID: %d), $%d.", giveplayer,giveplayerid, moneys);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					SendClientMessageRus(playerid, COLOR_GRAD1, string);
					format(string, sizeof(string), "Вы получили $%d от %s(ID: %d).", moneys, sendername, playerid);
					SendClientMessageRus(giveplayerid, COLOR_GRAD1, string);
					format(string, sizeof(string), "%s передал $%d %s", sendername, moneys, giveplayer);
					PayLog(string);
					if(moneys >= 1000000)
					{
						ABroadCast(COLOR_YELLOW,string,1);
					}
					PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
					format(string, sizeof(string), "* %s вынимает немного наличных, и отдает их %s.", sendername ,giveplayer);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				else
				{
					SendClientMessageRus(playerid, COLOR_GRAD1, "Неправильная сумма.");
				}
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Вы слишком далеко.");
			}
		}
		else
		{
				format(string, sizeof(string), "%d не активный игрок.", giveplayerid);
				SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		return 1;
	}
	if(strcmp(cmd, "/charity", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /charity [amount]");
			return 1;
		}
		if(PlayerInfo[playerid][pLocal] == 106)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Эта команда не работает в данной локации");
			return 1;
		}
		moneys = strval(tmp);
		if(moneys < 0)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "That is not enough.");
			return 1;
		}
		SafeGivePlayerMoney(playerid, (-moneys));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s, спасибо за ваше пожертвование $%d.",sendername, moneys);
		printf("%s", string);
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		SendClientMessageRus(playerid, COLOR_GRAD1, string);
		PayLog(string);
		return 1;
	}
//-------------------------------[Register]--------------------------------------------------------------------------
	if (strcmp(cmd, "/regnick", true)==0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /regnick [password]");
			return 1;
		}
		new flag;
		for(new i = 0; i < strlen(tmp); i++)
		{
			flag = 0;
			for(new j = 0; j < MAX_ALLOWED_CHARS - 1; j++)
			{
				if(allowedchars[j] == tmp[i])
				{
				    flag = 1;
				    break;
				}
			}
			if(!flag)
			{
                SendClientMessageRus(playerid, COLOR_GRAD1, "В пароле используются запрещенные символы. Используйте следующие символы:");
			    return SendClientMessageRus(playerid, COLOR_GRAD1, allowedchars);
			}
		}
		if (gPlayerAccount[playerid] == 1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Аккаунт с таким именем уже зарегистрирован");
			return 1;
		}
		gPlayerAccount[playerid] = 1;
		/*
			SetPlayerInterior(playerid,2);
			SetPlayerPos(playerid,1216.699000,-6.416779,1001.328000);
			SetPlayerFacingAngle(playerid, 90.0);
			SetPlayerCameraPos(playerid,1216.699000-1.5,-6.416779,1001.328000+0.7);
			SetPlayerCameraLookAt(playerid,1216.699000,-6.416779,1001.328000+0.7);
			GameTextForPlayerRus(playerid, "~w~Now Select a character and type /login <your password>", 10000, 3);*/
		strmid(PlayerInfo[playerid][pPassword], tmp, 0, strlen(cmdtext), 255);
		GetPlayerName(playerid, playername, sizeof(playername));
		format(string, sizeof(string), "%s.cer", playername);
		PlayerInfo[playerid][pCash] = GetPlayerMoney(playerid);
		new File: file = fopen(string, io_read);
		if (file)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Аккаунт с таким именем уже зарегистрирован");
			fclose(file);
			return 1;
		}
	//	new Float:px, Float:py, Float:pz;//
	//	new Float:health;//
		//new randphone = 1000 + random(8999);//minimum 1000  max 9999 //giving one at the start
		//PlayerInfo[playerid][pPnumber] = randphone;
		printf("%s has created an account.", playername);
		new File:hFile;
		hFile = fopen(string, io_append);
		new var[32];//
		format(var, 32, "%s\n", PlayerInfo[playerid][pPassword]);fwrite(hFile, var);
		format(var, 32, "%d pCash\n", PlayerInfo[playerid][pCash]);fwrite(hFile, var);
		format(var, 32, "%d pAccount\n", PlayerInfo[playerid][pAccount]);fwrite(hFile, var);
		format(var, 32, "%d pAdmin\n", PlayerInfo[playerid][pAdmin]);fwrite(hFile, var);
		format(var, 32, "%d pLevel\n", PlayerInfo[playerid][pLevel]);fwrite(hFile, var);
		format(var, 32, "%d pExp\n", PlayerInfo[playerid][pExp]);fwrite(hFile, var);
		format(var, 32, "%d gPupgrade\n", PlayerInfo[playerid][gPupgrade]);fwrite(hFile, var);
		format(var, 32, "%d pKills\n", PlayerInfo[playerid][pKills]);fwrite(hFile, var);
		format(var, 32, "%d pCB\n", PlayerInfo[playerid][pCB]);fwrite(hFile, var);
		format(var, 32, "%d pHW\n", PlayerInfo[playerid][pHW]);fwrite(hFile, var);
		format(var, 32, "%d pSR\n", PlayerInfo[playerid][pSR]);fwrite(hFile, var);
		format(var, 32, "%d pWA\n", PlayerInfo[playerid][pWA]);fwrite(hFile, var);
		format(var, 32, "%d pPEN\n", PlayerInfo[playerid][pPEN]);fwrite(hFile, var);
		format(var, 32, "%d pGun1\n", PlayerInfo[playerid][pGun1]);fwrite(hFile, var);
		format(var, 32, "%d pGun2\n", PlayerInfo[playerid][pGun2]);fwrite(hFile, var);
		format(var, 32, "%d pGun3\n", PlayerInfo[playerid][pGun3]);fwrite(hFile, var);
		format(var, 32, "%d pGun4\n", PlayerInfo[playerid][pGun4]);fwrite(hFile, var);
		format(var, 32, "%d pGun5\n", PlayerInfo[playerid][pGun5]);fwrite(hFile, var);
		format(var, 32, "%d pGun6\n", PlayerInfo[playerid][pGun6]);fwrite(hFile, var);
		format(var, 32, "%d pAmmo1\n", PlayerInfo[playerid][pAmmo1]);fwrite(hFile, var);
		format(var, 32, "%d pAmmo2\n", PlayerInfo[playerid][pAmmo2]);fwrite(hFile, var);
		format(var, 32, "%d pAmmo3\n", PlayerInfo[playerid][pAmmo3]);fwrite(hFile, var);
		format(var, 32, "%d pAmmo4\n", PlayerInfo[playerid][pAmmo4]);fwrite(hFile, var);
		format(var, 32, "%d pAmmo5\n", PlayerInfo[playerid][pAmmo5]);fwrite(hFile, var);
		format(var, 32, "%d pAmmo6\n", PlayerInfo[playerid][pAmmo6]);fwrite(hFile, var);
		format(var, 32, "%f pSHealth\n", PlayerInfo[playerid][pSHealth]);fwrite(hFile, var);
		format(var, 32, "%f pHealth\n", PlayerInfo[playerid][pHealth]);fwrite(hFile, var);
		format(var, 32, "%f pPos_x\n", PlayerInfo[playerid][pPos_x]);fwrite(hFile, var);
		format(var, 32, "%f pPos_y\n", PlayerInfo[playerid][pPos_y]);fwrite(hFile, var);
		format(var, 32, "%f pPos_z\n", PlayerInfo[playerid][pPos_z]);fwrite(hFile, var);
		if(accountplay)
		{
			PlayerInfo[playerid][pInt] = 0;
		}
		format(var, 32, "%d pInt\n", PlayerInfo[playerid][pInt]);fwrite(hFile, var);
		format(var, 32, "%d pLocal\n", PlayerInfo[playerid][pLocal]);fwrite(hFile, var);
		format(var, 32, "%d pTeam\n", PlayerInfo[playerid][pTeam]);fwrite(hFile, var);
		format(var, 32, "%d pModel\n", PlayerInfo[playerid][pModel]);fwrite(hFile, var);
		format(var, 32, "%d pPnumber\n", PlayerInfo[playerid][pPnumber]);fwrite(hFile, var);
		format(var, 32, "%d pPhousekey\n", PlayerInfo[playerid][pPhousekey]);fwrite(hFile, var);
		format(var, 32, "%d pPbiskey\n", PlayerInfo[playerid][pPbiskey]);fwrite(hFile, var);
		fclose(hFile);
		SendClientMessageRus(playerid, COLOR_WHITE, "СЕРВЕР: при следующем подключении используйте (/login <password>) чтобы войти.");
		OnPlayerLogin(playerid,PlayerInfo[playerid][pPassword]);
		return 1;
	}
//-------------------------------[Register]--------------------------------------------------------------------------
	if (strcmp(cmd, "/changepass", true)==0)
	{
		tmp = strtok(cmdtext, idx);
		if (gPlayerLogged[playerid] != 1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы");
			return 1;
		}
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /changepass [password]");
			return 1;
		}
		new flag;
		for(new i = 0; i < strlen(tmp); i++)
		{
			flag = 0;
			for(new j = 0; j < MAX_ALLOWED_CHARS - 1; j++)
			{
				if(allowedchars[j] == tmp[i])
				{
				    flag = 1;
				    break;
				}
			}
			if(!flag)
			{
                SendClientMessageRus(playerid, COLOR_GRAD1, "В пароле используются запрещенные символы. Используйте следующие символы:");
			    return SendClientMessageRus(playerid, COLOR_GRAD1, allowedchars);
			}
		}
		strmid(PlayerInfo[playerid][pPassword], tmp, 0, strlen(cmdtext), 255);
		format(string, sizeof(string), "Ваш новый пароль %s не забудьте его", PlayerInfo[playerid][pPassword]);
		SendClientMessageRus(playerid, COLOR_YELLOW, string);
		PlayerUpdate(playerid);
		GetPlayerName(playerid, playername, sizeof(playername));
		printf("%s has changed there password.", playername);
		return 1;
	}
	if (strcmp(cmd, "/changenick", true)==0)
	{
		tmp = strtok(cmdtext, idx);
		new string2[256];
		if (gPlayerLogged[playerid] != 1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы");
			return 1;
		}
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /changename [newname]");
			return 1;
		}
		format(string, sizeof(string), "%s.cer", tmp);
		if(fexist(string))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Аккаунт с таким именем уже зарегистрирован");
			return 1;
		}
		OnPlayerRename(tmp,string,playerid);
		format(string, sizeof(string), "Теперь вы можете переподключиться с ником %s", tmp);
		SendClientMessageRus(playerid, COLOR_YELLOW, string);
		GetPlayerName(playerid, playername, sizeof(playername));
		format(string2, sizeof(string2), "%s.cer", playername);
		printf("%s has changed there name to %s.", playername,tmp);
		gPlayerLogged[playerid] = 0;
		fremove(string2);
		return 1;
	}
//-------------------------------[Level]--------------------------------------------------------------------------
	if (strcmp(cmd, "/level", true) == 0)
	{
		if (gPlayerLogged[playerid] != 0)
		{
			PrintPlayerWeapons(playerid,playerid);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы");
		}
		return 1;
	}
	if(strcmp(cmd, "/dn", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			new Float:slx, Float:sly, Float:slz;
			GetPlayerPos(playerid, slx, sly, slz);
			SetPlayerPos(playerid, slx, sly, slz-2);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не админ");
		}
		return 1;
	}
	if(strcmp(cmd, "/up", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			new Float:slx, Float:sly, Float:slz;
			GetPlayerPos(playerid, slx, sly, slz);
			SetPlayerPos(playerid, slx, sly, slz+2);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не админ");
		}
		return 1;
	}
	if (strcmp("/fly", cmd, true) == 0)
    {
        if(IsPlayerConnected(playerid))
        {
        if (PlayerInfo[playerid][pAdmin] >= 1)
        {
            new radius[12];
            strmid(radius, strtok(cmdtext, idx), 0, sizeof(radius));
            new vertdelta[12];
            strmid(vertdelta, strtok(cmdtext, idx), 0, sizeof(vertdelta));
            if(!strlen(radius)||!strlen(vertdelta))
            {
                SendClientMessageRus(playerid, 0x01FCFFC8, " ИСПОЛЬЗОВАНИЕ: /fly [radius] [vdelta]");
                return 1;
            }
            MovePlayer(playerid, strval(radius), 0.0, strval(vertdelta));
            SendClientMessageRus(playerid, 0xAAAAAAAA, " Вы были телепортированы!");
        }
        else
        {
			SendClientMessageRus(playerid, 0x01FCFFC8, " Вы не админ!");}
        }
        return 1;
    }
	if(strcmp(cmd, "/lt", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			new Float:slx, Float:sly, Float:slz;
			GetPlayerPos(playerid, slx, sly, slz);
			SetPlayerPos(playerid, slx, sly+2, slz);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не админ");
		}
		return 1;
	}
	if(strcmp(cmd, "/rt", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			new Float:slx, Float:sly, Float:slz;
			GetPlayerPos(playerid, slx, sly, slz);
			SetPlayerPos(playerid, slx, sly-2, slz-2);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не админ");
		}
		return 1;
	}
//-------------------------------[Stats]--------------------------------------------------------------------------
	if (strcmp(cmd, "/stats", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /stats [playerid/PartOfName]");
				return 1;
			}
			if(IsStringAName(tmp))
			{
				giveplayerid = GetPlayerID(tmp);
			}
			else
			{
				giveplayerid = strval(tmp);
			}
			if(IsPlayerConnected(giveplayerid))
			{
				PrintPlayerWeapons(playerid,giveplayerid);
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Нет такого игрока");
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не админ");
		}
	}
	if (strcmp(cmd, "/number", true) == 0)
	{
		if (gPhoneBook[playerid] == 1)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /number [playerid/PartOfName]");
				return 1;
			}
			if(IsStringAName(tmp))
			{
				giveplayerid = GetPlayerID(tmp);
			}
			else
			{
				giveplayerid = strval(tmp);
			}
			if(IsPlayerConnected(giveplayerid))
			{
				GetPlayerName(giveplayerid, sendername, sizeof(sendername));
				format(string, 256, "Имя: %s, Телефон: %d",sendername,PlayerInfo[giveplayerid][pPnumber]);
				SendClientMessageRus(playerid, COLOR_GRAD1, string);
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Нет такого игрока");
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "У вас нет телефонной книги");
		}
	}
//-------------------------------[BuyLevel]--------------------------------------------------------------------------
	if (strcmp(cmd, "/buylevel", true) == 0)
	{
		if (gPlayerLogged[playerid] != 0)
		{
			PlayerInfo[playerid][pCash] = GetPlayerMoney(playerid);//
			if (gdebug){printf("DEBUG buylev cash = %d", PlayerInfo[playerid][pCash]);}
			if(PlayerInfo[playerid][pLevel] >= 0)
			{
				new nxtlevel = PlayerInfo[playerid][pLevel]+1;
				new costlevel = nxtlevel*levelcost;//10k for testing purposes
				new expamount = nxtlevel*levelexp;
				new infostring[256];
				if (PlayerInfo[playerid][pCash] < costlevel)
				{
					format(infostring, 256, "У вас недостаточно денег ($%d)",costlevel);
					SendClientMessageRus(playerid, COLOR_GRAD1, infostring);
				}
				if (PlayerInfo[playerid][pExp] < expamount)
				{
					format(infostring, 256, "Вам нужно %d очков опыта, вместо имеющихся %d",expamount,PlayerInfo[playerid][pExp]);
					SendClientMessageRus(playerid, COLOR_GRAD1, infostring);
				}
				else
				{
					format(string, sizeof(string), "~g~Уровень повышен~n~~w~Теперь вы %d уровня", nxtlevel);
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					PlayerPlayMusic(playerid);
					SafeGivePlayerMoney(playerid, (-costlevel));
					PlayerInfo[playerid][pLevel]++;
					PlayerInfo[playerid][pExp] = 0;
					PlayerInfo[playerid][gPupgrade] = PlayerInfo[playerid][gPupgrade]+2;
					GameTextForPlayerRus(playerid, string, 5000, 1);
					format(infostring, 256, "Вы приобрели уровень %d за ($%d) Введите /upgrade", nxtlevel, costlevel);
					SendClientMessageRus(playerid, COLOR_GRAD1, infostring);
					format(infostring, 256, "У вас %d неиспользованных апгрейдов",PlayerInfo[playerid][gPupgrade]);
					SendClientMessageRus(playerid, COLOR_GRAD2, infostring);
				}
			}
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы");
		}
	}
//-------------------------------[UPGRADE]--------------------------------------------------------------------------
	if (strcmp(cmd, "/carcolor", true) == 0)
	{
		new house = PlayerInfo[playerid][pPhousekey];
		GetPlayerName(playerid, playername, sizeof(playername));
		if (house != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD3,"($5000) ИСПОЛЬЗОВАНИЕ: /carcolor [color 1 - 2] [color number]");
				return 1;
			}
			new colornum = strval(tmp);
			if(colornum > 2 || colornum < 1)
			{
				SendClientMessageRus(playerid, COLOR_GRAD3,"Выберите, 1 или 2 цвет хотите изменить");
				return 1;
			}
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD3,"($5000) ИСПОЛЬЗОВАНИЕ: /carcolor [color 1 - 2] [color number]");
			}
			new color = strval(tmp);
			if(color > 126)
			{
				SendClientMessageRus(playerid, COLOR_GRAD3,"Максимальный цвет 126");
				return 1;
			}
			if (GetPlayerMoney(playerid) < 5000)
			{
				SendClientMessageRus(playerid, COLOR_GRAD3,"У вас недостаточно денег ($5000)");
			}
			if(colornum == 1)
			{
				HouseInfo[house][hVcol1] = color;
				format(string, sizeof(string), "Цвет машины 1 изменен на %d -$5000",color);
				SendClientMessageRus(playerid, COLOR_GRAD3,string);
			}
			else
			{
				HouseInfo[house][hVcol2] = color;
				format(string, sizeof(string), "Цвет машины 2 изменен на %d -$5000",color);
				SendClientMessageRus(playerid, COLOR_GRAD3,string);
			}
			SendClientMessageRus(playerid, COLOR_GRAD6, "Ваша новая покраска будет доступна в течение 24 часов");
			SafeGivePlayerMoney(playerid,-5000);
			SBizzInfo[6][sbTakings] = SBizzInfo[6][sbTakings]+5000;
			PlayerPlaySound(giveplayerid, 1134, 0.0, 0.0, 0.0);
			OnPropUpdate();
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "У вас нет дома");
			return 1;
		}
		return 1;
	}
	if (strcmp(cmd, "/carupgrade", true) == 0)
	{
		new house = PlayerInfo[playerid][pPhousekey];
		GetPlayerName(playerid, playername, sizeof(playername));
		if (house != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
		{
			new gunid[16];
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				format(string, sizeof(string), "USAGE: /carupgrade [carname]");
				SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
				SendClientMessageRus(playerid, COLOR_WHITE,"*** Апгрейды авто. Цена $100000 ***");
				SendClientMessageRus(playerid, COLOR_GRAD2,string);
				if(PlayerInfo[playerid][pLevel] == 3)
				{
					SendClientMessageRus(playerid, COLOR_GRAD3, "Машины 3 уровня: freeway feltzer saber blade vortex quad");
				}
				else if(PlayerInfo[playerid][pLevel] == 4)
				{
					SendClientMessageRus(playerid, COLOR_GRAD3, "Машины 4 уровня: freeway feltzer saber blade savanna remington vortex quad");
				}
				else if(PlayerInfo[playerid][pLevel] == 5)
				{
					SendClientMessageRus(playerid, COLOR_GRAD3, "Машины 5 уровня: freeway feltzer saber blade savanna remington buccaneer flash vortex quad");
				}
				else if(PlayerInfo[playerid][pLevel] == 6)
				{
					SendClientMessageRus(playerid, COLOR_GRAD3, "Машины 6 уровня: freeway feltzer saber blade savanna remington buccaneer flash");
					SendClientMessageRus(playerid, COLOR_GRAD2, "Машины 6 уровня: slamvan uranus sultan vortex quad sanchez");
				}
				else if(PlayerInfo[playerid][pLevel] == 7)
				{
					SendClientMessageRus(playerid, COLOR_GRAD3, "Машины 7 уровня: freeway feltzer saber blade savanna remington buccaneer flash");
					SendClientMessageRus(playerid, COLOR_GRAD2, "Машины 7 уровня: slamvan uranus sultan jester elergy vortex quad sanchez");
				}
				else if(PlayerInfo[playerid][pLevel] == 8)
				{
					SendClientMessageRus(playerid, COLOR_GRAD3, "Машины 8 уровня: freeway feltzer saber blade savanna remington buccaneer flash");
					SendClientMessageRus(playerid, COLOR_GRAD2, "Машины 8 уровня: slamvan uranus sultan jester elergy supergt blistac vortex quad sanchez");
				}
				else if(PlayerInfo[playerid][pLevel] == 9)
				{
					SendClientMessageRus(playerid, COLOR_GRAD3, "Машины 9 уровня: freeway feltzer saber blade savanna remington buccaneer flash sandking");
					SendClientMessageRus(playerid, COLOR_GRAD2, "Машины 9 уровня: slamvan uranus sultan jester elergy supergt blistac zr350 vortex quad sanchez");
				}
				else if(PlayerInfo[playerid][pLevel] == 10)
				{
					SendClientMessageRus(playerid, COLOR_GRAD3, "Машины 10 уровня: freeway feltzer saber blade savanna remington buccaneer flash sandking quad sanchez");
					SendClientMessageRus(playerid, COLOR_GRAD2, "Машины 10 уровня: slamvan uranus sultan jester elergy supergt blistac zr350 cheetah vortex duneride");
				}
				else if(PlayerInfo[playerid][pLevel] == 11)
				{
					SendClientMessageRus(playerid, COLOR_GRAD3, "Машины 11 уровня: freeway feltzer saber blade savanna remington buccaneer flash sandking");
					SendClientMessageRus(playerid, COLOR_GRAD2, "Машины 11 уровня: slamvan uranus sultan jester elergy supergt blistac zr350 cheetah");
					SendClientMessageRus(playerid, COLOR_GRAD1, "Машины 11 уровня: banshee fcr900 comet vortex quad duneride sanchez");
				}
				else if(PlayerInfo[playerid][pLevel] == 12)
				{
					SendClientMessageRus(playerid, COLOR_GRAD3, "Машины 12 уровня: freeway feltzer saber blade savanna remington buccaneer flash sandking");
					SendClientMessageRus(playerid, COLOR_GRAD2, "Машины 12 уровня: slamvan uranus sultan jester elergy supergt blistac zr350 cheetah");
					SendClientMessageRus(playerid, COLOR_GRAD1, "Машины 12 уровня: banshee fcr900 comet hotring vortex quad duneride sanchez");
				}
				else if(PlayerInfo[playerid][pLevel] == 13)
				{
					SendClientMessageRus(playerid, COLOR_GRAD3, "Машины 13 уровня: freeway feltzer saber blade savanna remington buccaneer flash sandking");
					SendClientMessageRus(playerid, COLOR_GRAD2, "Машины 13 уровня: slamvan uranus sultan jester elergy supergt blistac zr350 cheetah");
					SendClientMessageRus(playerid, COLOR_GRAD1, "Машины 13 уровня: banshee fcr900 comet hotring turismo bullet vortex quad duneride sanchez");
				}
				else if(PlayerInfo[playerid][pLevel] == 14)
				{
					SendClientMessageRus(playerid, COLOR_GRAD3, "Машины 14 уровня: freeway feltzer saber blade savanna remington buccaneer flash sandking");
					SendClientMessageRus(playerid, COLOR_GRAD2, "Машины 14 уровня: slamvan uranus sultan jester elergy supergt blistac zr350 cheetah sanchez");
					SendClientMessageRus(playerid, COLOR_GRAD1, "Машины 14 уровня: banshee fcr900 comet hotring turismo bullet infurnus vortex quad duneride");
				}
				else if(PlayerInfo[playerid][pLevel] >= 15)
				{
					SendClientMessageRus(playerid, COLOR_GRAD3, "Машины 15 уровня: freeway feltzer saber blade savanna remington buccaneer flash sandking");
					SendClientMessageRus(playerid, COLOR_GRAD2, "Машины 15 уровня: slamvan uranus sultan jester elergy supergt blistac zr350 cheetah sanchez");
					SendClientMessageRus(playerid, COLOR_GRAD1, "Машины 15 уровня: banshee fcr900 comet hotring turismo bullet infurnus monster monstera");
					SendClientMessageRus(playerid, COLOR_GRAD1, "Машины 15 уровня: monsterb vortex quad duneride bfinject stretch");
				}
				SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
				return 1;
			}
			if(SBizzInfo[6][sbProd] == 0)
			{
				GameTextForPlayerRus(playerid, "~r~Нет компонентов", 5000, 1);
				return 1;
			}
			strmid(gunid, tmp, 0, strlen(cmdtext), 255);
			if (GetPlayerMoney(playerid) > 100000)
			{
				if (PlayerInfo[playerid][pLevel] >= 18 && (strcmp(gunid, "nrg500", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь Nrg-500");
					HouseInfo[house][hVec] = 522;
				}
				else if (PlayerInfo[playerid][pLevel] >= 15 && (strcmp(gunid, "monster", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь monster");
					HouseInfo[house][hVec] = 444;
				}
				else if (PlayerInfo[playerid][pLevel] >= 15 && (strcmp(gunid, "stretch", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь stretch");
					HouseInfo[house][hVec] = 409;
				}
				else if (PlayerInfo[playerid][pLevel] >= 15 && (strcmp(gunid, "monstera", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь monstera");
					HouseInfo[house][hVec] = 556;
				}
				else if (PlayerInfo[playerid][pLevel] >= 15 && (strcmp(gunid, "monsterb", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь monsterb");
					HouseInfo[house][hVec] = 557;
				}

				else if (PlayerInfo[playerid][pLevel] >= 16 && (strcmp(gunid, "infurnus", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь infernus");
					HouseInfo[house][hVec] = 411;
				}

				else if (PlayerInfo[playerid][pLevel] >= 13 && (strcmp(gunid, "bullet", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь bullet");
					HouseInfo[house][hVec] = 541;
				}
				else if (PlayerInfo[playerid][pLevel] >= 13 && (strcmp(gunid, "turismo", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь turismo");
					HouseInfo[house][hVec] = 451;
				}
				else if (PlayerInfo[playerid][pLevel] >= 12 && (strcmp(gunid, "hotring", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь hotring");
					HouseInfo[house][hVec] = 502;
				}
				else if (PlayerInfo[playerid][pLevel] >= 11 && (strcmp(gunid, "banshee", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь banshee");
					HouseInfo[house][hVec] = 429;
				}
				else if (PlayerInfo[playerid][pLevel] >= 11 && (strcmp(gunid, "fbiranch", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь fbiranch");
					HouseInfo[house][hVec] = 490;
				}
				else if (PlayerInfo[playerid][pLevel] >= 11 && (strcmp(gunid, "comet", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь comet");
					HouseInfo[house][hVec] = 480;
				}
				else if (PlayerInfo[playerid][pLevel] >= 11 && (strcmp(gunid, "fcr900", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь fcr900");
					HouseInfo[house][hVec] = 521;
				}
				else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "cheetah", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь cheetah");
					HouseInfo[house][hVec] = 415;
				}
				else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "hotknife", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь hotknife");
					HouseInfo[house][hVec] = 434;
				}
				else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "enforcer", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь enforcer");
					HouseInfo[house][hVec] = 427;
				}
				else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "duneride", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь duneride");
					HouseInfo[house][hVec] = 573;
				}
				else if (PlayerInfo[playerid][pLevel] >= 9 && (strcmp(gunid, "zr350", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь zr350");
					HouseInfo[house][hVec] = 477;
				}
				else if (PlayerInfo[playerid][pLevel] >= 9 && (strcmp(gunid, "sandking", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь sandking");
					HouseInfo[house][hVec] = 495;
				}
				else if (PlayerInfo[playerid][pLevel] >= 8 && (strcmp(gunid, "blistac", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь blistac");
					HouseInfo[house][hVec] = 496;
				}
				else if (PlayerInfo[playerid][pLevel] >= 8 && (strcmp(gunid, "supergt", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь supergt");
					HouseInfo[house][hVec] = 506;
				}
				else if (PlayerInfo[playerid][pLevel] >= 7 && (strcmp(gunid, "elergy", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь elergy");
					HouseInfo[house][hVec] = 562;
				}
				else if (PlayerInfo[playerid][pLevel] >= 7 && (strcmp(gunid, "jester", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь jester");
					HouseInfo[house][hVec] = 559;
				}
				else if (PlayerInfo[playerid][pLevel] >= 6 && (strcmp(gunid, "sultan", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь sultan");
					HouseInfo[house][hVec] = 560;
				}
				else if (PlayerInfo[playerid][pLevel] >= 6 && (strcmp(gunid, "sanchez", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь sanchez");
					HouseInfo[house][hVec] = 468;
				}
				else if (PlayerInfo[playerid][pLevel] >= 6 && (strcmp(gunid, "huntley", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь huntley");
					HouseInfo[house][hVec] = 579;
				}
				else if (PlayerInfo[playerid][pLevel] >= 6 && (strcmp(gunid, "slamvan", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь slamvan");
					HouseInfo[house][hVec] = 535;
				}
				else if (PlayerInfo[playerid][pLevel] >= 5 && (strcmp(gunid, "flash", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь flash");
					HouseInfo[house][hVec] = 565;
				}
				else if (PlayerInfo[playerid][pLevel] >= 5 && (strcmp(gunid, "buccaneer", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь buccaneer");
					HouseInfo[house][hVec] = 518;
				}
				else if (PlayerInfo[playerid][pLevel] >= 4 && (strcmp(gunid, "savanna", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь savanna");
					HouseInfo[house][hVec] = 567;
				}
				else if (PlayerInfo[playerid][pLevel] >= 4 && (strcmp(gunid, "remington", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь remington");
					HouseInfo[house][hVec] = 534;
				}
				else if (PlayerInfo[playerid][pLevel] >= 4 && (strcmp(gunid, "journey", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь journey");
					HouseInfo[house][hVec] = 508;
				}
				else if (PlayerInfo[playerid][pLevel] >= 4 && (strcmp(gunid, "rancher", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь rancher");
					HouseInfo[house][hVec] = 489;
				}
				else if (PlayerInfo[playerid][pLevel] >= 3 && (strcmp(gunid, "huntly", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь huntly");
					HouseInfo[house][hVec] = 579;
				}
				else if (PlayerInfo[playerid][pLevel] >= 3 && (strcmp(gunid, "copcar", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь copcar");
					HouseInfo[house][hVec] = 596;
				}
				else if (PlayerInfo[playerid][pLevel] >= 3 && (strcmp(gunid, "blade", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь blade");
					HouseInfo[house][hVec] = 536;
				}
				else if (PlayerInfo[playerid][pLevel] >= 3 && (strcmp(gunid, "buffalo", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь buffalo");
					HouseInfo[house][hVec] = 402;
				}
				else if (PlayerInfo[playerid][pLevel] >= 3 && (strcmp(gunid, "saber", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь saber");
					HouseInfo[house][hVec] = 475;
				}
				else if (PlayerInfo[playerid][pLevel] >= 3 && (strcmp(gunid, "feltzer", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь feltzer");
					HouseInfo[house][hVec] = 533;
				}
				else if (PlayerInfo[playerid][pLevel] >= 3 && (strcmp(gunid, "freeway", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь freeway");
					HouseInfo[house][hVec] = 463;
				}
				else if (PlayerInfo[playerid][pLevel] >= 3 && (strcmp(gunid, "vortex", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь vortex");
					HouseInfo[house][hVec] = 539;
				}
				else if (PlayerInfo[playerid][pLevel] >= 3 && (strcmp(gunid, "quad", true, strlen(gunid)) == 0))
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: ваше домашнее авто теперь quad");
					HouseInfo[house][hVec] = 471;
				}
				else
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "Неизвестная машина");
					return 1;
				}
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новое авто будет доставлено в течение 24 часов -$100000");
				OnPropUpdate();
				SafeGivePlayerMoney(playerid,-100000);
				SBizzInfo[6][sbTakings] = SBizzInfo[6][sbTakings]+100000;
				SBizzInfo[6][sbProd]--;
				PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "У вас недостаточно денег ($100000)");
				return 1;
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "У вас нет дома");
			return 1;
		}
	}
	if (strcmp(cmd, "/resetupgrades", true) == 0)
	{
		if (gPlayerLogged[playerid] == 0)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы");
			return 1;
		}
		if (GetPlayerMoney(playerid) < 100000)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "У вас недостаточно денег ($100000)");
			return 1;
		}
		if (PlayerInfo[playerid][pLevel] < 2)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Нужно быть минимум 2 уровня");
			return 1;
		}
		PlayerInfo[playerid][gPupgrade] = (PlayerInfo[playerid][pLevel]-1)*2;
		PlayerInfo[playerid][pGun1] = 0;
		PlayerInfo[playerid][pGun2] = 0;
		PlayerInfo[playerid][pGun3] = 0;
		PlayerInfo[playerid][pGun4] = 0;
		PlayerInfo[playerid][pGun5] = 0;
		PlayerInfo[playerid][pGun6] = 0;
		PlayerInfo[playerid][pAmmo1] = 200;
		PlayerInfo[playerid][pAmmo2] = 8;
		PlayerInfo[playerid][pAmmo3] = 30;
		PlayerInfo[playerid][pAmmo4] = 30;
		PlayerInfo[playerid][pAmmo5] = 10;
		PlayerInfo[playerid][pAmmo6] = 10;
		PlayerInfo[playerid][pSHealth] = 0.0;
		SafeGivePlayerMoney(playerid,-100000);
		//SBizzInfo[6][sbTakings] = SBizzInfo[6][sbTakings]+100000;
		PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
		format(string, 256, "У вас %d неиспользованных апгрейдов",PlayerInfo[playerid][gPupgrade]);
		SendClientMessageRus(playerid, COLOR_GRAD2, string);
	}
	if(strcmp(cmd, "/bestbuy", true) == 0)
	{
		new tmpprice;
		new store;
		if(Locator[playerid] == 0)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Заключите договор с диспетчерской.");
			return 1;
		}
		for(new i = 0; i < sizeof(BizzInfo); i++)
		{
			if(BizzInfo[i][bPriceMod] < tmpprice && BizzInfo[i][bEntcost] == 0 && BizzInfo[i][bProd] > 0)
			{
				tmpprice = BizzInfo[i][bPriceMod];
				store = i;
			}
			for(new j = 0; j < sizeof(BizzInfo); j++)
			{
			 	if(BizzInfo[j][bPriceMod] < tmpprice && BizzInfo[j][bEntcost] == 0 && BizzInfo[j][bProd] > 0)
			 	{
			 		tmpprice = BizzInfo[j][bPriceMod];
			 		store = j;
				}
			}
		}
		SetPlayerCheckpointFixed(playerid,BizzInfo[store][bEntrancex], BizzInfo[store][bEntrancey], BizzInfo[store][bEntrancez], 4.0);
		gPlayerCheckpointStatus[playerid] = CHECKPOINT_HOME;
		GameTextForPlayerRus(playerid, "~w~Маркер установлен ~r~Best Buy", 5000, 1);
		return 1;
	}
	if(strcmp(cmd, "/bestsale", true) == 0)
	{
		new tmpprice = 0;
		new store = -1;
		if(Locator[playerid] == 0)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Заключите договор с диспетчерской");
			return 1;
		}
		for(new i = 0; i < sizeof(BizzInfo); i++)
		{
			if(BizzInfo[i][bPayComp] > tmpprice && BizzInfo[i][bCompCap] > BizzInfo[i][bComp] && BizzInfo[i][bTakings] > BizzInfo[i][bPayComp])
			{
				tmpprice = BizzInfo[i][bPayComp];
				store = i;
			}
			for(new j = 0; j < sizeof(BizzInfo); j++)
			{
			 	if(store != -1 && BizzInfo[j][bPayComp] > tmpprice && BizzInfo[j][bCompCap] > BizzInfo[j][bComp] && BizzInfo[j][bTakings] > BizzInfo[j][bPayComp])
			 	{
			 		tmpprice = BizzInfo[j][bPayComp];
			 		store = j;
				}
			}
		}
		if(store == -1)
		{
			GameTextForPlayerRus(playerid, "~w~В данный момент ничего не продается.", 5000, 1);
			return 1;
		}
		SetPlayerCheckpointFixed(playerid,BizzInfo[store][bEntrancex], BizzInfo[store][bEntrancey], BizzInfo[store][bEntrancez], 4.0);
		gPlayerCheckpointStatus[playerid] = CHECKPOINT_HOME;
		GameTextForPlayerRus(playerid, "~w~Маркер установлен ~r~Best Sale", 5000, 1);
		return 1;
	}
	if (strcmp(cmd, "/buygun", true) == 0)
	{
		new gun;
		new gunid[16];
		new gunstring1[256];
		new gunstring2[256];
		new gunstring3[256];
		new gunstring4[256];
		new gunstring5[256];
		new infostring[256];
		new guncharge;
		new ammocharge;
		new location = PlayerInfo[playerid][pLocal];
		if(location < 99 || location == -1)
		{
			SendClientMessageRus(playerid, COLOR_WHITE,"Вы не в оружейном магазине.");
			return 1;
		}
		new mod = (BizzInfo[location-99][bPriceMod]);
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			format(string, sizeof(string), "ИСПОЛЬЗОВАНИЕ: /buygun [gunname] [ammoamount]");
			SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
			SendClientMessageRus(playerid, COLOR_WHITE,"*** Guns & Ammo ***");
			SendClientMessageRus(playerid, COLOR_GRAD2,string);
			format(gunstring1, 256, "Оружие: parachute ($%d) golfclub ($%d) nightstick ($%d) knife ($%d) baseballbat ($%d) shovel ($%d) poolcue ($%d)",
			GunPrice[0][0]/100*mod,GunPrice[1][0]/100*mod,GunPrice[2][0]/100*mod,GunPrice[3][0]/100*mod,GunPrice[4][0]/100*mod,GunPrice[5][0]/100*mod,GunPrice[6][0]/100*mod);
			SendClientMessageRus(playerid, COLOR_GRAD3, gunstring1);
			format(gunstring2, 256, "Оружие: purpledildo ($%d) whitedildo ($%d) longwhitedildo ($%d) whitedildo2 ($%d) flowers ($%d) cane",
			GunPrice[7][0]/100*mod,GunPrice[8][0]/100*mod,GunPrice[9][0]/100*mod,GunPrice[10][0]/100*mod,GunPrice[11][0]/100*mod,GunPrice[12][0]/100*mod);
			SendClientMessageRus(playerid, COLOR_GRAD3, gunstring2);
			format(gunstring3, 256, "Оружие: sdpistol ($%d) colt45 ($%d) deagle ($%d) tec9 ($%d)  uzi ($%d) mp5 ($%d)",
			GunPrice[13][0]/100*mod,GunPrice[14][0]/100*mod,GunPrice[15][0]/100*mod,GunPrice[16][0]/100*mod,GunPrice[17][0]/100*mod,GunPrice[18][0]/100*mod);
			SendClientMessageRus(playerid, COLOR_GRAD3, gunstring3);
			format(gunstring4, 256, "Оружие: shotgun ($%d) spas12 ($%d)sawnoff ($%d) ak47 ($%d) m4 ($%d) rifle ($%d)",
			GunPrice[19][0]/100*mod,GunPrice[20][0]/100*mod,GunPrice[21][0]/100*mod,GunPrice[22][0]/100*mod,GunPrice[23][0]/100*mod,GunPrice[24][0]/100*mod);
			SendClientMessageRus(playerid, COLOR_GRAD3, gunstring4);
			format(gunstring5, 256, "Оружие: pistolammo ($%d) shotgunammo ($%d) smgammo ($%d) assaultammo ($%d) rifleammo ($%d)",
			GunPrice[25][0],GunPrice[26][0],GunPrice[27][0],GunPrice[28][0],GunPrice[29][0]);
			SendClientMessageRus(playerid, COLOR_GRAD3, gunstring5);
			SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
			return 1;
		}
		strmid(gunid, tmp, 0, strlen(cmdtext), 255);
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			format(string, sizeof(string), "ИСПОЛЬЗОВАНИЕ: /buygun [gunname] [ammoamount]");
			return 1;
		}
		new ammo = strval(tmp);
		/*
		if (PlayerInfo[playerid][pLevel] >= 13 && (strcmp(gunid, "minigun", true, strlen(gunid)) == 0))
		{
			SendClientMessageRus(playerid, COLOR_GRAD6, "New Upgrade: You Will Now Spawn With A minigun");
			PlayerInfo[playerid][pGun6] = 38;
			ResetPlayerWeapons(playerid);
			SetPlayerWeapons(playerid);
			PlayerInfo[playerid][gPupgrade]--;
		}

		if (PlayerInfo[playerid][pLevel] >= 12 && (strcmp(gunid, "flamethrower", true, strlen(gunid)) == 0))
		{
			SendClientMessageRus(playerid, COLOR_GRAD6, "New Upgrade: You Will Now Spawn With A flamethrower");
			PlayerInfo[playerid][pGun6] = 37;
		}
		*/
		if (strcmp(gunid, "parachute", true, strlen(gunid)) == 0)
		{
			gun = 46;
			guncharge = GunPrice[0][0]/100*mod;
			ammocharge = 0;
		}
		else if (strcmp(gunid, "golfclub", true, strlen(gunid)) == 0)
		{
			gun = 2;
			guncharge = GunPrice[1][0]/100*mod;
			ammocharge = 0;
		}
		else if (strcmp(gunid, "nightstick", true, strlen(gunid)) == 0)
		{
			gun = 3;
			guncharge = GunPrice[2][0]/100*mod;
			ammocharge = 0;
		}
		else if (strcmp(gunid, "knife", true, strlen(gunid)) == 0)
		{
			gun = 4;
			guncharge = GunPrice[3][0]/100*mod;
			ammocharge = 0;
		}
		else if (strcmp(gunid, "baseballbat", true, strlen(gunid)) == 0)
		{
			gun = 5;
			guncharge = GunPrice[4][0]/100*mod;
			ammocharge = 0;
		}
		else if (strcmp(gunid, "shovel", true, strlen(gunid)) == 0)
		{
			gun = 6;
			guncharge = GunPrice[5][0]/100*mod;
			ammocharge = 0;
		}
		else if (strcmp(gunid, "poolcue", true, strlen(gunid)) == 0)
		{
			gun = 7;
			guncharge = GunPrice[6][0]/100*mod;
			ammocharge = 0;
		}
		else if (strcmp(gunid, "purpledildo", true, strlen(gunid)) == 0)
		{
			gun = 10;
			guncharge = GunPrice[7][0]/100*mod;
			ammocharge = 0;
		}
		else if (strcmp(gunid, "whitedildo", true, strlen(gunid)) == 0)
		{
			gun = 11;
			guncharge = GunPrice[8][0]/100*mod;
			ammocharge = 0;
		}
		else if (strcmp(gunid, "longwhitedildo", true, strlen(gunid)) == 0)
		{
			gun = 12;
			guncharge = GunPrice[9][0]/100*mod;
			ammocharge = 0;
		}
		else if (strcmp(gunid, "whitedildo2", true, strlen(gunid)) == 0)
		{
			gun = 13;
			guncharge = GunPrice[10][0]/100*mod;
			ammocharge = 0;
		}
		else if (strcmp(gunid, "flowers", true, strlen(gunid)) == 0)
		{
			gun = 14;
			guncharge = GunPrice[11][0]/100*mod;
			ammocharge = 0;
		}
		else if (strcmp(gunid, "cane", true, strlen(gunid)) == 0)
		{
			gun = 15;
			guncharge = GunPrice[12][0]/100*mod;
			ammocharge = 0;
		}
		else if (strcmp(gunid, "sdpistol", true, strlen(gunid)) == 0)
		{
			gun = 23;
			guncharge = GunPrice[13][0]/100*mod;
			ammocharge = GunPrice[25][0]*ammo;
		}
		else if (strcmp(gunid, "colt45", true, strlen(gunid)) == 0)
		{
			gun = 22;
			guncharge = GunPrice[14][0]/100*mod;
			ammocharge = GunPrice[25][0]*ammo;
		}
		else if (strcmp(gunid, "deagle", true, strlen(gunid)) == 0)
		{
			gun = 24;
			guncharge = GunPrice[15][0]/100*mod;
			ammocharge = GunPrice[25][0]*ammo;
		}
		else if (strcmp(gunid, "Tec9", true, strlen(gunid)) == 0)
		{
			gun = 32;
			guncharge = GunPrice[16][0]/100*mod;
			ammocharge = GunPrice[27][0]*ammo;
		}
		else if (strcmp(gunid, "uzi", true, strlen(gunid)) == 0)
		{
			gun = 28;
			guncharge = GunPrice[17][0]/100*mod;
			ammocharge = GunPrice[27][0]*ammo;
		}
		else if (strcmp(gunid, "mp5", true, strlen(gunid)) == 0)
		{
			gun = 29;
			guncharge = GunPrice[18][0]/100*mod;
			ammocharge = GunPrice[27][0]*ammo;
		}
		else if (strcmp(gunid, "shotgun", true, strlen(gunid)) == 0)
		{
			gun = 25;
			guncharge = GunPrice[19][0]/100*mod;
			ammocharge = GunPrice[26][0]*ammo;
		}
		else if (strcmp(gunid, "spas12", true, strlen(gunid)) == 0)
		{
			gun = 27;
			guncharge = GunPrice[20][0]/100*mod;
			ammocharge = GunPrice[26][0]*ammo;
		}
		else if (strcmp(gunid, "sawnoff", true, strlen(gunid)) == 0)
		{
			gun = 26;
			guncharge = GunPrice[21][0]/100*mod;
			ammocharge = GunPrice[26][0]*ammo;
		}
		else if (strcmp(gunid, "ak47", true, strlen(gunid)) == 0)
		{
			gun = 30;
			guncharge = GunPrice[22][0]/100*mod;
			ammocharge = GunPrice[28][0]*ammo;
		}
		else if (strcmp(gunid, "m4", true, strlen(gunid)) == 0)
		{
			gun = 31;
			guncharge = GunPrice[23][0]/100*mod;
			ammocharge = GunPrice[28][0]*ammo;
		}
		else if (strcmp(gunid, "rifle", true, strlen(gunid)) == 0)
		{
			gun = 33;
			guncharge = GunPrice[24][0]/100*mod;
			ammocharge = GunPrice[29][0]*ammo;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD6, "Оружейник: никогда не слышал о такой пушке.");
			return 1;
		}
		if((guncharge+ammocharge) > GetPlayerMoney(playerid))
		{
			format(infostring, 256, "Недостаточно денег ($%d)",guncharge+ammocharge);
			SendClientMessageRus(playerid, COLOR_GRAD3, infostring);
			return 1;
		}
		format(infostring, 256, "Вы купили %s с %d патронами за $%d",gunid,ammo,guncharge+ammocharge);
		SendClientMessageRus(playerid, COLOR_GRAD3, infostring);
		SafeGivePlayerMoney(playerid,-(guncharge+ammocharge));
		BizzInfo[location-99][bTakings] = BizzInfo[location-99][bTakings]+(guncharge+ammocharge);
		BizzInfo[location-99][bProd]--;
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		GivePlayerWeapon(playerid, gun, ammo);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s bought weapons for $%d at biz %d", sendername, (guncharge+ammocharge), location-99);
		printf("%s", string);
		PayLog(string);
		return 1;
	}
	if (strcmp(cmd, "/upgrade", true) == 0)
	{
		new gunid[16];
		new infostring[256];
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			format(string, sizeof(string), "USAGE: /upgrade [upgradename] (У вас %d апгрейдов)",PlayerInfo[playerid][gPupgrade]);
			SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
			SendClientMessageRus(playerid, COLOR_WHITE,"*** АПГРЕЙДЫ ***");
			SendClientMessageRus(playerid, COLOR_GRAD2,string);
			if(PlayerInfo[playerid][pLevel] == 2)
			{
				SendClientMessageRus(playerid, COLOR_GRAD3, "Оружие 2 уровня: sdpistol colt45");
				SendClientMessageRus(playerid, COLOR_GRAD4, "Дополнительные патроны: pistolammo");
			}
			else if(PlayerInfo[playerid][pLevel] == 3)
			{
				SendClientMessageRus(playerid, COLOR_GRAD3, "Оружие 3 уровня: sdpistol colt45 mp5");
				SendClientMessageRus(playerid, COLOR_GRAD4, "Дополнительные патроны: pistolammo smgammo");
			}
			else if(PlayerInfo[playerid][pLevel] == 4)
			{
				SendClientMessageRus(playerid, COLOR_GRAD3, "Оружие 4 уровня: sdpistol colt45 mp5 shotgun");
				SendClientMessageRus(playerid, COLOR_GRAD4, "Дополнительные патроны: pistolammo shotgunammo smgammo");
			}
			else if(PlayerInfo[playerid][pLevel] == 5)
			{
				SendClientMessageRus(playerid, COLOR_GRAD3, "Оружие 5 уровня: sdpistol colt45 mp5 shotgun spas12");
				SendClientMessageRus(playerid, COLOR_GRAD4, "Дополнительные патроны: pistolammo shotgunammo smgammo");
			}
			else if(PlayerInfo[playerid][pLevel] == 6)
			{
				SendClientMessageRus(playerid, COLOR_GRAD3, "Оружие 6 уровня: sdpistol colt45 mp5 shotgun spas12 deagle");
				SendClientMessageRus(playerid, COLOR_GRAD4, "Дополнительные патроны: pistolammo shotgunammo smgammo");
			}
			else if(PlayerInfo[playerid][pLevel] == 7)
			{
				SendClientMessageRus(playerid, COLOR_GRAD3, "Оружие 7 уровня: sdpistol colt45 mp5 shotgun spas12 deagle uzi");
				SendClientMessageRus(playerid, COLOR_GRAD4, "Дополнительные патроны: pistolammo shotgunammo smgammo");
			}
			else if(PlayerInfo[playerid][pLevel] == 8)
			{
				SendClientMessageRus(playerid, COLOR_GRAD3, "Оружие 8 уровня: sdpistol colt45 mp5 shotgun spas12 deagle uzi sawnoff");
				SendClientMessageRus(playerid, COLOR_GRAD4, "Дополнительные патроны: pistolammo shotgunammo smgammo");
			}
			else if(PlayerInfo[playerid][pLevel] == 9)
			{
				SendClientMessageRus(playerid, COLOR_GRAD3, "Оружие 9 уровня: sdpistol colt45 mp5 shotgun spas12 deagle uzi sawnoff tec9 ak47");
				SendClientMessageRus(playerid, COLOR_GRAD4, "Дополнительные патроны: pistolammo shotgunammo smgammo assaultammo");
			}
			else if(PlayerInfo[playerid][pLevel] == 10)
			{
				SendClientMessageRus(playerid, COLOR_GRAD3, "Оружие 10 уровня: sdpistol colt45 mp5 shotgun spas12 deagle uzi sawnoff tec9 ak47 m4");
				SendClientMessageRus(playerid, COLOR_GRAD4, "Дополнительные патроны: pistolammo shotgunammo smgammo assaultammo");
			}
			else if(PlayerInfo[playerid][pLevel] == 11)
			{
				SendClientMessageRus(playerid, COLOR_GRAD3, "Оружие 11 уровня: sdpistol colt45 mp5 shotgun spas12 deagle uzi sawnoff tec9 ak47 m4 rifle");
				SendClientMessageRus(playerid, COLOR_GRAD4, "Дополнительные патроны: pistolammo shotgunammo smgammo assaultammo rifleammo");
			}
			else if(PlayerInfo[playerid][pLevel] == 12)
			{
				SendClientMessageRus(playerid, COLOR_GRAD3, "Оружие 12 уровня: sdpistol colt45 mp5 shotgun spas12 deagle uzi sawnoff tec9 ak47 m4 rifle flamethrower");
				SendClientMessageRus(playerid, COLOR_GRAD4, "Дополнительные патроны: pistolammo shotgunammo smgammo assaultammo rifleammo heavyammo");
			}
			else if(PlayerInfo[playerid][pLevel] >= 13)
			{
				format(infostring, 256, "Оружие %d уровня: sdpistol colt45 mp5 shotgun spas12 deagle uzi sawnoff tec9 ak47 m4 rifle",PlayerInfo[playerid][pLevel]);
				SendClientMessageRus(playerid, COLOR_GRAD4, "Дополнительные патроны: pistolammo shotgunammo smgammo assaultammo rifleammo heavyammo");
				SendClientMessageRus(playerid, COLOR_GRAD3, infostring);
			}
			SendClientMessageRus(playerid, COLOR_GRAD5, "Дополнительное здоровье: health");
			SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
			return 1;
		}
		strmid(gunid, tmp, 0, strlen(cmdtext), 255);
		if (PlayerInfo[playerid][gPupgrade] > 0)
		{
			/*
			if (PlayerInfo[playerid][pLevel] >= 13 && (strcmp(gunid, "minigun", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "New Upgrade: You Will Now Spawn With A minigun");
				PlayerInfo[playerid][pGun6] = 38;
				ResetPlayerWeapons(playerid);
				SetPlayerWeapons(playerid);
				PlayerInfo[playerid][gPupgrade]--;
			}

			if (PlayerInfo[playerid][pLevel] >= 12 && (strcmp(gunid, "flamethrower", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "New Upgrade: You Will Now Spawn With A flamethrower");
				PlayerInfo[playerid][pGun6] = 37;
			}
			*/
			if (PlayerInfo[playerid][pLevel] >= 5 && (strcmp(gunid, "parachute", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с parachute");
				PlayerInfo[playerid][pGun5] = 46;
			}
			else if (PlayerInfo[playerid][pLevel] >= 11 && (strcmp(gunid, "rifle", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с rifle");
				PlayerInfo[playerid][pGun5] = 33;
			}
			else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "m4", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с m4");
				PlayerInfo[playerid][pGun4] = 31;
			}
			else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "golfclub", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с golfclub");
				PlayerInfo[playerid][pGun6] = 2;
			}
			else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "nightstick", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с nightstick");
				PlayerInfo[playerid][pGun6] = 3;
			}
			else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "knife", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с knife");
				PlayerInfo[playerid][pGun6] = 4;
			}
			else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "baseballbat", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с baseballbat");
				PlayerInfo[playerid][pGun6] = 5;
			}
			else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "shovel", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с shovel");
				PlayerInfo[playerid][pGun6] = 6;
			}
			else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "poolcue", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с poolcue");
				PlayerInfo[playerid][pGun6] = 7;
			}
			else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "purpledildo", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с purpledildo");
				PlayerInfo[playerid][pGun6] = 10;
			}
			else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "whitedildo", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с whitedildo");
				PlayerInfo[playerid][pGun6] = 11;
			}
			else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "longwhitedildo", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с longwhitedildo");
				PlayerInfo[playerid][pGun6] = 12;
			}
			else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "whitedildo2", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с whitedildo2");
				PlayerInfo[playerid][pGun6] = 13;
			}
			else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "flowers", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с flowers");
				PlayerInfo[playerid][pGun6] = 14;
			}
			else if (PlayerInfo[playerid][pLevel] >= 10 && (strcmp(gunid, "cane", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с cane");
				PlayerInfo[playerid][pGun6] = 15;
			}
			else if (PlayerInfo[playerid][pLevel] >= 9 && (strcmp(gunid, "ak47", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с ak47");
				PlayerInfo[playerid][pGun4] = 30;
			}
			else if (PlayerInfo[playerid][pLevel] >= 9 && (strcmp(gunid, "Tec9", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с Tec9");
				PlayerInfo[playerid][pGun3] = 32;
			}
			else if (PlayerInfo[playerid][pLevel] >= 8 && (strcmp(gunid, "sawnoff", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с sawnoff");
				PlayerInfo[playerid][pGun2] = 26;
			}
			else if (PlayerInfo[playerid][pLevel] >= 7 && (strcmp(gunid, "uzi", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с uzi");
				PlayerInfo[playerid][pGun3] = 28;
			}
			else if (PlayerInfo[playerid][pLevel] >= 6 && (strcmp(gunid, "deagle", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с deagle");
				PlayerInfo[playerid][pGun1] = 24;
			}
			else if (PlayerInfo[playerid][pLevel] >= 5 && (strcmp(gunid, "spas12", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с spas12");
				PlayerInfo[playerid][pGun2] = 27;
			}
			else if (PlayerInfo[playerid][pLevel] >= 4 && (strcmp(gunid, "shotgun", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с shotgun");
				PlayerInfo[playerid][pGun2] = 25;
			}
			else if (PlayerInfo[playerid][pLevel] >= 3 && (strcmp(gunid, "mp5", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с mp5");
				PlayerInfo[playerid][pGun3] = 29;
			}
			else if (PlayerInfo[playerid][pLevel] >= 2 && (strcmp(gunid, "colt45", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с colt45");
				PlayerInfo[playerid][pGun1] = 22;
			}
			else if (PlayerInfo[playerid][pLevel] >= 1 && (strcmp(gunid, "sdpistol", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Новый апгрейд: теперь вы будете появляться с sdpistol");
				PlayerInfo[playerid][pGun1] = 23;
			}
			else if (PlayerInfo[playerid][pLevel] >= 1 && (strcmp(gunid, "pistolammo", true, strlen(gunid)) == 0))
			{
				PlayerInfo[playerid][pAmmo1] = PlayerInfo[playerid][pAmmo1]+50;
				format(infostring, 256, "Новый апгрейд: теперь вы будете появляться с %d Pistol Ammo (+50)",PlayerInfo[playerid][pAmmo1]);
				SendClientMessageRus(playerid, COLOR_GRAD6, infostring);
			}
			else if (PlayerInfo[playerid][pLevel] >= 1 && (strcmp(gunid, "shotgunammo", true, strlen(gunid)) == 0))
			{
				PlayerInfo[playerid][pAmmo2] = PlayerInfo[playerid][pAmmo2]+50;
				format(infostring, 256, "Новый апгрейд: теперь вы будете появляться с %d Shotgun Ammo (+50)",PlayerInfo[playerid][pAmmo2]);
				SendClientMessageRus(playerid, COLOR_GRAD6, infostring);
			}
			else if (PlayerInfo[playerid][pLevel] >= 1 && (strcmp(gunid, "smgammo", true, strlen(gunid)) == 0))
			{
				PlayerInfo[playerid][pAmmo3] = PlayerInfo[playerid][pAmmo3]+100;
				format(infostring, 256, "Новый апгрейд: теперь вы будете появляться с %d SMG Ammo (+100)",PlayerInfo[playerid][pAmmo3]);
				SendClientMessageRus(playerid, COLOR_GRAD6, infostring);
			}
			else if (PlayerInfo[playerid][pLevel] >= 1 && (strcmp(gunid, "assaultammo", true, strlen(gunid)) == 0))
			{
				PlayerInfo[playerid][pAmmo4] = PlayerInfo[playerid][pAmmo4]+50;
				format(infostring, 256, "Новый апгрейд: теперь вы будете появляться с %d Assault Ammo (+50)",PlayerInfo[playerid][pAmmo4]);
				SendClientMessageRus(playerid, COLOR_GRAD6, infostring);
			}
			else if (PlayerInfo[playerid][pLevel] >= 1 && (strcmp(gunid, "rifleammo", true, strlen(gunid)) == 0))
			{
				PlayerInfo[playerid][pAmmo5] = PlayerInfo[playerid][pAmmo5]+10;
				format(infostring, 256, "Новый апгрейд: теперь вы будете появляться с %d Rifleammo Ammo (+10)",PlayerInfo[playerid][pAmmo5]);
				SendClientMessageRus(playerid, COLOR_GRAD6, infostring);
			}
			else if (PlayerInfo[playerid][pLevel] >= 1 && (strcmp(gunid, "heavyammo", true, strlen(gunid)) == 0))
			{
				PlayerInfo[playerid][pAmmo6] = PlayerInfo[playerid][pAmmo6]+10;
				format(infostring, 256, "Новый апгрейд: теперь вы будете появляться с %d Heavyammo Ammo (+50)",PlayerInfo[playerid][pAmmo6]);
				SendClientMessageRus(playerid, COLOR_GRAD6, infostring);
			}
			else if (PlayerInfo[playerid][pLevel] >= 1 && (strcmp(gunid, "health", true, strlen(gunid)) == 0))
			{
				if (PlayerInfo[playerid][pSHealth] < 100)
				{
					PlayerInfo[playerid][pSHealth] = PlayerInfo[playerid][pSHealth]+5.0;
					format(infostring, 256, "Новый апгрейд: теперь вы будете появляться с %.2f здоровья (+5)",PlayerInfo[playerid][pSHealth]+50);
				}
				else
				{
					SendClientMessageRus(playerid, COLOR_GRAD6, "У вас уже максимальное хдоровье");
					return 1;
				}
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Неизвестный апгрейд");
				return 1;
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD6, "У вас нет неиспользованных апгрейдов");
			return 1;
		}
		SetPlayerWeapons(playerid);
		PlayerInfo[playerid][gPupgrade]--;
		return 1;
	}
//-------------------------------[Login]--------------------------------------------------------------------------
	if (strcmp(cmd, "/login", true) ==0 )
	{
		new tmppass[64];
		if (gPlayerLogged[playerid] == 1)
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "СЕРВЕР: Вы уже авторизовались.");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /login [password]");
			return 1;
		}
		strmid(tmppass, tmp, 0, strlen(cmdtext), 255);
		if (gdebug){printf("DEBUG enterd %s", tmppass);}
		OnPlayerLogin(playerid,tmppass);
		return 1;
	}
//[TEST]______________________________________________________________________________

//----------------------------------[ooc]-----------------------------------------------
	if(strcmp(cmd, "/ooc", true) == 0 || strcmp(cmd, "/o", true) == 0)
	{
		if ((noooc) && PlayerInfo[playerid][pAdmin] < 1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Общий чат был отключен администратором");
			return 1;
		}
		if(Mute[playerid] == 1)
		{
			SendClientMessageRus(playerid, TEAM_CYAN_COLOR, "Вы не можете говорить, т.к. были заткнуты");
			return 0;
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: (/o)oc [ooc chat]");
			return 1;
		}
		format(string, sizeof(string), "(( %s: %s ))", sendername, result);
		OOCOff(TEAM_ORANGE_COLOR,string);
		printf("%s", string);
		return 1;
	}
	if(strcmp(cmd, "/noooc", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3 && (!noooc))
		{
			noooc = 1;
			if(stats)
			{
				realchat = 1;
			}
			BroadCast(COLOR_GRAD2, "Администратор выключил общий чат");
		}
		else if (PlayerInfo[playerid][pAdmin] >= 3 && (noooc))
		{
			noooc = 0;
			if(stats)
			{
				realchat = 0;
			}
			BroadCast(COLOR_GRAD2, "Администратор включил общий чат");
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не можете использовать эту команду!");
		}
		return 1;
	}
	if(strcmp(cmd, "/speedo", true) == 0)
	{
		if (gSpeedo[playerid] == 1)
		{
			gSpeedo[playerid] = 2;
			GameTextForPlayerRus(playerid, "~n~~n~~n~~n~~n~~n~~n~~g~on", 5000, 5);
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
		}
		else if (gSpeedo[playerid] == 2)
		{
			gSpeedo[playerid] = 1;
			GameTextForPlayerRus(playerid, "~n~~n~~n~~n~~n~~n~~n~~r~off", 5000, 5);
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "У вас нет спидометра.");
		}
		return 1;
	}
//----------------------------------[advertise]-----------------------------------------------
	if(strcmp(cmd, "/advertise", true) == 0 || strcmp(cmd, "/ad", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: (/ad)vertise [advert text]");
			return 1;
		}
		if ((noooc) && (PlayerInfo[playerid][pAdmin] < 1))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Реклама была отключена администратором");
			return 1;
		}
		if ((!adds) && (PlayerInfo[playerid][pAdmin] < 1))
		{
			format(string, sizeof(string), "Пожалуйста, попробуйте повторить через %d секунд",  (addtimer/1000));
			SendClientMessageRus(playerid, COLOR_GRAD2, string);
			return 1;

		}
		format(string, sizeof(string), "Реклама: %s, Контакт: %s Телефон: %d",  result, sendername,PlayerInfo[playerid][pPnumber]);
		OOCOff(TEAM_GROVE_COLOR,string);
		if (PlayerInfo[playerid][pAdmin] < 1){SetTimer("AddsOn", addtimer, 0);adds = 0;}
		printf("%s", string);
		return 1;
	}
//----------------------------------[togooc]-----------------------------------------------

	if(strcmp(cmd, "/togooc", true) == 0)
	{
		if (!gOoc[playerid])
		{
			gOoc[playerid] = 1;
			SendClientMessageRus(playerid, COLOR_GRAD2, "Общий чат выключен");
		}
		else if (gOoc[playerid])
		{
			(gOoc[playerid] = 0);
			SendClientMessageRus(playerid, COLOR_GRAD2, "Общий чат включен");
		}
		return 1;
	}
//----------------------------------[Emote]-----------------------------------------------
	if(strcmp(cmd, "/me", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "USAGE: /me [action]");
			return 1;
		}
		format(string, sizeof(string), "* %s %s", sendername, result);
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		printf("%s", string);
		return 1;
	}
//----------------------------------[Local]-----------------------------------------------
	if(strcmp(cmd, "/local", true) == 0 || strcmp(cmd, "/l", true) == 0 || strcmp(cmd, "/say", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: (/l)ocal [local chat]");
			return 1;
		}
		format(string, sizeof(string), "%s говорит: %s", sendername, result);
		ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		printf("%s", string);
		return 1;
	}
//----------------------------------[Shout]-----------------------------------------------
	if(strcmp(cmd, "/shout", true) == 0 || strcmp(cmd, "/s", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: (/s)hout [local chat]");
			return 1;
		}
		format(string, sizeof(string), "%s кричит: %s!!", sendername, result);
		ProxDetector(30.0, playerid, string,COLOR_WHITE,COLOR_WHITE,COLOR_WHITE,COLOR_FADE1,COLOR_FADE2);
		printf("%s", string);
		return 1;
	}
//----------------------------------[Shout]-----------------------------------------------
	if(strcmp(cmd, "/megaphone", true) == 0 || strcmp(cmd, "/m", true) == 0)
	{
		new tmpcar = GetPlayerVehicleID(playerid);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: (/m)egaphone [megaphone chat]");
			return 1;
		}
		if (gTeam[playerid] != 2)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не коп");
			return 1;
		}
		if(!IsACopCar(tmpcar))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не в полицейской машине");
			return 1;
		}
		format(string, sizeof(string), "[Офицер %s:o< %s]", sendername, result);
		ProxDetector(60.0, playerid, string,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW,COLOR_YELLOW);
		printf("%s", string);
		return 1;
	}
//----------------------------------[Team]-----------------------------------------------
	if(strcmp(cmd, "/radio", true) == 0 || strcmp(cmd, "/r", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: (/r)adio [radio chat]");
			return 1;
		}
		if (gTeam[playerid] == 2)
		{
			if(PlayerInfo[playerid][pAdmin] == -2)
			{
				format(string, sizeof(string), "** Шериф %s: %s, конец связи. **", sendername, result);
			}
			else
			{
				format(string, sizeof(string), "** Офицер %s: %s, конец связи. **", sendername, result);
			}
			SendTeamMessage(2, TEAM_BLUE_COLOR, string);
			printf("%s", string);
			return 1;
		}
		if (gTeam[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] == -1)
			{
				format(string, sizeof(string), "** Главврач %s: %s, конец связи. **", sendername, result);
			}
			else
			{
				format(string, sizeof(string), "** Врач %s: %s, конец связи. **", sendername, result);
			}
			SendTeamMessage(1, TEAM_CYAN_COLOR, string);
			printf("%s", string);
			return 1;
		}
		if (gTeam[playerid] >= 5)
		{
			if(PlayerInfo[playerid][pAdmin] <= -5)
			{
				format(string, sizeof(string), "** Босс %s: %s, конец связи. **", sendername, result);
			}
			else
			{
				format(string, sizeof(string), "** %s: %s, конец связи. **", sendername, result);
			}
			SendTeamMessage(gTeam[playerid], TEAM_AZTECAS_COLOR, string);
			printf("%s", string);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не в команде");
			return 1;
		}
//		return 1;
	}
//----------------------------------[offduty]-----------------------------------------------
	if(strcmp(cmd, "/duty", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if(forceteam && CopCheck(playerid))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не полицейский.");
			return 1;
		}
		if (gTeam[playerid] == 2)
		{
			if (IsPlayerInRangeOfPoint(playerid, 3,255.3,77.4,1003.6) || PlayerInfo[playerid][pLocal] != -1)
			{
				gTeam[playerid] = 3;
				SetPlayerToTeamColor(playerid);
				format(string, sizeof(string), "* %s кладет оружие и значек в шкаф", sendername);
				SetPlayerWeapons(playerid);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				printf("%s", string);
				return 1;
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не в раздевалке");
				return 1;
			}
		}
		if (gTeam[playerid] == 3)
		{
			if (IsPlayerInRangeOfPoint(playerid, 3,255.3,77.4,1003.6) || PlayerInfo[playerid][pLocal] != -1)
			{
				gTeam[playerid] = 2;
				SetPlayerToTeamColor(playerid);
				if(PlayerInfo[playerid][pAdmin] == -2)
				{
					format(string, sizeof(string), "* Шериф %s берет значек и оружие из шкафа", sendername);
				}
				else
				{
					format(string, sizeof(string), "* Офицер %s берет значек и оружие из шкафа", sendername);
				}
				SetPlayerWeapons(playerid);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				printf("%s", string);
				return 1;
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не в раздевалке");
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не можете использовать эту команду");
			return 1;
		}
		return 1;
	}
//----------------------------------[departments]-----------------------------------------------
	if(strcmp(cmd, "/departments", true) == 0 || strcmp(cmd, "/d", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: (/d)epartments [department chat]");
			return 1;
		}
		if (gTeam[playerid] == 2)
		{
			if(PlayerInfo[playerid][pAdmin] == -2)
			{
				format(string, sizeof(string), "** Шериф %s: %s, конец связи. **", sendername, result);
			}
			else
			{
				format(string, sizeof(string), "** Офицер %s: %s, конец связи. **", sendername, result);
			}
			SendTeamMessage(2, COLOR_ALLDEPT, string);
			SendTeamMessage(4, COLOR_ALLDEPT, string);
			printf("%s", string);
			return 1;
		}
		if (gTeam[playerid] == 1)
		{
			if(PlayerInfo[playerid][pAdmin] == -3)
			{
				format(string, sizeof(string), "** Главврач %s: %s, конец связи. **", sendername, result);
			}
			else
			{
				format(string, sizeof(string), "** Paramedic %s: %s, конец связи. **", sendername, result);
			}
			SendTeamMessage(2, COLOR_ALLDEPT, string);
			SendTeamMessage(1, COLOR_ALLDEPT, string);
			printf("%s", string);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не можете использовать эту команду");
			return 1;
		}
//		return 1;
	}
//----------------------------------[mdc]-----------------------------------------------
	if(strcmp(cmd, "/mdc", true) == 0)
	{
		new tmpcar = GetPlayerVehicleID(playerid);
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "USAGE: /mdc [playerid/PartOfName]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, 0xAAAAAAAA, "Неправильный ID");
		GetPlayerName(giveplayerid, sendername, sizeof(sendername));
		if(!IsACopCar(tmpcar))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не в полицейской машине");
			return 1;
		}
		SendClientMessageRus(playerid, TEAM_BLUE_COLOR,"_______________-=КПК=-______________");
		format(string, sizeof(string), "Имя : %s", sendername);
		SendClientMessageRus(playerid, COLOR_WHITE,string);
		format(string, sizeof(string), "Преступление : %s", PlayerCrime[giveplayerid][pAccusedof]);
		SendClientMessageRus(playerid, COLOR_GRAD2,string);
		format(string, sizeof(string), "Претендент : %s", PlayerCrime[giveplayerid][pVictim]);
		SendClientMessageRus(playerid, COLOR_GRAD3,string);
		format(string, sizeof(string), "Доложил : %s", PlayerCrime[giveplayerid][pAccusing]);
		SendClientMessageRus(playerid, COLOR_GRAD4,string);
		format(string, sizeof(string), "Обвиняемый : %s", PlayerCrime[giveplayerid][pBplayer]);
		SendClientMessageRus(playerid, COLOR_GRAD5,string);
		SendClientMessageRus(playerid, TEAM_BLUE_COLOR,"_______________________________________");
		printf("%s", string);
		return 1;
	}
//----------------------------------[SetCrim]-----------------------------------------------
	if(strcmp(cmd, "/suspect", true) == 0 || strcmp(cmd, "/su", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: (/su)spect [playerid/PartOfName] [crime discription]");
			return 1;
		}
		if (gTeam[playerid] == 2)
		{
			if(IsStringAName(tmp))
			{
				giveplayerid = GetPlayerID(tmp);
			}
			else
			{
				giveplayerid = strval(tmp);
			}
			if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, 0xAAAAAAAA, "Неправильный ID");
			if(JailTime[giveplayerid] != 0)
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "Подозреваемый сидит за решеткой.");
				printf("JailTime[giveplayerid](%d) gTeam[giveplayerid](%d)",JailTime[giveplayerid],gTeam[giveplayerid]);
				return 1;
			}
			if (IsPlayerConnected(giveplayerid))
			{
				if (gTeam[giveplayerid] != 2)
				{
					if (gTeam[giveplayerid] >= 4)
					{
						SendClientMessageRus(playerid, COLOR_GRAD2, "Этот игрок уже в розыске");
						return 1;
					}
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					new length = strlen(cmdtext);
					while ((idx < length) && (cmdtext[idx] <= ' '))
					{
						idx++;
					}
					new offset = idx;
					new result[64];
					while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
					{
						result[idx - offset] = cmdtext[idx];
						idx++;
					}
					result[idx - offset] = EOS;
					if(!strlen(result))
					{
						SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: (/su)spect [playerid/PartOfName] [crime text]");
						return 1;
					}
					if(FlashTime[playerid] == 0){FlashTime[playerid] = 10;}
					if(FlashTime[giveplayerid] == 0){FlashTime[giveplayerid] = 10;}
					SetPlayerCriminal(giveplayerid,playerid, result,0,0);
					JailTime[giveplayerid] = -60;
					//printf("%s: %s", giveplayer, result);
					return 1;
				}
				else
				{
					SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не можете подозревать полицейского");
				}
			}
			else
			{
				format(string, sizeof(string), "%d не активный игрок.", giveplayerid);
				SendClientMessageRus(playerid, COLOR_GRAD1, string);
				return 1;
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не полицейский");
		}
	}
//----------------------------------[SetFree]-----------------------------------------------
	if(strcmp(cmd, "/free", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /free [playerid/PartOfName]");
			return 1;
		}
		if (gTeam[playerid] == 2)
		{
			if(IsStringAName(tmp))
			{
				giveplayerid = GetPlayerID(tmp);
			}
			else
			{
				giveplayerid = strval(tmp);
			}
			if (IsPlayerConnected(giveplayerid))
			{
				if (gTeam[giveplayerid] == 4)
				{
					GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
					GetPlayerName(playerid, sendername, sizeof(sendername));
					new length = strlen(cmdtext);
					while ((idx < length) && (cmdtext[idx] <= ' '))
					{
						idx++;
					}
					new offset = idx;
					new result[64];
					while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
					{
						result[idx - offset] = cmdtext[idx];
						idx++;
					}
					result[idx - offset] = EOS;
					if(!strlen(result))
					{
						SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /free [playerid/PartOfName] [reason text]");
						return 1;
					}
					if (gPublicEnemy == giveplayerid)
					{
						SendClientMessageRus(playerid, COLOR_GRAD2, "Ты не можешь освободить ВНН1");
						return 1;
					}
					SetPlayerFree(giveplayerid,playerid, result,0,0);
					//printf("%s: %s", giveplayer, result);
					return 1;
				}
				else
				{
					SendClientMessageRus(playerid, COLOR_GRAD2, "Этот игрок свободен");
				}
			}
			else
			{
				format(string, sizeof(string), "%d не активный игрок.", giveplayerid);
				SendClientMessageRus(playerid, COLOR_GRAD1, string);
				return 1;
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Ты не полицейский");
		}
	}
//----------------------------------[LOCK]-----------------------------------------------
	if(strcmp(cmd, "/lock", true) == 0)
	{
		new carid;
		if (gTeam[playerid] == 2 || gTeam[playerid] == 1)
		{
			if(gLastCar[playerid] == 0 && PlayerInfo[playerid][pPhousekey] == -1)
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "You dont have a Vehicle.");
				return 1;
			}
			else if(gLastCar[playerid] != 0 && gLastCar[playerid] != PlayerInfo[playerid][pPhousekey]+1)
			{
				if (HireCar[playerid] != gLastCar[playerid] && HireCar[playerid] != -1)
				{
					gLastDriver[HireCar[playerid]] = -1;
					gCarLock[HireCar[playerid]] = 0;
					UnLockCar(HireCar[playerid]);
				}
				HireCar[playerid] = gLastCar[playerid];
			}
		}
		if (PlayerInfo[playerid][pPhousekey] == -1)
		{
			if(HireCar[playerid] == -1)
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "У вас нет машины.");
				return 1;
			}
		}
		carid = PlayerInfo[playerid][pPhousekey]+1;
		if(HireCar[playerid] != -1 && !SwitchKey[playerid])
		{
			carid = HireCar[playerid];
		}
		//new driver = gLastDriver[carid];
		new lockstatus = gCarLock[carid];
		new Float:cx,Float:cy,Float:cz;
		GetVehiclePos(carid, cx, cy, cz);
		for(new i = 0; i < sizeof(HouseInfo); i++)
		{
			//printf("House :%d  x:%f y:%f z:%f",i,HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez]);
			if (IsPlayerInRangeOfPoint(playerid, 3,HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez]) || IsPlayerInRangeOfPoint(playerid, 3,HouseInfo[i][hExitx], HouseInfo[i][hExity], HouseInfo[i][hExitz]))
			{
				//printf("House :%d",i);
				if(PlayerInfo[playerid][pPhousekey] == i)
				{
					//printf("pPhousekey :%d  hLock :%d",PlayerInfo[playerid][pPhousekey] ,HouseInfo[i][hLock]);
					if(HouseInfo[i][hLock] == 1)
					{
						HouseInfo[i][hLock] = 0;
						GameTextForPlayerRus(playerid, "~w~Door ~g~Unlocked", 5000, 6);
						PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
						return 1;
					}
					if(HouseInfo[i][hLock] == 0)
					{
						HouseInfo[i][hLock] = 1;
						GameTextForPlayerRus(playerid, "~w~Door ~r~Locked", 5000, 6);
						PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
						return 1;
					}
				}
				else
				{
					GameTextForPlayerRus(playerid, "~r~You Dont Have A Key", 5000, 6);
					return 1;
				}
			}
		}
		for(new i = 0; i < sizeof(BizzInfo); i++)
		{
			//printf("House :%d  x:%f y:%f z:%f",i,HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez]);
			if (IsPlayerInRangeOfPoint(playerid, 3,BizzInfo[i][bEntrancex], BizzInfo[i][bEntrancey], BizzInfo[i][bEntrancez]) || IsPlayerInRangeOfPoint(playerid, 3,BizzInfo[i][bExitx], BizzInfo[i][bExity], BizzInfo[i][bExitz]))
			{
				//printf("House :%d",i);
				if(PlayerInfo[playerid][pPbiskey] == i)
				{
					//printf("pPhousekey :%d  hLock :%d",PlayerInfo[playerid][pPhousekey] ,HouseInfo[i][hLock]);
					if(BizzInfo[i][bLock] == 1)
					{
						BizzInfo[i][bLock] = 0;
						GameTextForPlayerRus(playerid, "~w~Bussiness ~g~Open", 5000, 6);
						PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
						return 1;
					}
					if(BizzInfo[i][bLock] == 0)
					{
						BizzInfo[i][bLock] = 1;
						GameTextForPlayerRus(playerid, "~w~Bussiness ~r~Closed", 5000, 6);
						PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
						return 1;
					}
				}
				else
				{
					GameTextForPlayerRus(playerid, "~r~You Dont Have A Key", 5000, 6);
					return 1;
				}
			}
		}
		for(new i = 0; i < sizeof(SBizzInfo); i++)
		{
			//printf("House :%d  x:%f y:%f z:%f",i,HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez]);
			if (IsPlayerInRangeOfPoint(playerid, 3,SBizzInfo[i][sbEntrancex], SBizzInfo[i][sbEntrancey], SBizzInfo[i][sbEntrancez]))
			{
				//printf("House :%d",i);
				if(PlayerInfo[playerid][pPbiskey] == i+100)
				{
					//printf("pPhousekey :%d  hLock :%d",PlayerInfo[playerid][pPhousekey] ,HouseInfo[i][hLock]);
					if(SBizzInfo[i][sbLock] == 1)
					{
						SBizzInfo[i][sbLock] = 0;
						GameTextForPlayerRus(playerid, "~w~Bussiness ~g~Open", 5000, 6);
						PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
						return 1;
					}
					if(SBizzInfo[i][sbLock] == 0)
					{
						SBizzInfo[i][sbLock] = 1;
						GameTextForPlayerRus(playerid, "~w~Bussiness ~r~Closed", 5000, 6);
						PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
						return 1;
					}
				}
				else
				{
					GameTextForPlayerRus(playerid, "~r~You Dont Have A Key", 5000, 6);
					return 1;
				}
			}
		}
		switch (lockstatus)
		{
			case 0:
			{
				/*
				if (gTeam[playerid] == 2 || gTeam[playerid] == 1)
				{
					if(driver != playerid)
					{
						SendClientMessageRus(playerid, COLOR_GRAD2, "You dont have a Vehicle.");
						return 1;
					}
					GameTextForPlayerRus(playerid, "~w~Vehicle ~r~Locked", 5000, 6);
					PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
					gCarLock[carid] = 1;
					LockCar(carid);
					return 1;
				}
				*/
				if(HireCar[playerid] == -1 && PlayerInfo[playerid][pPhousekey] == -1)
				{
					SendClientMessageRus(playerid, COLOR_GRAD2, "У вас нет машины");
					return 1;
				}
				if(HireCar[playerid] == carid && !SwitchKey[playerid])
				{
					GameTextForPlayerRus(playerid, "~w~Hire Vehicle ~r~Locked", 5000, 6);
					PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
					gCarLock[carid] = 1;
					LockCar(carid);
				}
				else if (PlayerInfo[playerid][pPhousekey] == carid-1)
				{
					GameTextForPlayerRus(playerid, "~w~House Vehicle ~r~Locked", 5000, 6);
					PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
					gCarLock[carid] = 1;
					LockCar(carid);
					return 1;
				}
			}
			case 1:
			{
				/*
				if (gTeam[playerid] == 2 || gTeam[playerid] == 1)
				{
					if(driver != playerid)
					{
						SendClientMessageRus(playerid, COLOR_GRAD2, "You dont have a Vehicle");
						return 1;
					}
					GameTextForPlayerRus(playerid, "~w~Vehicle ~g~Unlocked", 5000, 6);
					PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
					gCarLock[carid] = 0;
					UnLockCar(carid);
					return 1;
				}
				*/
				if(HireCar[playerid] == -1 && PlayerInfo[playerid][pPhousekey] == -1)
				{
					SendClientMessageRus(playerid, COLOR_GRAD2, "У вас нет машины");
					return 1;
				}
				if(HireCar[playerid] == carid && !SwitchKey[playerid])
				{
					GameTextForPlayerRus(playerid, "~w~Hire Vehicle ~g~Unlocked", 5000, 6);
					PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
					gCarLock[carid] = 0;
					UnLockCar(carid);
				}
				if (PlayerInfo[playerid][pPhousekey] == carid-1)
				{
					GameTextForPlayerRus(playerid, "~w~House Vehicle ~g~Unlocked", 5000, 6);
					PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
					gCarLock[carid] = 0;
					UnLockCar(carid);
					return 1;
				}
			}
			default:
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "Ошибка");
			}
		}
		if(carid == 0)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "У вас нет машины");
		}
		return 1;
	}
//----------------------------------[Wisper]-----------------------------------------------
	if(strcmp(cmd, "/wisper", true) == 0 || strcmp(cmd, "/w", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "USAGE: (/w)isper [playerid/PartOfName] [whisper text]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if (IsPlayerConnected(giveplayerid))
		{
			if (ProxDetectorS(5.0, playerid, giveplayerid))
			{
				GetPlayerName(playerid, sendername, sizeof(sendername));
				if(giveplayerid == playerid)
				{
					format(string, sizeof(string), "* %s бормочет что-то себе под нос.", sendername);
					ProxDetector(5.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				new length = strlen(cmdtext);
				while ((idx < length) && (cmdtext[idx] <= ' '))
				{
					idx++;
				}
				new offset = idx;
				new result[64];
				while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
				{
					result[idx - offset] = cmdtext[idx];
					idx++;
				}
				result[idx - offset] = EOS;
				if(!strlen(result))
				{
					SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: (/w)isper [playerid/PartOfName] [whisper text]");
					return 1;
				}
				format(string, sizeof(string), "%s whispers %s", sendername, result);
				SendClientMessageRus(playerid,  COLOR_YELLOW, string);
				SendClientMessageRus(giveplayerid, COLOR_YELLOW, string);
				printf("%s: %s", sendername, result);
				return 1;
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Вы слишком далеко.");
			}
		}
		else
		{
				format(string, sizeof(string), "%d не активный игрок.", giveplayerid);
				SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		return 1;
	}
//----------------------------------[Phone]-----------------------------------------------
	if(strcmp(cmd, "/bank", true) == 0 || strcmp(cmd, "/deposit", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		new cashdeposit = strval(tmp);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ /bank [amount]");
			format(string, sizeof(string), "Остаток в банке $%d.", PlayerInfo[playerid][pAccount]);
			SendClientMessageRus(playerid, COLOR_GRAD3, string);
			return 1;
		}
		if (cashdeposit > GetPlayerMoney(playerid) || cashdeposit < 1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "У вас нет столько наличных");
			return 1;
		}
		if (IsPlayerInRangeOfPoint(playerid, 100,-30.875, -88.9609, 1004.53) || IsPlayerInRangeOfPoint(playerid, 100, 246.3,109.2,1003.2))
		{
			SafeGivePlayerMoney(playerid,-cashdeposit);
			new curfunds = PlayerInfo[playerid][pAccount];
			PlayerInfo[playerid][pAccount]=cashdeposit+PlayerInfo[playerid][pAccount];
			SendClientMessageRus(playerid, COLOR_WHITE, "|___ БАНКОВСКИЙ СЧЕТ ___|");
			format(string, sizeof(string), "Старый баланс:   $%d", curfunds);
			SendClientMessageRus(playerid, COLOR_GRAD2, string);
			format(string, sizeof(string), "Внесенная сумма: $%d",cashdeposit);
			SendClientMessageRus(playerid, COLOR_GRAD4, string);
			SendClientMessageRus(playerid, COLOR_GRAD6, "|-----------------------------------------|");
			format(string, sizeof(string), "Новый баланс:    $%d", PlayerInfo[playerid][pAccount]);
			SendClientMessageRus(playerid, COLOR_WHITE, string);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы слишком далеко от банкомата или банка");
			return 1;
		}
	}
	if(strcmp(cmd, "/loan", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if (gPlayerLogged[playerid] != 1)
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "СЕРВЕР: Вы должны быть авторизованы.");
			return 1;
		}
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /loan [amount]");
			format(string, sizeof(string), "Остаток в банке $%d.", PlayerInfo[playerid][pAccount]);
			SendClientMessageRus(playerid, COLOR_GRAD3, string);
			return 1;
		}
		new cashdeposit = strval(tmp);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /loan [amount]");
			format(string, sizeof(string), "Остаток в банке $%d.", PlayerInfo[playerid][pAccount]);
			SendClientMessageRus(playerid, COLOR_GRAD3, string);
			return 1;
		}
		if (PlayerInfo[playerid][pAccount] - cashdeposit < -50000)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы превысили лимит займов ($50000)");
			return 1;
		}
		if (PlayerInfo[playerid][pAccount] - cashdeposit > -1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Мы выдаем кредиты, а не берем их.");
			return 1;
		}
		if (IsPlayerInRangeOfPoint(playerid, 100,-30.875, -88.9609, 1004.53) || IsPlayerInRangeOfPoint(playerid, 100,246.3,109.2,1003.2))
		{
			SafeGivePlayerMoney(playerid,cashdeposit);
			new curfunds = PlayerInfo[playerid][pAccount];
			PlayerInfo[playerid][pAccount]=PlayerInfo[playerid][pAccount]-cashdeposit;
			SendClientMessageRus(playerid, COLOR_WHITE, "|___ БАНКОВСКИЙ СЧЕТ ___|");
			format(string, sizeof(string), "Старый баланс: $%d", curfunds);
			SendClientMessageRus(playerid, COLOR_GRAD2, string);
			format(string, sizeof(string), "Сумма займа:   $%d",cashdeposit);
			SendClientMessageRus(playerid, COLOR_GRAD4, string);
			SendClientMessageRus(playerid, COLOR_GRAD6, "|-----------------------------------------|");
			format(string, sizeof(string), "Новый баланс:  $%d", PlayerInfo[playerid][pAccount]);
			SendClientMessageRus(playerid, COLOR_WHITE, string);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы слишком далеко от банкомата или банка");
			return 1;
		}
	}
	if(strcmp(cmd, "/withdraw", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /withdraw [amount]");
			format(string, sizeof(string), "Остаток в банке $%d.", PlayerInfo[playerid][pAccount]);
			SendClientMessageRus(playerid, COLOR_GRAD3, string);
			return 1;
		}
		new cashdeposit = strval(tmp);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /withdraw [amount]");
			format(string, sizeof(string), "Остаток в банке $%d.", PlayerInfo[playerid][pAccount]);
			SendClientMessageRus(playerid, COLOR_GRAD3, string);
			return 1;
		}
		if (cashdeposit > PlayerInfo[playerid][pAccount] || cashdeposit < 1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "У вас нет столько наличных");
			return 1;
		}
		if (IsPlayerInRangeOfPoint(playerid, 100,-30.875, -88.9609, 1004.53) || IsPlayerInRangeOfPoint(playerid, 100,246.3,109.2,1003.2))
		{
			SafeGivePlayerMoney(playerid,cashdeposit);
			PlayerInfo[playerid][pAccount]=PlayerInfo[playerid][pAccount]-cashdeposit;
			format(string, sizeof(string), "Вы сняли $%d со своего счета. Остаток: $%d ", cashdeposit,PlayerInfo[playerid][pAccount]);
			SendClientMessageRus(playerid, COLOR_YELLOW, string);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы слишком далеко от банкомата или банка");
			return 1;
		}
	}
	if(strcmp(cmd, "/balance", true) == 0)
	{
		if (IsPlayerInRangeOfPoint(playerid, 100,-30.875, -88.9609, 1004.53) || IsPlayerInRangeOfPoint(playerid, 100,246.3,109.2,1003.2))
		{
			format(string, sizeof(string), "Остаток в банке $%d.",PlayerInfo[playerid][pAccount]);
			SendClientMessageRus(playerid, COLOR_YELLOW, string);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы слишком далеко от банкомата или банка");
			return 1;
		}
	}
	if(strcmp(cmd, "/dice", true) == 0)
	{
		new dice = random(6)+1;
		if (gDice[playerid] == 1)
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "* %s бросил кости. Выпало %d", sendername,dice);
			ProxDetector(5.0, playerid, string, TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR,TEAM_GREEN_COLOR);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "У вас нет костей");
			return 1;
		}
	}
	if(strcmp(cmd, "/betdm", true) == 0) //BizzInfo[5][bDiscription]
	{
		if (MissionActive == 13)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Дезматч уже начался");
			return 1;
		}
		/*
		if (PlayerInfo[playerid][pLocal] != 104)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "You are to far from a Betting shop");
			return 1;
		}
		*/
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /betdm [playerid/PartOfName] [amount]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /betdm [playerid/PartOfName] [amount]");
			return 1;
		}
		moneys = strval(tmp);
		if (moneys > 1000000)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Извините, ставка не должна превышать $1000000");
			return 1;
		}
		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney = GetPlayerMoney(playerid);
			if (moneys > 0 && playermoney >= moneys)
			{
				SafeGivePlayerMoney(playerid,-moneys);
				BizzInfo[5][bTakings] += moneys;
				BetDm[playerid][0] = giveplayerid;
				BetDm[playerid][1] = moneys;
				format(string, sizeof(string), "______-= %s =-_______", BizzInfo[5][bDiscription]);
				SendClientMessageRus(playerid, TEAM_VAGOS_COLOR,string);
				format(string, sizeof(string), "Вы поставили $%d на победу %s в следующем дезматче", moneys, giveplayer);
				SendClientMessageRus(playerid, COLOR_WHITE, string);
				SendClientMessageRus(playerid, TEAM_VAGOS_COLOR,"_______________________________________");
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				SendClientMessageRus(playerid, COLOR_GRAD1, string);
				format(string, sizeof(string), "$%d было поставлено игроком %s на вашу победу в следующем ДМ", moneys, sendername);
				SendClientMessageRus(giveplayerid, COLOR_GRAD1, string);
				format(string, sizeof(string), "%s bet $%d on %s", sendername, moneys, giveplayer);
				printf("%s", string);
				PayLog(string);
				PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Неправильная сумма ставки.");
			}
		}
		else
		{
				format(string, sizeof(string), "%d не активный игрок.", giveplayerid);
				SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		return 1;
	}
	if(strcmp(cmd, "/betrace", true) == 0)
	{
		if (MissionActive >= 7 && MissionActive <= 8 )
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Гонка уже началась");
			return 1;
		}
		/*
		if (PlayerInfo[playerid][pLocal] != 104)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "You are to far from a Betting shop");
			return 1;
		}
		*/
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /betrace [playerid/PartOfName] [amount]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /betrace [playerid/PartOfName] [amount]");
			return 1;
		}
		moneys = strval(tmp);
		if (moneys > 1000000)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Извините, ставка не должна превышать $1000000");
			return 1;
		}
		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney = GetPlayerMoney(playerid);
			if (moneys > 0 && playermoney >= moneys)
			{
				SafeGivePlayerMoney(playerid,-moneys);
				BizzInfo[5][bTakings] += moneys;
				BetRace[playerid][0] = giveplayerid;
				BetRace[playerid][1] = moneys;
				format(string, sizeof(string), "______-= %s =-_______", BizzInfo[5][bDiscription]);
				SendClientMessageRus(playerid, TEAM_VAGOS_COLOR,string);
				format(string, sizeof(string), "Вы поставили $%d на победу %s в следующей гонке", moneys, giveplayer);
				SendClientMessageRus(playerid, COLOR_WHITE, string);
				SendClientMessageRus(playerid, TEAM_VAGOS_COLOR,"_______________________________________");
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				format(string, sizeof(string), "$%d поставлено игроком %s на вашу победу в следующей гонке", moneys, sendername);
				SendClientMessageRus(giveplayerid, COLOR_GRAD1, string);
				format(string, sizeof(string), "%s bet $%d on %s", sendername, moneys, giveplayer);
				printf("%s", string);
				PayLog(string);
				PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Неправильная сумма ставки.");
			}
		}
		else
		{
				format(string, sizeof(string), "%d не активный игрок.", giveplayerid);
				SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		return 1;
	}
	if(strcmp(cmd, "/bets", true) == 0)
	{
		format(string, sizeof(string), "______-= %s =-_______", BizzInfo[5][bDiscription]);
		SendClientMessageRus(playerid, TEAM_VAGOS_COLOR,string);
		if(BetRace[playerid][0] == -1)
		{
			format(giveplayer, sizeof(giveplayer), "Нет ставки");
		}
		else
		{
			GetPlayerName(BetRace[playerid][0], giveplayer, sizeof(giveplayer));
		}
		format(string, sizeof(string), "Гонка: %s Сумма: $%d",giveplayer, BetRace[playerid][1]);
		SendClientMessageRus(playerid, COLOR_WHITE,string);
		if(BetDm[playerid][0] == -1)
		{
			format(giveplayer, sizeof(giveplayer), "Нет ставки");
		}
		else
		{
			GetPlayerName(BetDm[playerid][0], giveplayer, sizeof(giveplayer));
		}
		format(string, sizeof(string), "ДМ: %s Сумма: $%d",giveplayer, BetDm[playerid][1]);
		SendClientMessageRus(playerid, COLOR_GRAD2,string);
		SendClientMessageRus(playerid, TEAM_VAGOS_COLOR,"_______________________________________");
	}
	if(strcmp(cmd, "/transfer", true) == 0 || strcmp(cmd, "/wiretransfer", true) == 0)
	{
		if(PlayerInfo[playerid][pLevel] < 3)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы должны быть минимум 3 уровня");
			return 1;
		}
		if (!IsPlayerInRangeOfPoint(playerid, 100,246.3,109.2,1003.2))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы слишком далеко от банка");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /transfer [playerid/PartOfName] [amount]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /transfer [playerid/PartOfName] [amount]");
			return 1;
		}
		moneys = strval(tmp);
		//if (gdebug){printf("DEBUG givecash_command: %d %d",giveplayerid,moneys);}
		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney = PlayerInfo[playerid][pAccount] ;
			if (moneys > 0 && playermoney >= moneys)
			{
				PlayerInfo[playerid][pAccount] -= moneys;
				PlayerInfo[giveplayerid][pAccount] += moneys;
				format(string, sizeof(string), "Вы передали $%d на счет %s", moneys, giveplayer,giveplayerid);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				SendClientMessageRus(playerid, COLOR_GRAD1, string);
				format(string, sizeof(string), "Вы получили $%d на свой банковский счет от %s", moneys, sendername, playerid);
				SendClientMessageRus(giveplayerid, COLOR_GRAD1, string);
				format(string, sizeof(string), "%s transferd $%d to %s", sendername, moneys, giveplayer);
				printf("%s", string);
				PayLog(string);
				PlayerPlaySound(giveplayerid, 1052, 0.0, 0.0, 0.0);
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Неправильная сумма перевода.");
			}
		}
		else
		{
				format(string, sizeof(string), "%d не активный игрок.", giveplayerid);
				SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		return 1;
	}
	if(strcmp(cmd, "/buy", true) == 0)
	{
		if (!IsPlayerInRangeOfPoint(playerid, 100,-30.875, -88.9609, 1004.53))//centerpoint 24-7
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не в магазине 24-7");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "ИСПОЛЬЗОВАНИЕ: /buy [item number]");
			SendClientMessageRus(playerid, COLOR_GREEN, "|_______ 24-7 _______|");
			SendClientMessageRus(playerid, COLOR_GRAD1, "| 1: Мобильник $500");
			SendClientMessageRus(playerid, COLOR_GRAD2, "| 2: Лотерейный билет $1000");
			SendClientMessageRus(playerid, COLOR_GRAD3, "| 3: Телефонная книга $500");
			SendClientMessageRus(playerid, COLOR_GRAD4, "| 4: Кости $500");
			SendClientMessageRus(playerid, COLOR_GRAD5, "| 5: Автомобильный ключ $5000");
			SendClientMessageRus(playerid, COLOR_GRAD5, "| 6: Автомобильный замок $10000");
			SendClientMessageRus(playerid, COLOR_GRAD6, "| 7: Спидометр $5000");
			SendClientMessageRus(playerid, COLOR_GREEN, "|----------------------------------|");
			return 1;
		}
		new item = strval(tmp);
		if(BizzInfo[6][bProd] == 0)
		{
			GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
			return 1;
		}
		if (item == 1 && GetPlayerMoney(playerid) > 500)
		{
			SafeGivePlayerMoney(playerid,-500);
			BizzInfo[6][bTakings] = BizzInfo[6][bTakings]+500;
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			new randphone = 1000 + random(8999);//minimum 1000  max 9999
			PlayerInfo[playerid][pPnumber] = randphone;
			format(string, sizeof(string), "Вы купили мобильник, ваш телефонный номер %d", randphone);
			SendClientMessageRus(playerid, COLOR_GRAD4, string);
			SendClientMessageRus(playerid, COLOR_GRAD5, "Вы можете посмотреть его в любое время введя /level");
			SendClientMessageRus(playerid, COLOR_WHITE, "ПОДСКАЗКА: Теперь вы можете ввести /help чтобы посмотреть команды для мобильника.");
			format(string, sizeof(string), "~r~-$%d", 500);
			GameTextForPlayerRus(playerid, string, 5000, 1);
			return 1;
		}
		if (item == 2 && GetPlayerMoney(playerid) > 1000)
		{
			SafeGivePlayerMoney(playerid,-1000);
			BizzInfo[6][bTakings] = BizzInfo[6][bTakings]+1000;
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			new prize;
			new symb1[32];
			new symb2[32];
			new symb3[32];
			new randcard1 = random(10);//minimum 1000  max 9999
			new randcard2 = random(10);//minimum 1000  max 9999
			new randcard3 = random(10);//minimum 1000  max 9999
			new r1, r2, r3;
			format(string, sizeof(string), "~r~-$%d", 1000);
			GameTextForPlayerRus(playerid, string, 5000, 1);
			if (gdebug >= 1){printf("randcard1 = %d,randcard2 = %d,randcard3 = %d",randcard1,randcard2,randcard3);}
			if(randcard1 >= 5)
			{
				format(symb1, sizeof(symb1), "~b~]");
				r1 = 1;
			}
			else if(randcard1 <= 4 && randcard1 >= 2)
			{
				format(symb1, sizeof(symb1), "~g~]");
				r1 = 2;
			}
			else if(randcard1 < 2)
			{
				format(symb1, sizeof(symb1), "~y~]");
				r1 = 3;
			}
			if(randcard2 >= 5)
			{
				format(symb2, sizeof(symb2), "~b~]");
				r2 = 1;
			}
			else if(randcard2 <= 4 && randcard2 >= 2)
			{
				format(symb2, sizeof(symb2), "~g~]");
				r2 = 2;
			}
			else if(randcard2 < 2)
			{
				format(symb2, sizeof(symb2), "~y~]");
				r2 = 3;
			}
			if(randcard3 >= 5)
			{
				format(symb3, sizeof(symb3), "~b~]");
				r3 = 1;
			}
			else if(randcard3 <= 4 && randcard3 >= 2)
			{
				format(symb3, sizeof(symb3), "~g~]");
				r3 = 2;
			}
			else if(randcard3 < 2)
			{
				format(symb3, sizeof(symb3), "~y~]");
				r3 = 3;
			}
			if (gdebug >= 1){printf("randcard1 = %d,randcard2 = %d,randcard3 = %d",randcard1,randcard2,randcard3);}
			if(r1 == r2 && r1 == r3)
			{
				if(randcard1 > 5)
				{
					prize = 100000;
				}
				if(randcard1 <= 4 && randcard1 >= 2)
				{
					prize = 10000;
				}
				if(randcard1 < 2)
				{
					prize = 2000;
				}
				SafeGivePlayerMoney(playerid,prize);
				BizzInfo[6][bTakings] = BizzInfo[6][bTakings]-prize;
				format(string, sizeof(string), "%s %s %s ~n~~n~~w~~g~$%d",symb1,symb2,symb3, prize);
			}
			else
			{
				format(string, sizeof(string), "%s %s %s ~n~~n~~w~~r~$0",symb1,symb2,symb3);
			}
			GameTextForPlayerRus(playerid, string, 3000, 3);
			return 1;
		}
		if (item == 3 && GetPlayerMoney(playerid) > 500)
		{
			SafeGivePlayerMoney(playerid,-500);
			BizzInfo[6][bTakings] = BizzInfo[6][bTakings]+500;
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			gPhoneBook[playerid] = 1;
			format(string, sizeof(string), "Приобретена телефонная книга, теперь вы можете узнать нужный номер.");
			SendClientMessageRus(playerid, COLOR_GRAD4, string);
			SendClientMessageRus(playerid, COLOR_WHITE, "ПОДСКАЗКА: Type /number <id/name>.");
			format(string, sizeof(string), "~r~-$%d", 500);
			GameTextForPlayerRus(playerid, string, 5000, 1);
			return 1;
		}
		if (item == 4 && GetPlayerMoney(playerid) > 500)
		{
			SafeGivePlayerMoney(playerid,-500);
			BizzInfo[6][bTakings] = BizzInfo[6][bTakings]+500;
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			gDice[playerid] = 1;
			format(string, sizeof(string), "Кости куплены.");
			SendClientMessageRus(playerid, COLOR_GRAD4, string);
			SendClientMessageRus(playerid, COLOR_WHITE, "Подсказка: Введите /dice ");
			format(string, sizeof(string), "~r~-$%d", 500);
			GameTextForPlayerRus(playerid, string, 5000, 1);
			return 1;
		}
		if (item == 5 && GetPlayerMoney(playerid) > 5000)
		{
			if (gLastCar[playerid] != 0)
			{
				if(HireCar[playerid] != -1)
				{
					gCarLock[HireCar[playerid]] = 0;
					UnLockCar(HireCar[playerid]);
					HireCar[playerid] = -1;
				}
				SafeGivePlayerMoney(playerid,-5000);
				BizzInfo[6][bTakings] = BizzInfo[6][bTakings]+5000;
				BizzInfo[6][bProd]--;
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				HireCar[playerid] = gLastCar[playerid];
				format(string, sizeof(string), "Ключ куплен, вы можете закрыть свою последнюю машину.");
				SendClientMessageRus(playerid, COLOR_GRAD4, string);
				SendClientMessageRus(playerid, COLOR_WHITE, "ПОДСКАЗКА: Введите /lock ");
				format(string, sizeof(string), "~r~-$%d", 5000);
				GameTextForPlayerRus(playerid, string, 5000, 1);
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_WHITE, "Вам нечего закрывать.");
			}
			return 1;
		}
		if (item == 6 && GetPlayerMoney(playerid) > 5000)
		{
			if(PlayerInfo[playerid][pPhousekey] != -1)
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i) == 1 && HireCar[PlayerInfo[playerid][pPhousekey]+1])
					{
						HireCar[i] = -1;
					}
				}
				SafeGivePlayerMoney(playerid,-10000);
				BizzInfo[6][bTakings] = BizzInfo[6][bTakings]+10000;
				BizzInfo[6][bProd]--;
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				format(string, sizeof(string), "Новый замок куплен.");
				SendClientMessageRus(playerid, COLOR_GRAD4, string);
				SendClientMessageRus(playerid, COLOR_WHITE, "ПОДСКАЗКА: Введите /lock ");
				format(string, sizeof(string), "~r~-$%d", 10000);
				GameTextForPlayerRus(playerid, string, 5000, 1);
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_WHITE, "Вам нечего запирать");
			}
			return 1;
		}
		if (item == 7 && GetPlayerMoney(playerid) > 5000)
		{
			gSpeedo[playerid] = 1;
			SafeGivePlayerMoney(playerid,-5000);
			BizzInfo[6][bTakings] = BizzInfo[6][bTakings]+5000;
			BizzInfo[6][bProd]--;
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			format(string, sizeof(string), "Спидометр куплен.");
			SendClientMessageRus(playerid, COLOR_GRAD4, string);
			SendClientMessageRus(playerid, COLOR_WHITE, "ПОДСКАЗКА: Введите /speedo ");
			format(string, sizeof(string), "~r~-$%d", 5000);
			GameTextForPlayerRus(playerid, string, 5000, 1);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "У вас недостаточно денег");
		}
		return 1;
	}
	if(strcmp(cmd, "/buyhouse", true) == 0)
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		GetPlayerName(playerid, playername, sizeof(playername));
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		for(new h = 0; h < sizeof(HouseInfo); h++)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.0, HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez]) && HouseInfo[h][hOwned] == 0)
			{
				if(PlayerInfo[playerid][pLevel] < HouseInfo[h][hLevel])
				{
					format(string, sizeof(string), "You Must Be Level %d To Purchase This", HouseInfo[h][hLevel]);
					SendClientMessageRus(playerid, COLOR_GRAD5, string);
					return 1;
				}
				if(PlayerInfo[playerid][pPhousekey] != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
				{
					SendClientMessageRus(playerid, COLOR_WHITE, "Вы уже владеете домом, введите /sellhouse, если хотите продать его.");
					return 1;
				}
				if(GetPlayerMoney(playerid) > HouseInfo[h][hValue])
				{
					PlayerInfo[playerid][pPhousekey] = h;
					HouseInfo[h][hOwned] = 1;
					GetPlayerName(playerid, sendername, sizeof(sendername));
					strmid(HouseInfo[h][hOwner], sendername, 0, strlen(sendername), 255);
					SafeGivePlayerMoney(playerid,-HouseInfo[h][hValue]);
					PlayerPlayMusic(playerid);
					SetPlayerInterior(playerid,HouseInfo[h][hInt]);
					SetPlayerPos(playerid,HouseInfo[h][hExitx],HouseInfo[h][hExity],HouseInfo[h][hExitz]);
					GameTextForPlayerRus(playerid, "~w~Welcome Home~n~You can exit at any time by moving to this door and typing /exit", 5000, 3);
					PlayerInfo[playerid][pInt] = HouseInfo[h][hInt];
					PlayerInfo[playerid][pLocal] = h;
					SendClientMessageRus(playerid, COLOR_WHITE, "Поздравляем с новым приобретением.");
					SendClientMessageRus(playerid, COLOR_WHITE, "Введите /help чтобы посмотреть новые команды.");
					DateProp(playerid);
					OnPropUpdate();
					PlayerUpdate(playerid);
					return 1;
				}
				else
				{
					SendClientMessageRus(playerid, COLOR_WHITE, "У вас недостаточно денег");
					return 1;
				}
			}
		}
	}
	if(strcmp(cmd, "/rentroom", true) == 0)
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		GetPlayerName(playerid, playername, sizeof(playername));
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		for(new h = 0; h < sizeof(HouseInfo); h++)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.0, HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez]) && HouseInfo[h][hOwned] == 1 &&  HouseInfo[h][hRentabil] == 1)
			{
				if(PlayerInfo[playerid][pPhousekey] != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
				{
					SendClientMessageRus(playerid, COLOR_WHITE, "Вы уже владеете домом, введите /sellhouse если хотите продать его.");
					return 1;
				}
				if(GetPlayerMoney(playerid) > HouseInfo[h][hRent])
				{
					PlayerInfo[playerid][pPhousekey] = h;
					SafeGivePlayerMoney(playerid,-HouseInfo[h][hRent]);
					HouseInfo[h][hTakings] = HouseInfo[h][hTakings]+HouseInfo[h][hRent];
					PlayerPlayMusic(playerid);
					SetPlayerInterior(playerid,HouseInfo[h][hInt]);
					SetPlayerPos(playerid,HouseInfo[h][hExitx],HouseInfo[h][hExity],HouseInfo[h][hExitz]);
					GameTextForPlayerRus(playerid, "~w~Welcome Home~n~You can exit at any time by moving to this door and typing /exit", 5000, 3);
					PlayerInfo[playerid][pInt] = HouseInfo[h][hInt];
					PlayerInfo[playerid][pLocal] = h;
					SendClientMessageRus(playerid, COLOR_WHITE, "Поздравляем, теперь вы можете посещать эту комнату в любое аремя.");
					SendClientMessageRus(playerid, COLOR_WHITE, "Введите /help чтобы узнать новые команды.");
					PlayerUpdate(playerid);
					return 1;
				}
				else
				{
					SendClientMessageRus(playerid, COLOR_WHITE, "У вас недостаточно денег");
					return 1;
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/rentcar", true) == 0)
	{
		if(GetPlayerVehicleID(playerid) >= 71 && GetPlayerVehicleID(playerid) <= 77)
		{
			new hirefee = HireCost(GetPlayerVehicleID(playerid));
			if(GetPlayerVehicleID(playerid) >= 71 && GetPlayerVehicleID(playerid) <= 74)
			{
				if(BizzInfo[9][bProd] == 0)
				{
					GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
					return 1;
				}
				if(PlayerInfo[playerid][pPbiskey] == 9)
				{
					GameTextForPlayerRus(playerid, "~w~No charge for the boss", 5000, 3);
					TogglePlayerControllable(playerid, 1);
					return 1;
				}
				if (GetPlayerMoney(playerid) <  BizzInfo[9][bEntcost])
				{
					SendClientMessageRus(playerid, COLOR_GRAD2, "У вас нет столько денег");
					return 1;
				}
				SafeGivePlayerMoney(playerid,-BizzInfo[9][bEntcost]);
				BizzInfo[9][bTakings] = BizzInfo[9][bTakings]+BizzInfo[9][bEntcost];
				BizzInfo[9][bProd]--;
			}
			if(GetPlayerVehicleID(playerid) >= 75 && GetPlayerVehicleID(playerid) <= 77)
			{
				if(BizzInfo[8][bProd] == 0)
				{
					GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
					return 1;
				}
				if(PlayerInfo[playerid][pPbiskey] == 8)
				{
					GameTextForPlayerRus(playerid, "~w~No charge for the boss", 5000, 3);
					TogglePlayerControllable(playerid, 1);
					return 1;
				}
				if (GetPlayerMoney(playerid) <  BizzInfo[8][bEntcost])
				{
					SendClientMessageRus(playerid, COLOR_GRAD2, "У вас нет столько денег");
					return 1;
				}
				SafeGivePlayerMoney(playerid,-BizzInfo[8][bEntcost]);
				BizzInfo[8][bTakings] = BizzInfo[8][bTakings]+BizzInfo[8][bEntcost];
				BizzInfo[8][bProd]--;
			}
			if(HireCar[playerid] != -1)
			{
				gCarLock[HireCar[playerid]] = 0;
				UnLockCar(HireCar[playerid]);
			}
			HireCar[playerid] = GetPlayerVehicleID(playerid);
			OnPropUpdate();
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			format(string, sizeof(string), "~w~We hope you enjoy ~n~the use of this car~n~To lock or unlock your car~n~type ~g~/lock~n~~w~please drive safely",hirefee);
			TogglePlayerControllable(playerid, 1);
			GameTextForPlayerRus(playerid, string, 5000, 3);
		}
		return 1;
	}
	if(strcmp(cmd, "/hirecar", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /hirecar [key id]");
				return 1;
			}
			new car = strval(tmp);
			/*
			if(HireCar[playerid] != -1)
			{
				gCarLock[HireCar[playerid]] = 0;
				UnLockCar(HireCar[playerid]);
				HireCar[playerid] = -1;
			}
			*/
			HireCar[playerid] = car;
			format(string, sizeof(string), "Машина арендована, вы можете запирать авто %d.",car);
			SendClientMessageRus(playerid, COLOR_GRAD4, string);
			SendClientMessageRus(playerid, COLOR_WHITE, "ПОДСКАЗКА: Введите /lock ");
			return 1;
		}
	}
	if(strcmp(cmd, "/switchkey", true) == 0)
	{
		if(!SwitchKey[playerid])
		{
			if(HireCar[playerid] != -1)
			{
				SwitchKey[playerid] = 1;
				GameTextForPlayerRus(playerid, "~w~You control now your house car", 5000, 6);
			}
			else
			{
				GameTextForPlayerRus(playerid, "~w~You do not hire a car", 5000, 6);
			}
			return 1;
		}
		else
		{
			SwitchKey[playerid] = 0;
			GameTextForPlayerRus(playerid, "~w~You control now your hire car", 5000, 6);
		}
		return 1;
	}
	if(strcmp(cmd, "/givekey", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		new car;
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /givekey [playerid/PartOfName]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(HireCar[playerid] == -1 && PlayerInfo[playerid][pPhousekey] == -1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "У вас нет ключа.");
			return 1;
		}
		else
		{
			if(HireCar[playerid] != -1 && SwitchKey[playerid] == 0)
			{
				car = HireCar[playerid];
				gCarLock[car] = 0;
				UnLockCar(car);
				HireCar[playerid] = -1;
			}
			else
			{
				car = PlayerInfo[playerid][pPhousekey]+1;
			}
		}
		if (IsPlayerConnected(giveplayerid))
		{
			if (ProxDetectorS(5.0, playerid, giveplayerid))
			{
				if(HireCar[giveplayerid] != -1)
				{
					gCarLock[HireCar[giveplayerid]] = 0;
					UnLockCar(HireCar[giveplayerid]);
				}
				HireCar[giveplayerid] = car;
				GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
				GetPlayerName(playerid, sendername, sizeof(sendername));
				format(string, sizeof(string), "Вы передали %s ключ от своей машины", giveplayer);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				SendClientMessageRus(playerid, COLOR_GRAD1, string);
				format(string, sizeof(string), "Вы получили ключ от машины %s", sendername);
				SendClientMessageRus(giveplayerid, COLOR_GRAD1, string);
				format(string, sizeof(string), "* %s вытаскивает связку ключей и кидает её %s.", sendername ,giveplayer);
				ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/unrentcar", true) == 0)
	{
		if(HireCar[playerid] != -1)
		{
			gCarLock[HireCar[playerid]] = 0;
			UnLockCar(HireCar[playerid]);
			HireCar[playerid] = -1;
			GameTextForPlayerRus(playerid, "~w~You no longer rent a car", 5000, 3);
		}
		return 1;
	}
	if(strcmp(cmd, "/unrent", true) == 0)
	{
		GetPlayerName(playerid, playername, sizeof(playername));
		if(PlayerInfo[playerid][pPhousekey] != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "Вы владелец этого дома.");
			return 1;
		}
		PlayerInfo[playerid][pPhousekey] = -1;
		SendClientMessageRus(playerid, COLOR_WHITE, "Вы теперь бомж");
		return 1;
	}
	if(strcmp(cmd, "/housewithdraw", true) == 0)
	{
		GetPlayerName(playerid, playername, sizeof(playername));
		new bouse = PlayerInfo[playerid][pPhousekey];
		if(PlayerInfo[playerid][pPhousekey] != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /housewithdraw [amount]");
				format(string, sizeof(string), "В вашем сейфе $%d.", HouseInfo[bouse][hTakings]);
				SendClientMessageRus(playerid, COLOR_GRAD3, string);
				return 1;
			}
			new cashdeposit = strval(tmp);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /housewithdraw [amount]");
				format(string, sizeof(string), "У вас в сейфе $%d.", HouseInfo[bouse][hTakings]);
				SendClientMessageRus(playerid, COLOR_GRAD3, string);
				return 1;
			}
			if (cashdeposit >  HouseInfo[bouse][hTakings] || cashdeposit < 1)
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "У вас в сейфе нет такой суммы");
				return 1;
			}
			if (!IsPlayerInRangeOfPoint(playerid, 100,HouseInfo[bouse][hExitx],HouseInfo[bouse][hExity],HouseInfo[bouse][hExitz]))
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "Вы слишком далеко от дома");
				return 1;
			}
			else
			{
				SafeGivePlayerMoney(playerid,cashdeposit);
				HouseInfo[bouse][hTakings]=HouseInfo[bouse][hTakings]-cashdeposit;
				format(string, sizeof(string), "Вы взяли $%d из сейфа. Остаток: $%d ", cashdeposit,BizzInfo[bouse][bTakings]);
				OnPropUpdate();
				SendClientMessageRus(playerid, COLOR_YELLOW, string);
				return 1;
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "вы не владеете домом.");
		}
		return 1;

	}
	if(strcmp(cmd, "/asellhouse", true) == 0)
	{
		GetPlayerName(playerid, playername, sizeof(playername));
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /asellhouse [houseid]");
			return 1;
		}
		new house = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			HouseInfo[house][hHel] = 0;
			HouseInfo[house][hArm] = 0;
			HouseInfo[house][hHealthx] = 0;
			HouseInfo[house][hHealthy] = 0;
			HouseInfo[house][hHealthz] = 0;
			HouseInfo[house][hArmourx] = 0;
			HouseInfo[house][hArmoury] = 0;
			HouseInfo[house][hArmourz] = 0;
			HouseInfo[house][hLock] = 1;
			HouseInfo[house][hOwned] = 0;
			HouseInfo[house][hVec] = 418;
			HouseInfo[house][hVcol1] = -1;
			HouseInfo[house][hVcol2] = -1;
			strmid(HouseInfo[house][hOwner], "The State", 0, strlen("The State"), 255);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			format(string, sizeof(string), "~w~You have sold this property", HouseInfo[house][hValue]);
			GameTextForPlayerRus(playerid, string, 10000, 3);
			OnPropUpdate();
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "Вы не админ.");
		}
		return 1;
	}
	if(strcmp(cmd, "/sellhouse", true) == 0)
	{
		GetPlayerName(playerid, playername, sizeof(playername));
		if(PlayerInfo[playerid][pPhousekey] == -1)
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "Вы не владеете домом.");
			return 1;
		}
		if(PlayerInfo[playerid][pPhousekey] != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
		{
			new house = PlayerInfo[playerid][pPhousekey];
			HouseInfo[house][hHel] = 0;
			HouseInfo[house][hArm] = 0;
			HouseInfo[house][hHealthx] = 0;
			HouseInfo[house][hHealthy] = 0;
			HouseInfo[house][hHealthz] = 0;
			HouseInfo[house][hArmourx] = 0;
			HouseInfo[house][hArmoury] = 0;
			HouseInfo[house][hArmourz] = 0;
			HouseInfo[house][hLock] = 1;
			HouseInfo[house][hOwned] = 0;
			HouseInfo[house][hVec] = 418;
			HouseInfo[house][hVcol1] = -1;
			HouseInfo[house][hVcol2] = -1;
			GetPlayerName(playerid, sendername, sizeof(sendername));
			strmid(HouseInfo[house][hOwner], "The State", 0, strlen("The State"), 255);
			SafeGivePlayerMoney(playerid,HouseInfo[house][hValue]);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			format(string, sizeof(string), "~w~Congratulations~n~ You have sold your property for ~n~~g~$%d", HouseInfo[house][hValue]);
			GameTextForPlayerRus(playerid, string, 10000, 3);
			PlayerInfo[playerid][pPhousekey] = -1;
			if(PlayerInfo[playerid][pLocal] == house)
			{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,HouseInfo[house][hEntrancex],HouseInfo[house][hEntrancey],HouseInfo[house][hEntrancez]);
				PlayerInfo[playerid][pInt] = 0;
			}
			OnPropUpdate();
			PlayerUpdate(playerid);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "Вы не владеете домом.");
		}
		return 1;
	}
	if(strcmp(cmd, "/houseupgrade", true) == 0 || strcmp(cmd, "/hu", true) == 0)
	{
		new house = PlayerInfo[playerid][pPhousekey];
		GetPlayerName(playerid, playername, sizeof(playername));
		if (house != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_WHITE, "ИСПОЛЬЗОВАНИЕ: /houseupgrade [item number]");
				SendClientMessageRus(playerid, COLOR_GRAD1, "|_______ Home Supplys _______|");
				SendClientMessageRus(playerid, COLOR_GRAD2, "| 1: Аптечка $50000");
				SendClientMessageRus(playerid, COLOR_GRAD3, "| 2: Бронежилет $100000");
				SendClientMessageRus(playerid, COLOR_GRAD5, "| 3: Телевизор $500");
				SendClientMessageRus(playerid, COLOR_WHITE, "| 4: Видеокамера на двери $1000");
				SendClientMessageRus(playerid, COLOR_GRAD5, "| 5: Подписка на канал ДМ $10000");
				SendClientMessageRus(playerid, COLOR_GRAD3, "| 6: Подписка на канал гонок $10000");
				SendClientMessageRus(playerid, COLOR_GRAD2, "| 7: Подписка на канал ВНН $20000");
				SendClientMessageRus(playerid, COLOR_GRAD1, "| 8: Система наблюдения за игроками $100000");
				return 1;
			}
			new item = strval(tmp);
			switch (item)
			{
				case 1:
				{
					if(SBizzInfo[5][sbProd] == 0)
					{
						GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
						return 1;
					}
					if(PlayerInfo[playerid][pLevel] < 5)
					{
						SendClientMessageRus(playerid, COLOR_GRAD5, "Вы должны быть 5 уровня для покупки этого апгрейда");
						return 1;
					}
					if(GetPlayerMoney(playerid) < 50000)
					{
						SendClientMessageRus(playerid, COLOR_GRAD5, "У вас недостаточно денег");
						return 1;
					}
					HouseInfo[house][hHel] = 1;
					SafeGivePlayerMoney(playerid,-50000);
					SBizzInfo[5][sbTakings] += 50000;//heal buisness
					SBizzInfo[5][sbProd]--;
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					SendClientMessageRus(playerid, COLOR_GRAD5, "Теперь вы можете лечиться дома. Введите /heal.");
				}
				case 2:
				{
					if(SBizzInfo[5][sbProd] == 0)
					{
						GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
						return 1;
					}
					if (PlayerInfo[playerid][pLevel] < 7)
					{
						SendClientMessageRus(playerid, COLOR_GRAD5, "Вы должны быть 7 уровня для покупки этого апгрейда");
						return 1;
					}
					if(GetPlayerMoney(playerid) < 100000)
					{
						SendClientMessageRus(playerid, COLOR_GRAD5, "У вас недостаточно денег");
						return 1;
					}
					HouseInfo[house][hArm] = 1;
					SafeGivePlayerMoney(playerid,-100000);
					SBizzInfo[5][sbTakings] += 100000;//heal buisness
					SBizzInfo[5][sbProd]--;
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					SendClientMessageRus(playerid, COLOR_GRAD5, "Теперь у вас дома есть бронежилет. Введите /heal.");
				}
				case 3:
				{
					if(BizzInfo[10][bProd] == 0)
					{
						GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
						return 1;
					}
					if (PlayerInfo[playerid][pLevel] < 3)
					{
						SendClientMessageRus(playerid, COLOR_GRAD5, "Вы должны быть 3 уровня для покупки этого апгрейда");
						return 1;
					}
					if(GetPlayerMoney(playerid) < 500)
					{
						SendClientMessageRus(playerid, COLOR_GRAD5, "У вас недостаточно денег");
						return 1;
					}

					HouseInfo[house][hHealthx] = 1;
					SafeGivePlayerMoney(playerid,-500);
					BizzInfo[10][bTakings] += 500;
					BizzInfo[10][bProd]--;
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					SendClientMessageRus(playerid, COLOR_GRAD5, "Вы купили телевизор, введите /tv.");
				}
				case 4:
				{
					if(BizzInfo[10][bProd] == 0)
					{
						GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
						return 1;
					}
					if (PlayerInfo[playerid][pLevel] < 3)
					{
						SendClientMessageRus(playerid, COLOR_GRAD5, "Вы должны быть 3 уровня для покупки этого апгрейда");
						return 1;
					}
					if(GetPlayerMoney(playerid) < 10000)
					{
						SendClientMessageRus(playerid, COLOR_GRAD5, "У вас недостаточно денег");
						return 1;
					}

					HouseInfo[house][hHealthy] = 1;
					SafeGivePlayerMoney(playerid,-10000);
					BizzInfo[10][bTakings] += 10000;
					BizzInfo[10][bProd]--;
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					SendClientMessageRus(playerid, COLOR_GRAD5, "Теперь вы можете следить за входом, введите /tv door.");
				}
				case 5:
				{
					if(BizzInfo[10][bProd] == 0)
					{
						GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
						return 1;
					}
					if (PlayerInfo[playerid][pLevel] < 3)
					{
						SendClientMessageRus(playerid, COLOR_GRAD5, "Вы должны быть 3 уровня для покупки этого апгрейда");
						return 1;
					}
					if(GetPlayerMoney(playerid) < 10000)
					{
						SendClientMessageRus(playerid, COLOR_GRAD5, "У вас недостаточно денег");
						return 1;
					}

					HouseInfo[house][hHealthz] = 1;
					SafeGivePlayerMoney(playerid,-10000);
					BizzInfo[10][bTakings] += 10000;
					BizzInfo[10][bProd]--;
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					SendClientMessageRus(playerid, COLOR_GRAD5, "Теперь вы можете смотреть дезматчи, введите /tv dm.");
				}
				case 6:
				{
					if(BizzInfo[10][bProd] == 0)
					{
						GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
						return 1;
					}
					if (PlayerInfo[playerid][pLevel] < 3)
					{
						SendClientMessageRus(playerid, COLOR_GRAD5, "Вы должны быть 3 уровня для покупки этого апгрейда");
						return 1;
					}
					if(GetPlayerMoney(playerid) < 10000)
					{
						SendClientMessageRus(playerid, COLOR_GRAD5, "У вас недостаточно денег");
						return 1;
					}

					HouseInfo[house][hArmourx] = 1;
					SafeGivePlayerMoney(playerid,-10000);
					BizzInfo[10][bTakings] += 10000;
					BizzInfo[10][bProd]--;
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					SendClientMessageRus(playerid, COLOR_GRAD5, "Теперь вы можете смотреть уличные гонки, введите /tv race.");
				}
				case 7:
				{
					if(BizzInfo[10][bProd] == 0)
					{
						GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
						return 1;
					}
					if (PlayerInfo[playerid][pLevel] < 3)
					{
						SendClientMessageRus(playerid, COLOR_GRAD5, "Вы должны быть 3 уровня для покупки этого апгрейда");
						return 1;
					}
					if(GetPlayerMoney(playerid) < 20000)
					{
						SendClientMessageRus(playerid, COLOR_GRAD5, "У вас недостаточно денег");
						return 1;
					}

					HouseInfo[house][hArmoury] = 1;
					SafeGivePlayerMoney(playerid,-20000);
					BizzInfo[10][bTakings] += 20000;
					BizzInfo[10][bProd]--;
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					SendClientMessageRus(playerid, COLOR_GRAD5, "Теперь вы можете наблюдать за Врагом Народа Номер 1, введите /tv pen.");
				}
				case 8:
				{
					if(BizzInfo[10][bProd] == 0)
					{
						GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
						return 1;
					}
					if (PlayerInfo[playerid][pLevel] < 3)
					{
						SendClientMessageRus(playerid, COLOR_GRAD5, "Вы должны быть 3 уровня для покупки этого апгрейда");
						return 1;
					}
					if(GetPlayerMoney(playerid) < 20000)
					{
						SendClientMessageRus(playerid, COLOR_GRAD5, "У вас недостаточно денег");
						return 1;
					}

					HouseInfo[house][hArmourz] = 1;
					SafeGivePlayerMoney(playerid,-100000);
					BizzInfo[10][bTakings] += 100000;
					BizzInfo[10][bProd]--;
					PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
					SendClientMessageRus(playerid, COLOR_GRAD5, "Теперь вы можете наблюдать за игроками, введите /tv <id>.");
				}
			}
			OnPropUpdate();
			PlayerUpdate(playerid);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не владеете домом");
			return 1;
		}
//		return 1;
	}
	if(strcmp(cmd, "/setrent", true) == 0)
	{
		new bouse = PlayerInfo[playerid][pPhousekey];
		GetPlayerName(playerid, playername, sizeof(playername));
		if (bouse != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_WHITE, "ИСПОЛЬЗОВАНИЕ: /setrent [RentFee]");
				return 1;
			}
			if(strval(tmp) < 1)
			{
				SendClientMessageRus(playerid, COLOR_WHITE, "Минимальная арендная плата $1");
				return 1;
			}
			HouseInfo[bouse][hRent] = strval(tmp);
			OnPropUpdate();
			format(string, sizeof(string), "House rent set to $%d", HouseInfo[bouse][hRent]);
			SendClientMessageRus(playerid, COLOR_WHITE, string);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не владеете домом");
			return 1;
		}
	}
	if(strcmp(cmd, "/evictall", true) == 0)
	{
		new bouse = PlayerInfo[playerid][pPhousekey];
		if (bouse != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) == 1 && i != playerid)
				{

					if (PlayerInfo[i][pPhousekey] == PlayerInfo[playerid][pPhousekey] )
					{
						SendClientMessageRus(i, COLOR_WHITE, "Вы были выселены");
						SendClientMessageRus(playerid, COLOR_WHITE, "Жилец был выселен.");
						PlayerInfo[i][pPhousekey] = -1;
						return 1;
					}

				}
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не владеете домом");
			return 1;
		}
	}
	if(strcmp(cmd, "/evict", true) == 0)
	{
		new bouse = PlayerInfo[playerid][pPhousekey];
		GetPlayerName(playerid, playername, sizeof(playername));
		if (bouse != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_WHITE, "ИСПОЛЬЗОВАНИЕ: /evict [playerid/PartOfName]");
			}
			new target = strval(tmp);
			if(!IsPlayerConnected(target)) return SendClientMessage(playerid, 0xAAAAAAAA, "Неправильный ID");
			if (target == playerid)
			{
				SendClientMessageRus(target, COLOR_WHITE, "Вы не можете выселить самого себя.");
				return 1;
			}
			if (PlayerInfo[target][pPhousekey] == PlayerInfo[playerid][pPhousekey] && (IsPlayerConnected(target)) == 1)
			{
				SendClientMessageRus(target, COLOR_WHITE, "Вы были выселены");
				SendClientMessageRus(playerid, COLOR_WHITE, "Жилец был выселен");
				PlayerInfo[target][pPhousekey] = -1;
				return 1;
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не владеете домом");
			return 1;
		}
	}
	if(strcmp(cmd, "/setrentable", true) == 0)
	{
		new bouse = PlayerInfo[playerid][pPhousekey];
		GetPlayerName(playerid, playername, sizeof(playername));
		if (bouse != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_WHITE, "ИСПОЛЬЗОВАНИЕ: /setrentable [0/1]");
			}
			HouseInfo[bouse][hRentabil] = strval(tmp);
			OnPropUpdate();
			new status[20];
			if(HouseInfo[bouse][hRentabil])
				status = "сдается";
			else
				status = "не сдается";
			format(string, sizeof(string), "Дом теперь %s", status);
			SendClientMessageRus(playerid, COLOR_WHITE, string);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не владеете домом");
			return 1;
		}
	}
	if(strcmp(cmd, "/call", true) == 0 || strcmp(cmd, "/c", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: (/c)all [phonenumber]");
			return 1;
		}
		if(PlayerInfo[playerid][pPnumber] == 0)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "..У вас нет мобильника");
			return 1;
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "* %s вынимает мобильник.", sendername);
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		new phonenumb = strval(tmp);
		if(phonenumb == 911)
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "ПОДСКАЗКА: Сейчас вы разговариваете по телефону, введите /hangup чтобы завершить разговор");
			SendClientMessageRus(playerid, COLOR_ALLDEPT, "ДИСПЕТЧЕР: Какая служба вам нужна, полиция или скорая?");
			Mobile[playerid] = 911;
			return 1;
		}
		if(phonenumb == PlayerInfo[playerid][pPnumber])
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "..Вы слишите сигнал 'занято'");
			return 1;
		}
		if(Mobile[playerid] != -1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "..Вы уже разговариваете по телефону");
			return 1;
		}
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) == 1)
			{
				if(PlayerInfo[i][pPnumber] == phonenumb && phonenumb != 0)
				{
					giveplayerid = i;
					Mobile[playerid] = giveplayerid; //caller connecting
					if (Mobile[giveplayerid] == -1)
					{
						format(string, sizeof(string), "У вас звонит телефон, введите /pickup Абонент: %s", sendername);
						SendClientMessageRus(giveplayerid, COLOR_YELLOW, string);
						GetPlayerName(giveplayerid, sendername, sizeof(sendername));
						RingTone[giveplayerid] = 10;
						format(string, sizeof(string), "* У %s звонит телефон.", sendername);
						SendClientMessageRus(playerid, COLOR_WHITE, "ПОДСКАЗКА: Вы можете говорить по телефону, введите /hangup чтобы отклонить вызов");
						ProxDetector(30.0, i, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						CellTime[playerid] = 1;
						return 1;
					}
				}
			}
		}
		SendClientMessageRus(playerid, COLOR_GRAD2, "..Вы слышите сигнал 'занято'");
		return 1;
	}
	if(strcmp(cmd, "/txt", true) == 0 || strcmp(cmd, "/t", true) == 0 || strcmp(cmd, "/sms", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: (/t)ext [phonenumber] [text chat]");
			return 1;
		}
		if(PlayerInfo[playerid][pPnumber] == 0)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "..У вас нет мобильника");
			return 1;
		}
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "* %s вынимает мобильник.", sendername);
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		new phonenumb = strval(tmp);
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: (/t)ext [phonenumber] [text chat]");
			return 1;
		}
		if(phonenumb == 555)
		{
			if ((strcmp("да", result, true, strlen(result)) == 0) && (strlen(result) == strlen("да")))
			{
				SendClientMessageRus(playerid, COLOR_WHITE, "Текстовое сообщение доставлено");
				if (gTeam[playerid] == 2 || gTeam[playerid] == 1)
				{
					SendClientMessageRus(playerid, COLOR_YELLOW, "SMS: Не представляю, о чем мы с вами можем разговаривать, Отправитель: MOLE (555)");
					RingTone[playerid] = 20;
					return 1;
				}
				JobGive(playerid);
				return 1;
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_YELLOW, "SMS: Просто ответь да, чтобы получит задание, Отправитель: MOLE (555)");
				RingTone[playerid] = 20;
				return 1;
			}
		}
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) == 1)
			{
				if(PlayerInfo[i][pPnumber] == phonenumb && phonenumb != 0)
				{
					giveplayerid = i;
					Mobile[playerid] = giveplayerid; //caller connecting
					format(string, sizeof(string), "SMS: %s, Отправитель: %s (%d)", result,sendername,PlayerInfo[playerid][pPnumber]);
					GetPlayerName(giveplayerid, sendername, sizeof(sendername));
					//format(string, sizeof(string), "* У %s звонит телефон.", sendername);
					RingTone[giveplayerid] =20;
					SendClientMessageRus(playerid, COLOR_WHITE, "Текстовое сообщение доставлено");
					SendClientMessageRus(giveplayerid, COLOR_YELLOW, string);
					SendClientMessageRus(playerid,  COLOR_YELLOW, string);
					format(string, sizeof(string), "~r~$-%d", txtcost);
					GameTextForPlayerRus(playerid, string, 5000, 1);
					SafeGivePlayerMoney(playerid,-txtcost);
					BizzInfo[10][bTakings] += txtcost;
		           	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
		           	Mobile[playerid] = -1;
					return 1;
				}
			}
		}
		SendClientMessageRus(playerid, COLOR_GRAD2, "..Доставка сообщения провалилась");
		return 1;
	}
//----------------------------------[pickup]-----------------------------------------------

	if(strcmp(cmd, "/pickup", true) == 0 || strcmp(cmd, "/p", true) == 0)
	{
		if(Mobile[playerid] != -1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "..Вы уже разговариваете по телефону");
			return 1;
		}
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) == 1)
			{
				if(Mobile[i] == playerid)
				{
					Mobile[playerid] = i; //caller connecting
					SendClientMessageRus(i,  COLOR_GRAD2, "Вызываемый абонент поднял трубку.");
					GetPlayerName(playerid, sendername, sizeof(sendername));
					format(string, sizeof(string), "* %s отвечает по телефону.", sendername);
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
					RingTone[playerid] = 0;
				}

			}
		}
		return 1;
	}
	if(strcmp(cmd, "/hangup", true) == 0 || strcmp(cmd, "/h", true) == 0)
	{
		new caller = Mobile[playerid];
		if(caller != -1)
		{
			if(caller != -1)
			{
				SendClientMessageRus(caller,  COLOR_GRAD2, "Вызываемый абонент прервал соединение.");
				CellTime[caller] = 0;
				CellTime[playerid] = 0;
				SendClientMessageRus(playerid,  COLOR_GRAD2, "Вы прервали соединение.");
				Mobile[caller] = -1;
			}
			Mobile[playerid] = -1;
			CellTime[playerid] = 0;
			GetPlayerName(playerid, sendername, sizeof(sendername));
			format(string, sizeof(string), "* %s убирает свой мобильник.", sendername);
			ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
			RingTone[playerid] = 0;
			return 1;
		}
		SendClientMessageRus(playerid,  COLOR_GRAD2, "Ваш телефон уже в кармане.");
		return 1;
	}
//----------------------------------[TIME]-----------------------------------------------
    if(strcmp(cmd, "/fixr", true) == 0)
    {
		PlayerFixRadio(playerid);
		return 1;
	}
	if(strcmp(cmd, "/time", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new hour,minuite,second;
		gettime(hour,minuite,second);
		FixHour(hour);
		hour = shifthour;
		if (minuite < 10)
		{
			if (JailTime[playerid] > 0)
			{
				format(string, sizeof(string), "~g~|~w~%d:0%d~g~|~n~~w~Jail Time Left: %d sec", hour, minuite, JailTime[playerid]-10);
			}
			else
			{
				format(string, sizeof(string), "~g~|~w~%d:0%d~g~|", hour, minuite);
			}
		}
		else
		{
			if (JailTime[playerid] > 0)
			{
				format(string, sizeof(string), "~g~|~w~%d:%d~g~|~n~~w~Jail Time Left: %d sec", hour, minuite, JailTime[playerid]-10);
			}
			else
			{
				format(string, sizeof(string), "~g~|~w~%d:%d~g~|", hour, minuite);
			}
		}
		GameTextForPlayerRus(playerid, string, 5000, 1);
		format(string, sizeof(string), "* %s посмотрел на часы.", sendername);
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		return 1;
	}
//----------------------{HOUSES}-------------------
	if(strcmp(cmd, "/house", true) == 0 && PlayerInfo[playerid][pAdmin] >= 3)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /house [housenumber]");
			return 1;
		}
		new housenum = strval(tmp);
		if(housenum < 0 || housenum >=sizeof(HouseInfo)) return 1;
		SetPlayerInterior(playerid,HouseInfo[housenum][hInt]);
		SetPlayerPos(playerid,HouseInfo[housenum][hExitx],HouseInfo[housenum][hExity],HouseInfo[housenum][hExitz]);
		GameTextForPlayerRus(playerid, "~w~Teleporting", 5000, 1);
		PlayerInfo[playerid][pInt] = HouseInfo[housenum][hInt];
		PlayerInfo[playerid][pLocal] = housenum;
		return 1;
	}
	if(strcmp(cmd, "/biz", true) == 0 && PlayerInfo[playerid][pAdmin] >= 3)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /biz [housenumber]");
			return 1;
		}
		new housenum = strval(tmp);
		if(housenum < 0 || housenum >=sizeof(BizzInfo))
		SetPlayerInterior(playerid,BizzInfo[housenum][bInt]);
		SetPlayerPos(playerid,BizzInfo[housenum][bExitx],BizzInfo[housenum][bExity],BizzInfo[housenum][bExitz]);
		GameTextForPlayerRus(playerid, "~w~Teleporting", 5000, 1);
		PlayerInfo[playerid][pInt] = BizzInfo[housenum][bInt];
		PlayerInfo[playerid][pLocal] = housenum+99;
		return 1;
	}
	if(strcmp(cmd, "/sbiz", true) == 0 && PlayerInfo[playerid][pAdmin] >= 3)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /sbiz [biznumber]");
			return 1;
		}
		new housenum = strval(tmp);
		if(housenum < 0 || housenum >=sizeof(SBizzInfo))
		SetPlayerInterior(playerid,SBizzInfo[housenum][sbInt]);
		SetPlayerPos(playerid,SBizzInfo[housenum][sbEntrancex],SBizzInfo[housenum][sbEntrancey],SBizzInfo[housenum][sbEntrancez]);
		GameTextForPlayerRus(playerid, "~w~Teleporting", 5000, 1);
		return 1;
	}
	if(strcmp(cmd, "/edithousecar", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 1337)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не админ");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /edithousecar [vecid]");
			return 1;
		}
		new proplev = strval(tmp);
		for(new i = 0; i < sizeof(HouseInfo); i++)
		{
			if (IsPlayerInRangeOfPoint(playerid, 3,HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez]))
			{
				HouseInfo[i][hVec] = proplev;
				format(string, sizeof(string), "Домашняя машина: %d теперь %d", i,HouseInfo[i][hVec]);
				SendClientMessageRus(playerid, COLOR_GRAD2, string);
			}
		}
		OnPropUpdate();
		return 1;
	}
	if(strcmp(cmd, "/editlevel", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 1337)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не админ");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /editlevel [level]");
			return 1;
		}
		new proplev = strval(tmp);
		for(new i = 0; i < sizeof(HouseInfo); i++)
		{
			if (IsPlayerInRangeOfPoint(playerid, 3,HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez]))
			{
				format(string, sizeof(string), "Дом: %d", i);
				SendClientMessageRus(playerid, COLOR_GRAD2, string);
				if(proplev > 0)
				{
					HouseInfo[i][hLevel] = proplev;
				}
			}
		}
		for(new i = 0; i < sizeof(BizzInfo); i++)
		{
			if (IsPlayerInRangeOfPoint(playerid, 3,BizzInfo[i][bEntrancex], BizzInfo[i][bEntrancey], BizzInfo[i][bEntrancez]))
			{
				format(string, sizeof(string), "Бизнес: %d", i);
				SendClientMessageRus(playerid, COLOR_GRAD2, string);
				if(proplev > 0)
				{
					BizzInfo[i][bLevel] = proplev;
				}
			}
		}
		for(new i = 0; i < sizeof(SBizzInfo); i++)
		{
			if (IsPlayerInRangeOfPoint(playerid, 3,SBizzInfo[i][sbEntrancex], SBizzInfo[i][sbEntrancey], SBizzInfo[i][sbEntrancez]))
			{
				format(string, sizeof(string), "Малый бизнес: %d", i);
				SendClientMessageRus(playerid, COLOR_GRAD2, string);
				if(proplev > 0)
				{
					SBizzInfo[i][sbLevel] = proplev;
				}
			}
		}
		OnPropUpdate();
		return 1;
	}
	if(strcmp(cmd, "/editprod", true) == 0)
	{
		if(PlayerInfo[playerid][pAdmin] < 1337)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не админ");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /editprop [level]");
			return 1;
		}
		new proplev = strval(tmp);
		for(new i = 0; i < sizeof(BizzInfo); i++)
		{
			if (IsPlayerInRangeOfPoint(playerid, 3,BizzInfo[i][bEntrancex], BizzInfo[i][bEntrancey], BizzInfo[i][bEntrancez]))
			{
				format(string, sizeof(string), "Бизнес: %d", i);
				SendClientMessageRus(playerid, COLOR_GRAD2, string);
				if(proplev > 0)
				{
					BizzInfo[i][bProdCost] = proplev;
				}
			}
		}
		for(new i = 0; i < sizeof(SBizzInfo); i++)
		{
			if (IsPlayerInRangeOfPoint(playerid, 3,SBizzInfo[i][sbEntrancex], SBizzInfo[i][sbEntrancey], SBizzInfo[i][sbEntrancez]))
			{
				format(string, sizeof(string), "Малый бизнес: %d", i);
				SendClientMessageRus(playerid, COLOR_GRAD2, string);
				if(proplev > 0)
				{
					SBizzInfo[i][sbProdCost] = proplev;
				}
			}
		}
		OnPropUpdate();
		return 1;
	}
	if(strcmp(cmd, "/load", true) == 0)
	{
		new tmpcar = GetPlayerVehicleID(playerid);
		if(tmpcar < 78 || tmpcar > 81)
		{
			GameTextForPlayerRus(playerid, "~r~You are not in a delivery truck", 5000, 1);
			return 1;
		}
		format(string, sizeof(string), "Компоненты: %d/%d", PlayerHaul[tmpcar][pLoad],PlayerHaul[tmpcar][pCapasity]);
		SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
	}
	if(strcmp(cmd, "/buycomp", true) == 0)
	{
		new tmpcar = GetPlayerVehicleID(playerid);
		new compcost = 9000;
		if(IsPlayerInRangeOfPoint(playerid, 60.0, 2787.8,-2436.3,13.7))
		{
			if(IsATruck(tmpcar))
			{
				if(PlayerHaul[tmpcar][pLoad] < PlayerHaul[tmpcar][pCapasity])
				{
					new amount = PlayerHaul[tmpcar][pCapasity]-PlayerHaul[tmpcar][pLoad];
					new cost = amount*compcost;
					if(GetPlayerMoney(playerid) >= cost)
					{
						PlayerHaul[tmpcar][pLoad] = PlayerHaul[tmpcar][pCapasity];
						format(string, sizeof(string), "Компоненты: %d/%d", PlayerHaul[tmpcar][pLoad],PlayerHaul[tmpcar][pCapasity]);
						SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
						format(string, sizeof(string), "Вы купили %d компонент за $%d", amount,cost);
						SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
						SafeGivePlayerMoney(playerid,-cost);
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
						return 1;
					}
					else
					{
						format(string, sizeof(string), "Вы не можете купить %d компонент за $%d", amount,cost);
						SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
						return 1;
					}
				}
				else
				{
						format(string, sizeof(string), "Компоненты: %d/%d", PlayerHaul[tmpcar][pLoad],PlayerHaul[tmpcar][pCapasity]);
						SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
						return 1;
				}
			}
			else
			{
				SendClientMessageRus(playerid, TEAM_GROVE_COLOR, "Вы не в грузовике доставки.");
				return 1;
			}
		}
	}
	if(strcmp(cmd, "/sellcomp", true) == 0)
	{
		new tmpcar = GetPlayerVehicleID(playerid);
		new cashmade;
		if(!IsATruck(tmpcar))
		{
			GameTextForPlayerRus(playerid, "~r~You are not in a delivery truck", 5000, 1);
			return 1;
		}
		if(PlayerHaul[tmpcar][pLoad] == 0)
		{
			GameTextForPlayerRus(playerid, "~r~Truck is empty, return to the stock house", 5000, 1);
			format(string, sizeof(string), "Компоненты: %d/%d", PlayerHaul[tmpcar][pLoad],PlayerHaul[tmpcar][pCapasity]);
			SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
			return 1;
		}
		for(new i = 0; i < sizeof(BizzInfo); i++)
		{
			if (IsPlayerInRangeOfPoint(playerid, 10,BizzInfo[i][bEntrancex], BizzInfo[i][bEntrancey], BizzInfo[i][bEntrancez]))
			{
				//printf("Found House :%d",i);
				for(new l = PlayerHaul[tmpcar][pLoad]; l > 0; l--)
				{
					if(BizzInfo[i][bCompCap] == BizzInfo[i][bComp])
					{
						GameTextForPlayerRus(playerid, "~r~Our stores are full", 5000, 1);
						format(string, sizeof(string), "Вы заработали $%d", cashmade);
						SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
						format(string, sizeof(string), "Компоненты: %d/%d", PlayerHaul[tmpcar][pLoad],PlayerHaul[tmpcar][pCapasity]);
						SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
						format(string, sizeof(string), "%s sold comp for $%d to %s", sendername, cashmade, BizzInfo[i][bDiscription]);
						printf("%s", string);
						PayLog(string);
						return 1;
					}
					if(BizzInfo[i][bPayComp] > BizzInfo[i][bTakings])
					{
						GameTextForPlayerRus(playerid, "~r~We Cant Afford The Deal", 5000, 1);
						format(string, sizeof(string), "Вы заработали $%d", cashmade);
						SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
						format(string, sizeof(string), "Компоненты: %d/%d", PlayerHaul[tmpcar][pLoad],PlayerHaul[tmpcar][pCapasity]);
						SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
						format(string, sizeof(string), "%s sold comp for $%d to %s", sendername, cashmade, BizzInfo[i][bDiscription]);
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
						printf("%s", string);
						PayLog(string);
						return 1;
					}
					PlayerHaul[tmpcar][pLoad]--;
					BizzInfo[i][bComp]++;
					cashmade = cashmade+BizzInfo[i][bPayComp];
					SafeGivePlayerMoney(playerid,BizzInfo[i][bPayComp]);
					BizzInfo[i][bTakings] = BizzInfo[i][bTakings]-BizzInfo[i][bPayComp];
					if(PlayerHaul[tmpcar][pLoad] == 0 || PlayerHaul[tmpcar][pLoad] == 5)
					{
						PlayerInfo[playerid][pWA]++;
						if(PlayerInfo[playerid][pWA] >= 20)
						{
							PlayerInfo[playerid][pExp]++;
							PlayerInfo[playerid][pWA] = 0;
							SendClientMessageRus(playerid, COLOR_YELLOW, "Вы получаете бонус: +1 опыт");
						}
					}
					if(PlayerHaul[tmpcar][pLoad] == 0)
					{
						GameTextForPlayerRus(playerid, "~r~Truck is empty, return to the stock house", 5000, 1);
						format(string, sizeof(string), "Вы заработали $%d", cashmade);
						SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
						format(string, sizeof(string), "Компоненты: %d/%d", PlayerHaul[tmpcar][pLoad],PlayerHaul[tmpcar][pCapasity]);
						SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
						format(string, sizeof(string), "%s sold comp for $%d to %s", sendername, cashmade, BizzInfo[i][bDiscription]);
						PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
						printf("%s", string);
						PayLog(string);
						return 1;
					}
				}
				OnPropUpdate();
				return 1;
			}
		}
		for(new i = 0; i < sizeof(SBizzInfo); i++)
		{
			if (IsPlayerInRangeOfPoint(playerid, 10,SBizzInfo[i][sbEntrancex], SBizzInfo[i][sbEntrancey], SBizzInfo[i][sbEntrancez]))
			{
				//printf("Found House :%d",i);
				for(new l = PlayerHaul[tmpcar][pLoad]; l > 0; l--)
				{
					if(SBizzInfo[i][sbCompCap] == SBizzInfo[i][sbComp])
					{
						GameTextForPlayerRus(playerid, "~r~Our stores are full", 5000, 1);
						format(string, sizeof(string), "Вы заработали $%d", cashmade);
						SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
						format(string, sizeof(string), "Компоненты: %d/%d", PlayerHaul[tmpcar][pLoad],PlayerHaul[tmpcar][pCapasity]);
						SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
						return 1;
					}
					if(SBizzInfo[i][sbPayComp] > SBizzInfo[i][sbTakings])
					{
						GameTextForPlayerRus(playerid, "~r~We Cant Afford The Deal", 5000, 1);
						format(string, sizeof(string), "Вы заработали $%d", cashmade);
						SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
						format(string, sizeof(string), "Компоненты: %d/%d", PlayerHaul[tmpcar][pLoad],PlayerHaul[tmpcar][pCapasity]);
						SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
						return 1;
					}
					PlayerHaul[tmpcar][pLoad]--;
					SBizzInfo[i][sbComp]++;
					cashmade = cashmade+SBizzInfo[i][sbPayComp];
					SafeGivePlayerMoney(playerid,SBizzInfo[i][sbPayComp]);
					format(string, sizeof(string), "%s sold comp for $%d to %s", sendername, cashmade, SBizzInfo[i][sbDiscription]);
					printf("%s", string);
					PayLog(string);
					SBizzInfo[i][sbTakings] = SBizzInfo[i][sbTakings]-SBizzInfo[i][sbPayComp];
					if(PlayerHaul[tmpcar][pLoad] == 0 || PlayerHaul[tmpcar][pLoad] == 5)
					{
						PlayerInfo[playerid][pWA]++;
						if(PlayerInfo[playerid][pWA] >= 20)
						{
							PlayerInfo[playerid][pExp]++;
							PlayerInfo[playerid][pWA] = 0;
							SendClientMessageRus(playerid, COLOR_YELLOW, "Вы получаете бонус: +1 опыт");
						}
					}
					if(PlayerHaul[tmpcar][pLoad] == 0)
					{
						GameTextForPlayerRus(playerid, "~r~Truck is empty, return to the stock house", 5000, 1);
						format(string, sizeof(string), "Вы заработали $%d", cashmade);
						SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
						format(string, sizeof(string), "Компоненты: %d/%d", PlayerHaul[tmpcar][pLoad],PlayerHaul[tmpcar][pCapasity]);
						SendClientMessageRus(playerid, TEAM_GROVE_COLOR, string);
						return 1;
					}
				}
				OnPropUpdate();
				return 1;
			}
		}
		GameTextForPlayerRus(playerid, "~r~To Far From A Business", 5000, 1);
		return 1;
	}
	if(strcmp(cmd, "/enter", true) == 0)
	{
		for(new i = 0; i < sizeof(HouseInfo); i++)
		{
			if (IsPlayerInRangeOfPoint(playerid, 3,HouseInfo[i][hEntrancex], HouseInfo[i][hEntrancey], HouseInfo[i][hEntrancez]))
			{
				//printf("Found House :%d",i);
				if(PlayerInfo[playerid][pPhousekey] == i || HouseInfo[i][hLock] == 0)
				{
					SetPlayerInterior(playerid,HouseInfo[i][hInt]);
					SetPlayerPos(playerid,HouseInfo[i][hExitx],HouseInfo[i][hExity],HouseInfo[i][hExitz]);
					GameTextForPlayerRus(playerid, "~w~Welcome Home", 5000, 1);
					PlayerInfo[playerid][pInt] = HouseInfo[i][hInt];
					PlayerInfo[playerid][pLocal] = i;
				}
				else
				{
					GameTextForPlayerRus(playerid, "~r~Locked", 5000, 1);
				}
			}
		}
		for(new i = 0; i < sizeof(BizzInfo); i++)
		{
			if (IsPlayerInRangeOfPoint(playerid, 3,BizzInfo[i][bEntrancex], BizzInfo[i][bEntrancey], BizzInfo[i][bEntrancez]))
			{
				//printf("Found House :%d",i);
				if(PlayerInfo[playerid][pPbiskey] == i || GetPlayerMoney(playerid) >= BizzInfo[i][bEntcost] || (BizzInfo[i][bEntcost] > 20000 && PlayerInfo[playerid][pLevel] < 3))
				{
					if(PlayerInfo[playerid][pPbiskey] != i)
					{
						if(BizzInfo[i][bLock] == 1)
						{
							GameTextForPlayerRus(playerid, "~r~Closed", 5000, 1);
							return 1;
						}
						if(BizzInfo[i][bProd] == 0)
						{
							GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
							return 1;
						}
						SafeGivePlayerMoney(playerid,-BizzInfo[i][bEntcost]);
						format(string, sizeof(string), "~r~-$%d~n~~w~type /exit~n~to get out~n~Type ~g~/buygun ~w~to buy weapons", BizzInfo[i][bEntcost]);
						BizzInfo[i][bTakings] = BizzInfo[i][bTakings]+BizzInfo[i][bEntcost];
						BizzInfo[i][bProd]--;
						OnPropUpdate();
						GameTextForPlayerRus(playerid, string, 5000, 3);
						if(i == 7) //casino
						{
							gSpentCash[playerid] = GetPlayerMoney(playerid);
						}
					}
					SetPlayerInterior(playerid,BizzInfo[i][bInt]);
					SetPlayerPos(playerid,BizzInfo[i][bExitx],BizzInfo[i][bExity],BizzInfo[i][bExitz]);
					PlayerInfo[playerid][pInt] = BizzInfo[i][bInt];
					PlayerInfo[playerid][pLocal] = i+99;
					new dood[MAX_PLAYER_NAME];
					GetPlayerName(playerid, dood, sizeof(dood));
					format(string, sizeof(string), "%s payed $%d to enter biz %d", dood, BizzInfo[i][bEntcost], i);
					printf("%s", string);
					PayLog(string);
					//PlayerInfo[playerid][pLocal] = i;
				}
				else
				{
					GameTextForPlayerRus(playerid, "~r~You dont have the cash", 5000, 1);
				}
			}
		}
		for(new i = 0; i < sizeof(SBizzInfo); i++)
		{
			if (IsPlayerInRangeOfPoint(playerid, 3,SBizzInfo[i][sbEntrancex], SBizzInfo[i][sbEntrancey], SBizzInfo[i][sbEntrancez]))
			{
				if(PlayerInfo[playerid][pPbiskey] == i || GetPlayerMoney(playerid) >= SBizzInfo[i][sbEntcost] || (SBizzInfo[i][sbEntcost] > 20000 && PlayerInfo[playerid][pLevel] < 3))
				{
					if(PlayerInfo[playerid][pPbiskey] != i)
					{
						if(SBizzInfo[i][sbLock] == 1)
						{
							GameTextForPlayerRus(playerid, "~r~Closed", 5000, 1);
							return 1;
						}
						if(SBizzInfo[i][sbProd] == 0)
						{
							GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
							return 1;
						}
						if(i == 2 || i == 8) //planes school
						{
							SetVehicleParamsForPlayerEx(66,playerid,0,0);
							SetVehicleParamsForPlayerEx(67,playerid,0,0);
							SetVehicleParamsForPlayerEx(68,playerid,0,0);
							SetVehicleParamsForPlayerEx(69,playerid,0,0);
							SetVehicleParamsForPlayerEx(70,playerid,0,0);
							SetVehicleParamsForPlayerEx(71,playerid,0,0);
							SetVehicleParamsForPlayerEx(72,playerid,0,0);
							PLicence[playerid] = 1;
							SendClientMessageRus(playerid, TEAM_GROVE_COLOR, "Летная школа: Теперь вы можете управлять самолетом.");
						}
						if(i == 0) //parachute
						{

							SetPlayerInterior(playerid,1);
							SetPlayerPos(playerid,1.71875, 30.4062, 1200.34);
							PlayerInfo[i][pInt] = 0;
							gSkyDive[playerid] = 1;
						}
						if(i == 1) //wheele
						{
							//SetPlayerInterior(playerid,HouseInfo[i][hInt]);
							if (GetPlayerState(playerid) == 2)
							{
								new tmpcar = GetPlayerVehicleID(playerid);
								TelePos[playerid][0] = 0.0;
								TelePos[playerid][1] = 0.0;
								PlayerInfo[playerid][pLocal] = 10000;
								SetVehiclePos(tmpcar, -2724.0,217.9,4.1);
							}
							else
							{
								GameTextForPlayerRus(playerid, "~w~You must be in a Street Racer", 1000, 1);
								return 1;
							}
							Spectate[playerid] = 500;
							GameTextForPlayerRus(playerid, "~w~To Exit type ~r~/exit", 5000, 1);
							//PlayerInfo[playerid][pInt] = HouseInfo[i][hInt];
						}
						if(i == 3 || i == 7) //stealth school
						{
							Hidden[playerid] = 1;
							SetPlayerToTeamColor(playerid);
							GameTextForPlayerRus(playerid, "~w~Stealth Device~n~~g~Your icon is hidden", 5000, 3);
							SendClientMessageRus(playerid, TEAM_GROVE_COLOR, "Стелс активирован: Ваш маркер спрятан.");
						}
						if(i == 4) //towcar school
						{
							GameTextForPlayerRus(playerid, "~w~breakdown service~n~~g~type /towcar", 5000, 3);
							SendClientMessageRus(playerid, TEAM_GROVE_COLOR, "Чтобы воспользоваться нашим сервисом введите /towcar.");
							return 1;
						}
						if(i == 5) //homeupgrade school
						{
							GameTextForPlayerRus(playerid, "~w~Home Supply~~g~type /houseupgrade", 5000, 3);
							SendClientMessageRus(playerid, TEAM_GROVE_COLOR, "Чтобы воспользоваться нашим сервисом введите /houseupgrade.");
							return 1;
						}
						if(i == 6) //sellcars school
						{
							GameTextForPlayerRus(playerid, "~w~Car Sales~n~~g~type /carupgrade", 5000, 3);
							SendClientMessageRus(playerid, TEAM_GROVE_COLOR, "Чтобы воспользоваться нашим сервисом введите /carupgrade.");
							return 1;
						}
						if(i == 9 || i == 10) //buy school
						{
							Locator[playerid] = 1;
							GameTextForPlayerRus(playerid, "~w~Locator Device~n~~g~Your can locate best buys and sales", 5000, 3);
							SendClientMessageRus(playerid, TEAM_GROVE_COLOR, "Чтобы воспользоваться нашим сервисом введите /bestbuy или /bestsale");
						}
						if(i == 11 || i == 12) //buy school
						{
							SendClientMessageRus(playerid, TEAM_GROVE_COLOR, "Чтобы воспользоваться нашим сервисом введите /jointeam <teamid>");
							return 1;
						}
						SafeGivePlayerMoney(playerid,-SBizzInfo[i][sbEntcost]);
						gSpentCash[playerid] = GetPlayerMoney(playerid);
						SBizzInfo[i][sbProd]--;
						SBizzInfo[i][sbTakings] = SBizzInfo[i][sbTakings]+SBizzInfo[i][sbEntcost];
						new dood[MAX_PLAYER_NAME];
						GetPlayerName(playerid, dood, sizeof(dood));
						format(string, sizeof(string), "%s payed $%d to enter sbiz %d", dood, SBizzInfo[i][sbEntcost], i);
						printf("%s", string);
						PayLog(string);
						OnPropUpdate();
					}
				}
				else
				{
					GameTextForPlayerRus(playerid, "~r~You dont have the cash", 5000, 1);
				}
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/exit", true) == 0)
	{
		if (IsPlayerInRangeOfPoint(playerid, 10,-2724.0,217.9,4.1))
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1519.2,-1474.4,9.1);
			}
			else
			{
				SetPlayerPos(playerid, 1519.2,-1474.4,9.1);
				return 1;
			}
			new oldcash = gSpentCash[playerid];
			if(oldcash > 0)
			{
				new Total = GetPlayerMoney(playerid) - oldcash;
				printf("Total %d = GetPlayerMoney(playerid) %d - oldcash %d",Total,GetPlayerMoney(playerid),oldcash);
				new name[MAX_PLAYER_NAME];
				SBizzInfo[1][sbTakings] = SBizzInfo[1][sbTakings]+Total;
				GetPlayerName(playerid, name, sizeof(name));
				format(string,128,"<< %s has left the modshop with $%d >>",name,Total);
				PayLog(string);
			}
			gSpentCash[playerid] = 0;
			TelePos[playerid][0] = 0.0;
			TelePos[playerid][1] = 0.0;
			Spectate[playerid] = -1;
			PlayerInfo[playerid][pLocal] = -1;
		}
		for(new i = 0; i <  sizeof(HouseInfo); i++)
		{
			//printf("House :%d",i);
			if (IsPlayerInRangeOfPoint(playerid, 3,HouseInfo[i][hExitx], HouseInfo[i][hExity], HouseInfo[i][hExitz]))
			{
				SetPlayerInterior(playerid,0);
				SetPlayerPos(playerid,HouseInfo[i][hEntrancex],HouseInfo[i][hEntrancey],HouseInfo[i][hEntrancez]);
				PlayerInfo[playerid][pInt] = 0;
				PlayerInfo[playerid][pLocal] = -1;
				if(HouseInfo[i][hHel] == 1)
				{
					new Float:tempheal;
					GetPlayerHealth(playerid,tempheal);
					if(tempheal < 100.0)
					{
						SetPlayerHealth(playerid,100.0);
					}
				}
			}
		}
		for(new i = 0; i <  sizeof(BizzInfo); i++)
		{
			//printf("Bizz :%d",i);
			if (IsPlayerInRangeOfPoint(playerid, 3,BizzInfo[i][bExitx], BizzInfo[i][bExity], BizzInfo[i][bExitz]))
			{
				SetPlayerInterior(playerid,0);
				PlayerInfo[playerid][pInt] = 0;
				SetPlayerPos(playerid,BizzInfo[i][bEntrancex],BizzInfo[i][bEntrancey],BizzInfo[i][bEntrancez]);
				PlayerInfo[playerid][pLocal] = -1;
				if(i == 7 && PlayerInfo[playerid][pPbiskey] != 7) //casino
				{
					new oldcash = gSpentCash[playerid];
					if(oldcash > 0)
					{
						new Total = GetPlayerMoney(playerid) - oldcash;
						printf("Total %d = GetPlayerMoney(playerid) %d - oldcash %d",Total,GetPlayerMoney(playerid),oldcash);
						new name[MAX_PLAYER_NAME];
						BizzInfo[i][bTakings] = BizzInfo[i][bTakings]+Total;
						GetPlayerName(playerid, name, sizeof(name));
						format(string,128,"<< %s has left the casino with $%d >>",name,Total);
						PayLog(string);
						gSpentCash[playerid] = 0;
					}
				}
			}
		}
		if(GetPlayerVehicleID(playerid) >= 71 && GetPlayerVehicleID(playerid) <= 77)
		{
			TogglePlayerControllable(playerid, 1);
			RemovePlayerFromVehicle(playerid);
		}
		return 1;
	}
	if(strcmp(cmd, "/home", true) == 0)
	{
		if(PlayerInfo[playerid][pPhousekey] != -1)
		{
			SetPlayerCheckpointFixed(playerid,HouseInfo[PlayerInfo[playerid][pPhousekey]][hEntrancex], HouseInfo[PlayerInfo[playerid][pPhousekey]][hEntrancey], HouseInfo[PlayerInfo[playerid][pPhousekey]][hEntrancez], 4.0);
			GameTextForPlayerRus(playerid, "~w~Маркер установлен ~r~Home", 5000, 1);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_HOME;
		}
		else
		{
			GameTextForPlayerRus(playerid, "~w~You are homeless", 5000, 1);
		}
		return 1;
	}
	if(strcmp(cmd, "/modcar", true) == 0)
	{
		new tmpcar = GetPlayerVehicleID(playerid);
		new house = PlayerInfo[playerid][pPhousekey];
		GetPlayerName(playerid, playername, sizeof(playername));
		if (house != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
		{
			if(SBizzInfo[1][sbProd] == 0)
			{
				GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
				return 1;
			}
			if (GetPlayerState(playerid) != 2 && tmpcar != house+1)
			{
				GameTextForPlayerRus(playerid, "~r~Not in your housecar", 5000, 1);
				return 1;
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.0, HouseCarSpawns[tmpcar-1][0], HouseCarSpawns[tmpcar-1][1], HouseCarSpawns[tmpcar-1][2]))
			{
				SafeGivePlayerMoney(playerid,-1000);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				SBizzInfo[1][sbTakings] = SBizzInfo[1][sbTakings]+1000;//modshop buisness
				SBizzInfo[1][sbProd]--;
				TelePos[playerid][0] = 0.0;
				TelePos[playerid][1] = 0.0;
				SetVehiclePos(tmpcar, 1040.6,-1021.0,31.7);
				gSpentCash[playerid] = GetPlayerMoney(playerid);
				Spectate[playerid] = 500;
				GameTextForPlayerRus(playerid, "~w~To Exit type ~r~/exit~n~-$1000", 5000, 1);
			//PlayerInfo[playerid][pInt] = HouseInfo[i][hInt];
				PlayerInfo[playerid][pLocal] = 10001;
			}
			else
			{
				GameTextForPlayerRus(playerid, "~w~You are not at your home", 5000, 1);
			}
		}
		else
		{
			GameTextForPlayerRus(playerid, "~w~You are not a home owner", 5000, 1);
		}
		return 1;
	}
	if(strcmp(cmd, "/modst", true) == 0)
	{
		new tmpcar = GetPlayerVehicleID(playerid);
		new house = PlayerInfo[playerid][pPhousekey];
		GetPlayerName(playerid, playername, sizeof(playername));
		if (house != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
		{
			if(SBizzInfo[1][sbProd] == 0)
			{
				GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
				return 1;
			}
			if (GetPlayerState(playerid) != 2 && tmpcar != house+1)
			{
				GameTextForPlayerRus(playerid, "~r~Not in your housecar", 5000, 1);
				return 1;
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.0, HouseCarSpawns[tmpcar-1][0], HouseCarSpawns[tmpcar-1][1], HouseCarSpawns[tmpcar-1][2]))
			{
				SafeGivePlayerMoney(playerid,-1000);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				SBizzInfo[1][sbTakings] = SBizzInfo[1][sbTakings]+1000;//modshop buisness
				SBizzInfo[1][sbProd]--;
				TelePos[playerid][0] = 0.0;
				TelePos[playerid][1] = 0.0;
				SetVehiclePos(tmpcar, -2720.5,217.5,4.1);
				gSpentCash[playerid] = GetPlayerMoney(playerid);
				Spectate[playerid] = 500;
				GameTextForPlayerRus(playerid, "~w~To Exit type ~r~/exit~n~-$1000", 5000, 1);
			//PlayerInfo[playerid][pInt] = HouseInfo[i][hInt];
				PlayerInfo[playerid][pLocal] = 10002;
			}
			else
			{
				GameTextForPlayerRus(playerid, "~w~You are not at your home", 5000, 1);
			}
		}
		else
		{
			GameTextForPlayerRus(playerid, "~w~You are not a home owner", 5000, 1);
		}
		return 1;
	}
	if(strcmp(cmd, "/modlr", true) == 0)
	{
		new tmpcar = GetPlayerVehicleID(playerid);
		new house = PlayerInfo[playerid][pPhousekey];
		GetPlayerName(playerid, playername, sizeof(playername));
		if (house != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
		{
			if(SBizzInfo[1][sbProd] == 0)
			{
				GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
				return 1;
			}
			if (GetPlayerState(playerid) != 2 && tmpcar != house+1)
			{
				GameTextForPlayerRus(playerid, "~r~Not in your housecar", 5000, 1);
				return 1;
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.0, HouseCarSpawns[tmpcar-1][0], HouseCarSpawns[tmpcar-1][1], HouseCarSpawns[tmpcar-1][2]))
			{
				SafeGivePlayerMoney(playerid,-1000);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				SBizzInfo[1][sbTakings] = SBizzInfo[1][sbTakings]+1000;//modshop buisness
				SBizzInfo[1][sbProd]--;
				TelePos[playerid][0] = 0.0;
				TelePos[playerid][1] = 0.0;
				SetVehiclePos(tmpcar, 2644.6,-2044.9,13.3);
				gSpentCash[playerid] = GetPlayerMoney(playerid);
				Spectate[playerid] = 500;
				GameTextForPlayerRus(playerid, "~w~To Exit type ~r~/exit~n~-$1000", 5000, 1);
			//PlayerInfo[playerid][pInt] = HouseInfo[i][hInt];
				PlayerInfo[playerid][pLocal] = 10003;
			}
			else
			{
				GameTextForPlayerRus(playerid, "~w~You are not at your home", 5000, 1);
			}
		}
		else
		{
			GameTextForPlayerRus(playerid, "~w~You are not a home owner", 5000, 1);
		}
		return 1;
	}
	if(strcmp(cmd, "/towcar", true) == 0)
	{
		new house = PlayerInfo[playerid][pPhousekey];
		GetPlayerName(playerid, playername, sizeof(playername));
		if (house != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
		{
			if(SBizzInfo[4][sbProd] == 0)
			{
				GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
				return 1;
			}
			if(CarTow(house+1))
			{
				GameTextForPlayerRus(playerid, "~w~Car~n~~g~Towed Home~n~~r~$-1000", 5000, 1);
				SafeGivePlayerMoney(playerid,-1000);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				SBizzInfo[4][sbTakings] = SBizzInfo[4][sbTakings]+1000;//towcar buisness
				SBizzInfo[4][sbProd]--;
			}
			else
			{
				GameTextForPlayerRus(playerid, "~w~Car is~n~in ~r~use", 5000, 1);
			}
		}
		else
		{
			GameTextForPlayerRus(playerid, "~w~You are not a home owner", 5000, 1);
		}
		return 1;
	}
	if(strcmp(cmd, "/fixcar", true) == 0)
	{
		new house = PlayerInfo[playerid][pPhousekey];
		GetPlayerName(playerid, playername, sizeof(playername));
		if (house != -1 && strcmp(playername, HouseInfo[PlayerInfo[playerid][pPhousekey]][hOwner], true) == 0)
		{
			if(SBizzInfo[4][sbProd] == 0)
			{
				GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
				return 1;
			}
			if(CarRespawn(house+1))
			{
				GameTextForPlayerRus(playerid, "~w~Car~n~~g~Repaired~n~~r~$-1000", 5000, 1);
				SafeGivePlayerMoney(playerid,-1000);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				SBizzInfo[4][sbTakings] = SBizzInfo[4][sbTakings]+1000;//towcar buisness
				SBizzInfo[4][sbProd]--;
			}
			else
			{
				GameTextForPlayerRus(playerid, "~w~Car is~n~in ~r~use", 5000, 1);
			}
		}
		else
		{
			GameTextForPlayerRus(playerid, "~w~You are not a home owner", 5000, 1);
		}
		return 1;
	}
	// 		CreateVehicle(HouseInfo[h][hVec], HouseCarSpawns[h][0], HouseCarSpawns[h][1], HouseCarSpawns[h][2], HouseCarSpawns[h][3], HouseInfo[h][hVcol1], HouseInfo[h][hVcol2], -1);
	// 				SetVehiclePos(plo,plocx,plocy+4, plocz);
	if (strcmp(cmd, "/dmweapon", true) == 0)
	{
		new gunid[16];
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			format(string, sizeof(string), "ИСПОЛЬЗОВАНИЕ: /dmweapon [gunname]");
			SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
			SendClientMessageRus(playerid, COLOR_WHITE,"*** Оружие ДМ ***");
			SendClientMessageRus(playerid, COLOR_GRAD2,string);
			SendClientMessageRus(playerid, COLOR_GRAD3, "Пушки: default chainsaw sdpistol colt45 mp5 shotgun spas12");
			SendClientMessageRus(playerid, COLOR_GRAD3, "Пушки: deagle uzi sawnoff tec9 ak47 m4 rifle flamethrower");
			SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
			return 1;
		}
		strmid(gunid, tmp, 0, strlen(cmdtext), 255);
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			/*
			if (PlayerInfo[playerid][pLevel] >= 13 && (strcmp(gunid, "minigun", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "New Upgrade: You Will Now Spawn With A minigun");
				PlayerInfo[playerid][pGun6] = 38;
				ResetPlayerWeapons(playerid);
				SetPlayerWeapons(playerid);
				PlayerInfo[playerid][gPupgrade]--;
			}
			*/
			if ((strcmp(gunid, "flamethrower", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Оружие изменено на flamethrower");
				dmweapon = 37;
			}
			else if ((strcmp(gunid, "rifle", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Оружие изменено на rifle");
				dmweapon = 33;
			}
			else if ((strcmp(gunid, "m4", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Оружие изменено на m4");
				dmweapon = 31;
			}
			else if ((strcmp(gunid, "ak47", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Оружие изменено на ak47");
				dmweapon = 30;
			}
			else if ((strcmp(gunid, "Tec9", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Оружие изменено на Tec9");
				dmweapon = 32;
			}
			else if ((strcmp(gunid, "sawnoff", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Оружие изменено на sawnoff");
				dmweapon = 26;
			}
			else if ((strcmp(gunid, "uzi", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Оружие изменено на uzi");
				dmweapon = 28;
			}
			else if ((strcmp(gunid, "deagle", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Оружие изменено на deagle");
				dmweapon = 24;
			}
			else if ((strcmp(gunid, "spas12", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Оружие изменено на spas12");
				dmweapon = 27;
			}
			else if ((strcmp(gunid, "shotgun", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Оружие изменено на shotgun");
				dmweapon = 25;
			}
			else if ((strcmp(gunid, "mp5", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Оружие изменено на mp5");
				dmweapon = 29;
			}
			else if ((strcmp(gunid, "colt45", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Оружие изменено на colt45");
				dmweapon = 22;
			}
			else if ((strcmp(gunid, "sdpistol", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Оружие изменено на sdpistol");
				dmweapon = 23;
			}
			else if ((strcmp(gunid, "chainsaw", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Оружие изменено на chainsaw");
				dmweapon = 9;
			}
			else if ((strcmp(gunid, "default", true, strlen(gunid)) == 0))
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Оружие изменено на собственное");
				dmweapon = 0;
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD6, "Неизвестное оружие");
				return 1;
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD6, "Вы не админ");
			return 1;
		}
		return 1;
	}
	if(strcmp(cmd, "/startdm", true) == 0)
	{
		if(MissionActive == 0 || MissionActive == 4 || MissionActive == 8 || MissionActive == 12)
		{
			if (PlayerInfo[playerid][pAdmin] >= 3)
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i) && gPlayerSpawned[i])
					{
						SendClientMessageRus(i, COLOR_YELLOW, "SMS: Скоро начнется дезматч на красном маркере, Отправитель: MOLE (555)");
						RingTone[i] = 20;
						SendClientMessageRus(i, COLOR_WHITE, "ПОДСКАЗКА: Отправляйся на красный маркер и жди начала дезматча.");
						SetPlayerCheckpointFixed(i,gRandomDMSpawns[0][0],gRandomDMSpawns[0][1],gRandomDMSpawns[0][2], 4.0);
						GameTextForPlayerRus(i, "~w~Маркер установлен ~r~DM", 5000, 1);
						gPlayerCheckpointStatus[i] = CHECKPOINT_DM;
					}
				}
			}
			else
			{
				GameTextForPlayerRus(playerid, "~w~You are not admin", 5000, 1);
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Уже есть активная миссия");
		}
		return 1;
	}
	/*if(strcmp(cmd, "/plan", true) == 0)
	{
		SetPlayerInterior(playerid,10);
		SetPlayerPos(playerid,246.234, 117.805, 1005.61);
		//GetPlayerName(playerid, sendername, sizeof(sendername));
		GameTextForPlayerRus(playerid, "~w~Welcome Home", 5000, 1);
		//format(string, sizeof(string), "* %s checks the time.", sendername);
		//ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		return 1;
	}*/
//----------------------------------[BIZZ]-----------------------------------------------
	if(strcmp(cmd, "/buybiz", true) == 0)
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		GetPlayerName(playerid, playername, sizeof(playername));
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		if(PlayerInfo[playerid][pPbiskey] != -1)
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "Вы уже владеете бизнесом, введите /sellbiz если хотите его продать.");
			return 1;
		}
		for(new b = 0; b < sizeof(SBizzInfo); b++)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.0, SBizzInfo[b][sbEntrancex], SBizzInfo[b][sbEntrancey], SBizzInfo[b][sbEntrancez]) && SBizzInfo[b][sbOwned] == 0)
			{
				if(PlayerInfo[playerid][pLevel] < SBizzInfo[b][sbLevel])
				{
					format(string, sizeof(string), "Вы должны быть %d уровня, чтобы купить это",SBizzInfo[b][sbLevel]);
					SendClientMessageRus(playerid, COLOR_GRAD5, string);
					return 1;
				}
				if(GetPlayerMoney(playerid) > SBizzInfo[b][sbValue])
				{
					PlayerInfo[playerid][pPbiskey] = b+100;
					SBizzInfo[b][sbOwned] = 1;
					GetPlayerName(playerid, sendername, sizeof(sendername));
					strmid(SBizzInfo[b][sbOwner], sendername, 0, strlen(sendername), 255);
					SafeGivePlayerMoney(playerid,-SBizzInfo[b][sbValue]);
					PlayerPlayMusic(playerid);
					SendClientMessageRus(playerid, COLOR_WHITE, "Поздравляем с новым приобретением.");
					SendClientMessageRus(playerid, COLOR_WHITE, "Введите /help чтобы узнать новые команды.");
					DateProp(playerid);
					OnPropUpdate();
					PlayerUpdate(playerid);
					return 1;
				}
				else
				{
					SendClientMessageRus(playerid, COLOR_WHITE, "У вас недостаточно денег");
					return 1;
				}
			}
		}
		for(new b = 0; b < sizeof(BizzInfo); b++)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.0, BizzInfo[b][bEntrancex], BizzInfo[b][bEntrancey], BizzInfo[b][bEntrancez]) && BizzInfo[b][bOwned] == 0)
			{
				if(PlayerInfo[playerid][pLevel] < BizzInfo[b][bLevel])
				{
					format(string, sizeof(string), "Вы должны быть %d уровня, чтобы купить это",BizzInfo[b][bLevel]);
					SendClientMessageRus(playerid, COLOR_GRAD5, string);
					return 1;
				}
				if(GetPlayerMoney(playerid) > BizzInfo[b][bValue])
				{
					PlayerInfo[playerid][pPbiskey] = b;
					BizzInfo[b][bOwned] = 1;
					GetPlayerName(playerid, sendername, sizeof(sendername));
					strmid(BizzInfo[b][bOwner], sendername, 0, strlen(sendername), 255);
					SafeGivePlayerMoney(playerid,-BizzInfo[b][bValue]);
					PlayerPlayMusic(playerid);
					SetPlayerInterior(playerid,BizzInfo[b][bInt]);
					PlayerInfo[playerid][pInt] = BizzInfo[b][bInt];
					SetPlayerPos(playerid,BizzInfo[b][bExitx],BizzInfo[b][bExity],BizzInfo[b][bExitz]);
					GameTextForPlayerRus(playerid, "~w~Welcome~n~You can exit at any time by moving to this door and typing /exit", 5000, 3);
					PlayerInfo[playerid][pInt] = BizzInfo[b][bInt];
					PlayerInfo[playerid][pLocal] = b ;
					SendClientMessageRus(playerid, COLOR_WHITE, "Поздравляем сновым приобретением.");
					SendClientMessageRus(playerid, COLOR_WHITE, "Введите /help чтобы узнать новые команды.");
					DateProp(playerid);
					OnPropUpdate();
					PlayerUpdate(playerid);
					return 1;
				}
				else
				{
					SendClientMessageRus(playerid, COLOR_WHITE, "У вас недостаточно денег");
					return 1;
				}
			}
		}
	}
	if(strcmp(cmd, "/sellbiz", true) == 0)
	{
		GetPlayerName(playerid, playername, sizeof(playername));
		if(PlayerInfo[playerid][pPbiskey] == -1)
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "Вы не владеете бизнесом.");
			return 1;
		}
		if(PlayerInfo[playerid][pPbiskey] >= 100 && strcmp(playername, SBizzInfo[PlayerInfo[playerid][pPbiskey]-100][sbOwner], true) == 0)
		{
			new bouse = PlayerInfo[playerid][pPbiskey]-100;
			SBizzInfo[bouse][sbHel] = 0;
			SBizzInfo[bouse][sbArm] = 0;
			SBizzInfo[bouse][sbLock] = 1;
			SBizzInfo[bouse][sbOwned] = 0;
			SBizzInfo[bouse][sbTakings] = 0;
			GetPlayerName(playerid, sendername, sizeof(sendername));
			strmid(SBizzInfo[bouse][sbOwner], "The State", 0, strlen("The State"), 255);
			SafeGivePlayerMoney(playerid,SBizzInfo[bouse][sbValue]);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			format(string, sizeof(string), "~w~Congratulations~n~ You have sold your property for ~n~~g~$%d", SBizzInfo[bouse][sbValue]);
			GameTextForPlayerRus(playerid, string, 10000, 3);
			PlayerInfo[playerid][pPbiskey] = -1;
			OnPropUpdate();
			PlayerUpdate(playerid);
			return 1;
		}
		if(strcmp(playername, BizzInfo[PlayerInfo[playerid][pPbiskey]][bOwner], true) == 0)
		{
			new bouse = PlayerInfo[playerid][pPbiskey];
			BizzInfo[bouse][bHel] = 0;
			BizzInfo[bouse][bArm] = 0;
			BizzInfo[bouse][bLock] = 1;
			BizzInfo[bouse][bOwned] = 0;
			BizzInfo[bouse][bTakings] = 0;
			GetPlayerName(playerid, sendername, sizeof(sendername));
			strmid(BizzInfo[bouse][bOwner], "The State", 0, strlen("The State"), 255);
			SafeGivePlayerMoney(playerid,BizzInfo[bouse][bValue]);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			format(string, sizeof(string), "~w~Congratulations~n~ You have sold your property for ~n~~g~$%d", BizzInfo[bouse][bValue]);
			GameTextForPlayerRus(playerid, string, 10000, 3);
			PlayerInfo[playerid][pPbiskey] = -1;
			OnPropUpdate();
			PlayerUpdate(playerid);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "Вы не владеете бизнесом.");
		}
	}
	if(strcmp(cmd, "/asellbiz", true) == 0)
	{
		GetPlayerName(playerid, playername, sizeof(playername));
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /asellbiz [houseid]");
			return 1;
		}
		new biz = strval(tmp);
		new owner[MAX_PLAYER_NAME];
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			if(biz >=100 )
			{
			    SBizzInfo[biz - 100][sbHel] = 0;
				SBizzInfo[biz - 100][sbArm] = 0;
				SBizzInfo[biz - 100][sbLock] = 1;
				SBizzInfo[biz - 100][sbOwned] = 0;
				SBizzInfo[biz - 100][sbTakings] = 0;
				strmid(owner, SBizzInfo[biz - 100][sbOwner], 0, strlen(SBizzInfo[biz - 100][sbOwner]), 255);
				strmid(SBizzInfo[biz - 100][sbOwner], "The State", 0, strlen("The State"), 255);
//Обнуление ключей
				if(LoadPlayer(playerid,owner))
				{
					PLlayerInfo[playerid][plPbiskey] = -1;
					SavePlayer(playerid,owner);
				}
				SendClientMessageRus(playerid, COLOR_WHITE, "Бизнес продан.");
				OnPropUpdate();
			}
			else if (biz > -1 )
			{
			    BizzInfo[biz][bHel] = 0;
				BizzInfo[biz][bArm] = 0;
				BizzInfo[biz][bLock] = 1;
				BizzInfo[biz][bOwned] = 0;
				BizzInfo[biz][bTakings] = 0;
				strmid(owner, BizzInfo[biz][bOwner], 0, strlen(BizzInfo[biz][bOwner]), 255);
				strmid(BizzInfo[biz][bOwner], "The State", 0, strlen("The State"), 255);
//Обнуление ключей
				if(LoadPlayer(playerid,owner))
				{
					PLlayerInfo[playerid][plPbiskey] = -1;
					SavePlayer(playerid,owner);
				}

				SendClientMessageRus(playerid, COLOR_WHITE, "Бизнес продан.");
				OnPropUpdate();
			}
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "Вы не админ.");
		}
		return 1;
	}
	if (strcmp(cmd, "/bizinfo", true) == 0)
	{
		new bouse = PlayerInfo[playerid][pPbiskey];
		if(bouse == -1)
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "Вы не владеете бизнесом.");
		}
		if (bouse >= 100)
		{

			PrintSBizInfo(playerid,bouse-100);
		}
		else
		{
			PrintBizInfo(playerid,bouse);
		}
		return 1;
	}
	if(strcmp(cmd, "/bizfee", true) == 0)
	{
		new bouse = PlayerInfo[playerid][pPbiskey];
		if (bouse == -1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не владеете бизнесом");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "ИСПОЛЬЗОВАНИЕ: /bizfee [EntranceFee]");
		}
		if(strval(tmp) < 0)
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "Минимальная плата за вход $0");
			return 1;
		}
		if (bouse >= 100)
		{

			SBizzInfo[bouse-100][sbEntcost] = strval(tmp);
			format(string, sizeof(string), "Плата за вход установлена на $%d", SBizzInfo[bouse-100][sbEntcost]);
		}
		else
		{
			BizzInfo[bouse][bEntcost] = strval(tmp);
			format(string, sizeof(string), "Плата за вход установлена на $%d", BizzInfo[bouse][bEntcost]);
		}
		OnPropUpdate();
		SendClientMessageRus(playerid, COLOR_WHITE, string);
		return 1;
	}
	if(strcmp(cmd, "/pricemod", true) == 0)
	{
		new bouse = PlayerInfo[playerid][pPbiskey];
		if (bouse == -1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не владеете бизнесом");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "ИСПОЛЬЗОВАНИЕ: /pricemod [percentage of base value (default %100)]");
			return 1;
		}
		if(strval(tmp) < 0)
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "Минимум 0 процентов");
			return 1;
		}
		if (bouse >= 100)
		{
			SBizzInfo[bouse-100][sbEntcost] = strval(tmp);
			format(string, sizeof(string), "Вы не владеете крупным бизнесом");
		}
		else
		{
			BizzInfo[bouse][bPriceMod] = strval(tmp);
			format(string, sizeof(string), "Процентный показатель стоимости установлен на %d процентов", BizzInfo[bouse][bPriceMod]);
		}
		OnPropUpdate();
		SendClientMessageRus(playerid, COLOR_WHITE, string);
		return 1;
	}
	if(strcmp(cmd, "/compprice", true) == 0)
	{
		new bouse = PlayerInfo[playerid][pPbiskey];
		if (bouse == -1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не владеете бизнесом");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "ИСПОЛЬЗОВАНИЕ: /compprice [amount to pay per unit of components]");
		}
		if(strval(tmp) < 10000)
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "Минимальная сумма $10000");
			return 1;
		}
		if (bouse >= 100)
		{
			if(strval(tmp) > SBizzInfo[bouse-100][sbTakings])
			{
				SendClientMessageRus(playerid, COLOR_WHITE, "У вас в бизнесе недостаточно денег.");
				return 1;
			}
			SBizzInfo[bouse-100][sbPayComp] = strval(tmp);
			format(string, sizeof(string), "Закупка компонент по цене $%d", SBizzInfo[bouse-100][sbPayComp]);
		}
		else
		{
			if(strval(tmp) > BizzInfo[bouse][bTakings])
			{
				SendClientMessageRus(playerid, COLOR_WHITE, "У вас в бизнесе недостаточно денег.");
				return 1;
			}
			BizzInfo[bouse][bPayComp] = strval(tmp);
			format(string, sizeof(string), "Закупка компонент по цене $%d", BizzInfo[bouse][bPayComp]);
		}
		OnPropUpdate();
		SendClientMessageRus(playerid, COLOR_WHITE, string);
		return 1;
	}
	if(strcmp(cmd, "/missionactive", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "ИСПОЛЬЗОВАНИЕ: /missionactive [EntranceFee]");
		}
		MissionActive = strval(tmp);
		new sstring[256];
		format(sstring, sizeof(sstring), "MissionActive = %d",MissionActive);
		SendClientMessageRus(playerid, COLOR_GRAD1, sstring);
		return 1;
	}
	if(strcmp(cmd, "/bizname", true) == 0)
	{
		new bouse = PlayerInfo[playerid][pPbiskey];
		/*if (PlayerInfo[playerid][pAdmin] < 1337)
		{
			//SendClientMessageRus(playerid, COLOR_GRAD2, "You can't own a large business");
			return 1;
		}*/
		if (bouse == -1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не владеете бизнесом");
			return 1;
		}
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "ИСПОЛЬЗОВАНИЕ: /bizname [Name](не используйте ,)");
		}
		if (bouse >= 100)
		{
			strmid(SBizzInfo[bouse-100][sbDiscription], result, 0, 64, 255);
			format(string, sizeof(string), "Название бизнеса изменено на %s",SBizzInfo[bouse-100][sbDiscription]);
		}
		else
		{
			strmid(BizzInfo[bouse][bDiscription], result, 0, 64, 255);
			format(string, sizeof(string), "Название бизнеса изменено на %s",BizzInfo[bouse][bDiscription]);
		}
		OnPropUpdate();
		SendClientMessageRus(playerid, COLOR_WHITE, string);
		return 1;
	}
	if(strcmp(cmd, "/bizwithdraw", true) == 0)
	{
		new bouse = PlayerInfo[playerid][pPbiskey];
		if (bouse == -1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не владеете бизнесом");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			if (bouse >= 100)
			{
				format(string, sizeof(string), "У вас в бизнесе $%d.", SBizzInfo[bouse-100][sbTakings]);
				SendClientMessageRus(playerid, COLOR_GRAD3, string);
			}
			else
			{
				format(string, sizeof(string), "У вас в бизнесе $%d.", BizzInfo[bouse][bTakings]);
				SendClientMessageRus(playerid, COLOR_GRAD3, string);
			}
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /bizwithdraw [amount]");
			return 1;
		}
		new cashdeposit = strval(tmp);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /bizwithdraw [amount]");
			return 1;
		}
		if (bouse >= 100)
		{
			if(cashdeposit > SBizzInfo[bouse-100][sbTakings] || cashdeposit < 1)
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "У вас в бизнесе нет такой суммы");
				return 1;
			}
		}
		else
		{
			if (cashdeposit > BizzInfo[bouse][bTakings] || cashdeposit < 1)
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "У вас в бизнесе нет такой суммы");
				return 1;
			}
		}
		if (bouse >= 100)
		{
			if(!IsPlayerInRangeOfPoint(playerid, 100,SBizzInfo[bouse-100][sbEntrancex],SBizzInfo[bouse-100][sbEntrancey],SBizzInfo[bouse-100][sbEntrancez]))
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "Вы слишком далеко от бизнеса");
				return 1;
			}
			else
			{
				SafeGivePlayerMoney(playerid,cashdeposit);
				SBizzInfo[bouse-100][sbTakings]=SBizzInfo[bouse-100][sbTakings]-cashdeposit;
				format(string, sizeof(string), "Вы забрали $%d из своего бизнеса. Остаток: $%d ", cashdeposit,SBizzInfo[bouse-100][sbTakings]);
				OnPropUpdate();
				SendClientMessageRus(playerid, COLOR_YELLOW, string);
				return 1;
			}
		}
		else
		{
			if (!IsPlayerInRangeOfPoint(playerid, 100,BizzInfo[bouse][bExitx],BizzInfo[bouse][bExity],BizzInfo[bouse][bExitz]))
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "Вы слишком далеко от своего бизнеса");
				return 1;
			}
			else
			{
				SafeGivePlayerMoney(playerid,cashdeposit);
				BizzInfo[bouse][bTakings]=BizzInfo[bouse][bTakings]-cashdeposit;
				format(string, sizeof(string), "Вы забрали $%d из своего бизнеса. Остаток: $%d ", cashdeposit,BizzInfo[bouse][bTakings]);
				OnPropUpdate();
				SendClientMessageRus(playerid, COLOR_YELLOW, string);
				return 1;
			}
		}
	}
	if(strcmp(cmd, "/bizbank", true) == 0)
	{
		new bouse = PlayerInfo[playerid][pPbiskey];
		if (bouse == -1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не владеете бизнесом");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			if (bouse >= 100)
			{
				format(string, sizeof(string), "У вас в бизнесе $%d.", SBizzInfo[bouse-100][sbTakings]);
				SendClientMessageRus(playerid, COLOR_GRAD3, string);
			}
			else
			{
				format(string, sizeof(string), "У вас в бизнесе $%d.", BizzInfo[bouse][bTakings]);
				SendClientMessageRus(playerid, COLOR_GRAD3, string);
			}
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /bizbank [amount]");
			return 1;
		}
		new cashdeposit = strval(tmp);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /bizbank [amount]");
			SendClientMessageRus(playerid, COLOR_GRAD3, string);
			return 1;
		}
		if (cashdeposit > GetPlayerMoney(playerid) || cashdeposit < 1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "У вас нет столько денег");
			return 1;
		}
		if (bouse >= 100)
		{
			if(!IsPlayerInRangeOfPoint(playerid, 100,SBizzInfo[bouse-100][sbEntrancex],SBizzInfo[bouse-100][sbEntrancey],SBizzInfo[bouse-100][sbEntrancez]))
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "Вы слишком далеко от бизнеса");
				return 1;
			}
			else
			{
				SafeGivePlayerMoney(playerid,-cashdeposit);
				SBizzInfo[bouse-100][sbTakings]=SBizzInfo[bouse-100][sbTakings]+cashdeposit;
				format(string, sizeof(string), "Вы вложили $%d в свой бизнес. Остаток: $%d ", cashdeposit,SBizzInfo[bouse-100][sbTakings]);
				OnPropUpdate();
				SendClientMessageRus(playerid, COLOR_YELLOW, string);
				return 1;
			}
		}
		else
		{
			if (!IsPlayerInRangeOfPoint(playerid, 100,BizzInfo[bouse][bExitx],BizzInfo[bouse][bExity],BizzInfo[bouse][bExitz]))
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "Вы слишком далеко от бизнеса");
				return 1;
			}
			else
			{
				SafeGivePlayerMoney(playerid,-cashdeposit);
				BizzInfo[bouse][bTakings]=BizzInfo[bouse][bTakings]+cashdeposit;
				format(string, sizeof(string), "Вы вложили $%d в свой бизнес. Остаток: $%d ", cashdeposit,BizzInfo[bouse][bTakings]);
				OnPropUpdate();
				SendClientMessageRus(playerid, COLOR_YELLOW, string);
				return 1;
			}
		}
	}
	if(strcmp(cmd, "/bizupgrade", true) == 0)
	{
		new bouse = PlayerInfo[playerid][pPbiskey];
		if (bouse >= 100)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не владеете крупным бизнесом");
			return 1;
		}
		if (PlayerInfo[playerid][pInt] != BizzInfo[bouse][bInt])
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы должны быть в своем магазине!");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "ИСПОЛЬЗОВАНИЕ: /bizupgrade [item number]");
			SendClientMessageRus(playerid, COLOR_GRAD2, "|_______ Доступные апгрейды _______|");
			SendClientMessageRus(playerid, COLOR_GRAD3, "| 1: Аптечка     $50000");
			SendClientMessageRus(playerid, COLOR_GRAD4, "| 2: Бронежилет  $100000");
			return 1;
		}
		new item = strval(tmp);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_WHITE, "ИСПОЛЬЗОВАНИЕ: /bizupgrade [item number]");
			SendClientMessageRus(playerid, COLOR_GRAD2, "|_______ Доступные апгрейды _______|");
			SendClientMessageRus(playerid, COLOR_GRAD3, "| 1: Аптечка     $50000");
			SendClientMessageRus(playerid, COLOR_GRAD4, "| 2: Бронежилет  $100000");
			return 1;
		}
		switch (item)
		{
			case 1:
			{
				if(PlayerInfo[playerid][pLevel] < 5)
				{
					SendClientMessageRus(playerid, COLOR_GRAD5, "Вы должны быть 5 уровня, чтобы купить аптечку");
					return 1;
				}
				if(GetPlayerMoney(playerid) < 50000)
				{
					SendClientMessageRus(playerid, COLOR_GRAD5, "У вас недостаточно денег");
					return 1;
				}
				BizzInfo[bouse][bHel] = 1;
				SafeGivePlayerMoney(playerid,-50000);
				SBizzInfo[5][sbTakings] = SBizzInfo[5][sbTakings]+50000;//heal buisness
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
			case 2:
			{
				if (PlayerInfo[playerid][pLevel] < 8)
				{
					SendClientMessageRus(playerid, COLOR_GRAD5, "Вы должны быть 8 уровня, чтобы купить бронежилет");
					return 1;
				}
				if(GetPlayerMoney(playerid) < 100000)
				{
					SendClientMessageRus(playerid, COLOR_GRAD5, "У вас недостаточно денег");
					return 1;
				}
				BizzInfo[bouse][bArm] = 1;
				SafeGivePlayerMoney(playerid,-100000);
				SBizzInfo[5][sbTakings] = SBizzInfo[5][sbTakings]+100000;//heal buisness
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			}
		}
		OnPropUpdate();
		PlayerUpdate(playerid);
		SendClientMessageRus(playerid, COLOR_GRAD5, "Ваши покупатели теперь могут использовать /heal.");
		return 1;
	}
//----------------------------------[JOB]-----------------------------------------------

	if(strcmp(cmd, "/job", true) == 0)
	{
		if (gTeam[playerid] >= 3)
		{
			SendClientMessageRus(playerid, COLOR_YELLOW, objstore);
		}
		else if (gTeam[playerid] == 2)
		{
			SendClientMessageRus(playerid, COLOR_DBLUE, cbjstore);
		}
		return 1;
	}
//-----------------------------------[HEAL]-------------------------------------------------------------------------
	if(strcmp(cmd, "/heal", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new location = PlayerInfo[playerid][pLocal];
		if(!strlen(tmp))
		{
			if(location != -1)
			{
				if(location < 99)
				{
					if(HouseInfo[location][hArm] == 1)
					{
						format(string, sizeof(string), "* %s одевает бронежилет.", sendername);
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						SetPlayerArmour(playerid, 100);
					}
					else
					{
						format(string, sizeof(string), "Здесь нет бронежилетов");
						SendClientMessageRus(playerid, TEAM_GREEN_COLOR,string);
					}
					if(HouseInfo[location][hHel] == 1)
					{
						new Float:tempheal;
						GetPlayerHealth(playerid,tempheal);
						if ( tempheal < 100.0)
						{
							SetPlayerHealth(playerid,100.0);
							PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
							format(string, sizeof(string), "Вы были вылечены до 100 здоровья");
							SendClientMessageRus(playerid, TEAM_GREEN_COLOR,string);
						}
						else
						{
							SendClientMessageRus(playerid, TEAM_GREEN_COLOR,"Вы уже здоровы");
						}
					}
					else
					{
						format(string, sizeof(string), "Здесь нет аптечки");
						SendClientMessageRus(playerid, TEAM_GREEN_COLOR,string);
					}
					return 1;
				}
				else
				{
					if(BizzInfo[location-99][bArm] == 1)
					{
						format(string, sizeof(string), "* %s одевает броню.", sendername);
						ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
						SetPlayerArmour(playerid, 100);
					}
					else
					{
						format(string, sizeof(string), "Здесь нет бронежилетов");
						SendClientMessageRus(playerid, TEAM_GREEN_COLOR,string);
					}
					if(BizzInfo[location-99][bHel] == 1)
					{
						new Float:tempheal;
						GetPlayerHealth(playerid,tempheal);
						if ( tempheal < 100.0)
						{
							SetPlayerHealth(playerid,100.0);
							PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
							format(string, sizeof(string), "Вы были вылечены до 100 здоровья");
							SendClientMessageRus(playerid, TEAM_GREEN_COLOR,string);
						}
						else
						{
							SendClientMessageRus(playerid, TEAM_GREEN_COLOR,"Вы уже здоровы");
						}
					}
					else
					{
						format(string, sizeof(string), "Здесь нет аптечки");
						SendClientMessageRus(playerid, TEAM_GREEN_COLOR,string);
					}
					return 1;
				}
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /heal [playerid/PartOfName]");
				return 1;
			}
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if (giveplayerid == playerid)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не можете лечить себя!");
			return 1;
		}
		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new giveambu = GetPlayerVehicleID(giveplayerid);
			new playambu = GetPlayerVehicleID(playerid);
			if (gTeam[playerid] == TEAM_CYAN)//model
			{
				if ((playambu >= 61 && playambu <= 63) && (playambu == giveambu))
				{
					new Float:tempheal;
					GetPlayerHealth(giveplayerid,tempheal);
					if ( tempheal >= 150.0)
					{
						SendClientMessageRus(playerid, TEAM_GREEN_COLOR,"Этот игрок абсолютно здоров.");
						return 1;
					}
					format(string, sizeof(string), "~y~Вы вылечили ~n~~w~%s~n~~g~$%d", giveplayer,mediccharge);
					//printf("AdmCmd: %s has jailed %s.", sendername, giveplayer);
					SafeGivePlayerMoney(playerid,mediccharge);
					SafeGivePlayerMoney(giveplayerid,-mediccharge);
					GameTextForPlayerRus(playerid, string, 5000, 1);
					SetPlayerHealth(giveplayerid,150.0);
					PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
					PlayerPlaySound(giveplayerid, 1150, 0.0, 0.0, 0.0);
					if(gTeam[giveplayerid] == TEAM_CYAN)
					{
						format(string, sizeof(string), "Вы были вылечены до 150 здоровья за $%d",mediccharge);
						SendClientMessageRus(giveplayerid, TEAM_GREEN_COLOR,string);
						return 1;
					}
					else
					{
						format(string, sizeof(string), "Вы были вылечены до 150 здоровья за $%d",mediccharge);
						SendClientMessageRus(giveplayerid, TEAM_GREEN_COLOR,string);
						PlayerInfo[playerid][pWA]++;
						if(PlayerInfo[playerid][pWA] >= 20)
						{
							PlayerInfo[playerid][pExp]++;
							PlayerInfo[playerid][pWA] = 0;
							SendClientMessageRus(playerid, COLOR_YELLOW, "Вы получаете бонус: +1 опыт");
						}
					}

				}
				else
				{
					SendClientMessageRus(playerid, COLOR_GRAD1, "Один из вас не в машине скорой помощи!");
					return 1;
				}
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не можете использовать эту команду!");
				return 1;
			}
		}
		else
		{
			format(string, sizeof(string), "%d не активный игрок.", giveplayerid);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		return 1;
	}
//----------------------------------[ADMINADMIN]-----------------------------------------------
//----------------------------------[mole]-----------------------------------------------
	if(strcmp(cmd, "/mole", true) == 0 && PlayerInfo[playerid][pAdmin] >= 1337)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			//SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /mole [mole text]");
			return 1;
		}
		format(string, sizeof(string), "SMS: %s, Отправитель: MOLE (555)",result);
		if (gTeam[playerid] < 3){SendClientMessageRus(playerid, COLOR_YELLOW, string);}
		SendEnemyMessage(COLOR_YELLOW, string);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && gPlayerSpawned[i])
			{
				if(gTeam[i] >= 3)
				{
					RingTone[i] =20;
				}
			}
		}
		printf("MOLE: %s", result);
		return 1;
	}
//----------------------------------[HQ]-----------------------------------------------
	if(strcmp(cmd, "/hq", true) == 0 && PlayerInfo[playerid][pAdmin] >= 1337)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			//SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /hq [hq text]");
			return 1;
		}
		format(string, sizeof(string), "HQ: %s, over", result);
		if (gTeam[playerid] != 2 ){SendClientMessageRus(playerid, COLOR_DBLUE, string);}
		SendTeamBeepMessage(2, COLOR_DBLUE, string);
		printf("HQ: %s", result);
		return 1;
	}
//----------------------------------[RECON]-----------------------------------------------
	if(strcmp(cmd, "/bigears", true) == 0 && PlayerInfo[playerid][pAdmin] >= 2)
	{
		if (!BigEar[playerid])
		{
			BigEar[playerid] = 1;
			SendClientMessageRus(playerid, COLOR_GRAD2, "Твои уши выросли");
		}
		else if (BigEar[playerid])
		{
			(BigEar[playerid] = 0);
			SendClientMessageRus(playerid, COLOR_GRAD2, "Твои уши уменьшились");
		}
		return 1;
	}
	if(strcmp(cmd, "/id", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /id [playername]");
			return 1;
		}
		new target;
		if(IsStringAName(tmp))
		{
			target = GetPlayerID(tmp);
		}
		else
		{
			target = strval(tmp);
		}
		if(!IsPlayerConnected(target)) return SendClientMessage(playerid, 0xAAAAAAAA, "Неправильный ID");
		new sstring[256];
		GetPlayerName(target, giveplayer, sizeof(giveplayer));
		format(sstring, sizeof(sstring), "ID: (%d) %s",target,giveplayer);
		SendClientMessageRus(playerid, COLOR_GRAD1, sstring);
		return 1;
	}
	if(strcmp(cmd, "/tv", true) == 0 || strcmp(cmd, "/recon", true) == 0)
	{
		new house;
		if(Unspec[playerid][sLocal] == -1)
		{
			house = PlayerInfo[playerid][pLocal];
		}
		else
		{
			house = Unspec[playerid][sLocal];
		}
		if(PlayerInfo[playerid][pAdmin] < 1)
		{
			if(house == -1)
			{
				GameTextForPlayerRus(playerid, "~r~There is no tv here", 5000, 1);
				return 1;
			}
		}
		//printf("house has tv %d",HouseInfo[house][hHealthx]);
		TVMode[playerid] = 0;
		Unspec[playerid][sCam] = 2;
		if(Spectate[playerid] == -1 && PlayerInfo[playerid][pLocal] != -1 || Spectate[playerid] == -1 && PlayerInfo[playerid][pAdmin] > 0)
		{
			GetPlayerPos(playerid, Unspec[playerid][sPx], Unspec[playerid][sPy], Unspec[playerid][sPz]);
			Unspec[playerid][sPint] = PlayerInfo[playerid][pInt];
			Unspec[playerid][sLocal] = PlayerInfo[playerid][pLocal];
			PlayerInfo[playerid][pLocal] = -1;
			gTeam[playerid] = 0;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			if(HouseInfo[house][hHealthx] != 1)
			{
				GameTextForPlayerRus(playerid, "~r~Upgrade not installed", 5000, 1);
				return 1;
			}
			TVMode[playerid] = 1;
			Spectate[playerid] = lastkiller;
			GameTextForPlayerRus(playerid, "~w~                True~n~                   ~b~Crime", 5000, 6);
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			return 1;
		}
		if(strcmp("off", tmp, true, strlen(tmp)) == 0)
		{
			TogglePlayerControllable(playerid, 1);
			SetPlayerInterior(playerid,Unspec[playerid][sPint]);
			PlayerInfo[playerid][pInt] = Unspec[playerid][sPint];
			PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
			Unspec[playerid][sLocal] = -1;
			SetSpawnInfo(playerid, 1, PlayerInfo[playerid][pModel], Unspec[playerid][sPx],  Unspec[playerid][sPy], Unspec[playerid][sPz]-1.0, 1.0, -1, -1, -1, -1, -1, -1);
			//SetPlayerPos(playerid, Unspec[playerid][sPx], Unspec[playerid][sPy], Unspec[playerid][sPz]);
			gTeam[playerid] = PlayerInfo[playerid][pTeam];
			SetPlayerToTeamColor(playerid);
			SpawnPlayer(playerid);
			Spectate[playerid] = -1;
			GameTextForPlayerRus(playerid, "~w~                TV~n~~r~                Off", 5000, 6);
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			return 1;
		}
		if(strcmp("door", tmp, true, strlen(tmp)) == 0)
		{
			if(HouseInfo[house][hHealthy] != 1)
			{
				GameTextForPlayerRus(playerid, "~r~DoorCam not installed", 5000, 1);
				return 1;
			}
			if(PlayerInfo[playerid][pLocal] == -1 && Unspec[playerid][sLocal] == -1 )
			{
				GameTextForPlayerRus(playerid, "~r~no can do", 5000, 1);
				return 1;
			}
			house = Unspec[playerid][sLocal];
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && gPlayerSpawned[i])
				{
					if(IsPlayerInRangeOfPoint(i, 20.0, HouseInfo[house][hEntrancex], HouseInfo[house][hEntrancey],HouseInfo[house][hEntrancez]))
					{
						Unspec[playerid][sCam] = 10;
						Spectate[playerid] = i;
						GameTextForPlayerRus(playerid, "~b~Door~r~Cam~n~~w~Type /tv off~n~to exit", 5000, 1);
						PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
						return 1;
					}
				}
			}
			if(Unspec[playerid][sCam] != 10)
			{
				GameTextForPlayerRus(playerid, "~w~No one is at the door", 5000, 1);
				PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
			}
			return 1;
		}
		if(strcmp("dm", tmp, true, strlen(tmp)) == 0)
		{
			if(HouseInfo[house][hHealthz] != 1)
			{
				GameTextForPlayerRus(playerid, "~r~No subscription", 5000, 1);
				return 1;
			}
			if(MissionActive != 13 || DmHiPlayer == -1)
			{
				GameTextForPlayerRus(playerid, "~g~No DeathMatchs~n~~w~On TV now", 5000, 1);
				PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
				return 1;
			}
			TVMode[playerid] = 11;
			Spectate[playerid] = DmHiPlayer;
			GameTextForPlayerRus(playerid, "~r~                D~w~MTV", 5000, 6);
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			return 1;
		}
		if(strcmp("race", tmp, true, strlen(tmp)) == 0)
		{
			if(HouseInfo[house][hArmourx] != 1)
			{
				GameTextForPlayerRus(playerid, "~r~No subscription", 5000, 1);
				return 1;
			}
			if(MissionActive < 4 || MissionActive > 7)
			{
				GameTextForPlayerRus(playerid, "~g~No Races~n~~w~On TV now", 5000, 1);
				PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
				return 1;
			}
			TVMode[playerid] = 21;
			RaceSpec(playerid);
			GameTextForPlayerRus(playerid, "~w~                S~b~R~n~~r~                TV", 5000, 6);
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			return 1;
		}
		if(strcmp("pen", tmp, true, strlen(tmp)) == 0)
		{
			if(HouseInfo[house][hArmoury] != 1)
			{
				GameTextForPlayerRus(playerid, "~r~No subscription", 5000, 1);
				return 1;
			}
			if(gPublicEnemy == -1)
			{
				GameTextForPlayerRus(playerid, "~g~No Public Enemys~n~~w~On TV now", 5000, 1);
				PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
				return 1;
			}
			TVMode[playerid] = 31;
			PenDelay(playerid);
			GameTextForPlayerRus(playerid, "~p~                PEN~n~                ~w~TV", 5000, 6);
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			return 1;
		}
		if(strcmp("speed", tmp, true, strlen(tmp)) == 0)
		{
			if(Speeder == -1)
			{
				GameTextForPlayerRus(playerid, "~g~No Speeders ~n~~w~On TV now", 5000, 1);
				PlayerInfo[playerid][pLocal] = Unspec[playerid][sLocal];
				return 1;
			}
			TVMode[playerid] = 41;
			SpeedDelay(playerid);
			GameTextForPlayerRus(playerid, "~y~                Speed~n~                ~w~TV", 5000, 6);
			PlayerPlaySound(playerid, 1145, 0.0, 0.0, 0.0);
			return 1;
		}
		if(strcmp("foot", tmp, true, strlen(tmp)) == 0 && PlayerInfo[playerid][pAdmin] >= 1)
		{
			Spectate[playerid] = lastkiller;
		}
		if(strcmp("next", tmp, true, strlen(tmp)) == 0 && PlayerInfo[playerid][pAdmin] >= 1)
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) && gPlayerSpawned[i])
				{
					if(i > Spectate[playerid] && Spectate[playerid] != -1 && PlayerInfo[i][pLevel] <= 2)
					{
						new Float:health;
						GetPlayerHealth(i, health);
						Spectate[playerid] = i;
						new sstring[256];
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						new cash =  GetPlayerMoney(i);
						format(sstring, sizeof(sstring), "Recon: (%d) %s $%d H:%.1f ",i,giveplayer,cash,health);
						SendClientMessageRus(playerid, COLOR_GREEN, sstring);
						return 1;
					}
				}
			}
		}
		if(strcmp("prev", tmp, true, strlen(tmp)) == 0 && PlayerInfo[playerid][pAdmin] >= 1)
		{
			for(new i = MAX_PLAYERS; i >= 0; i--)
			{
				if(IsPlayerConnected(i) && gPlayerSpawned[i])
				{
					if(i < Spectate[playerid] && Spectate[playerid] != -1 && PlayerInfo[i][pLevel] <= 2)
					{
						new Float:health;
						GetPlayerHealth(i, health);
						Spectate[playerid] = i;
						new sstring[256];
						GetPlayerName(i, giveplayer, sizeof(giveplayer));
						new cash =  GetPlayerMoney(i);
						format(sstring, sizeof(sstring), "Recon: (%d) %s $%d H:%.1f",i,giveplayer,cash,health);
						SendClientMessageRus(playerid, COLOR_GREEN, sstring);
						return 1;
					}
				}
			}
		}
		if(house == -1)
		{
			if(PlayerInfo[playerid][pAdmin] < 1)
			{
				GameTextForPlayerRus(playerid, "~r~Upgrade not installed", 5000, 1);
				return 1;
			}
		}
		else
		{
			if(HouseInfo[house][hArmourz] != 1 && PlayerInfo[playerid][pAdmin] < 1)
			{
				GameTextForPlayerRus(playerid, "~r~Upgrade not installed", 5000, 1);
				return 1;
			}
		}
		if(IsStringAName(tmp))
		{
			Spectate[playerid] = GetPlayerID(tmp);
		}
		else
		{
			Spectate[playerid] = strval(tmp);
		}
		if(IsPlayerConnected(Spectate[playerid]))
		{
			if(Hidden[Spectate[playerid]] != 1 && PlayerInfo[playerid][pAdmin] < 1)
			{
				SendClientMessageRus(playerid, COLOR_GREEN, "Цель спрятана");
			}
			new Float:health;
			GetPlayerHealth(Spectate[playerid], health);
			new sstring[256];
			GetPlayerName(Spectate[playerid], giveplayer, sizeof(giveplayer));
			new cash =  GetPlayerMoney(Spectate[playerid]);
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				format(sstring, sizeof(sstring), "Recon: (%d) %s $%d H:%.0f",Spectate[playerid],giveplayer,cash,health);
			}
			else
			{
				format(sstring, sizeof(sstring), "UAV: (%d) %s",Spectate[playerid],giveplayer);
			}
			SendClientMessageRus(playerid, COLOR_GREEN, sstring);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GREEN, "Target is not available");
		}
		return 1;
	}
//----------------------------------[SPAWN]-----------------------------------------------

	if(strcmp(cmd, "/spawn", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			SetPlayerRandomSpawn(playerid);
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/spawn2", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			SpawnPlayer(playerid);
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/spawn3", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			OnPlayerSpawn(playerid);
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/pen", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			SetPlayerCriminal(playerid,-1, "Armed Robbery",1,1);
			gPlayerMission[playerid] = 1;
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
		}
		return 1;
	}
//----------------------------------[PAYDAY]-----------------------------------------------

	if(strcmp(cmd, "/payday", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			PayDay();
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/incmis", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			gRaceLeader=1;
			gFightLeader=1;
			SendClientMessageRus(playerid, COLOR_GRAD1, "Playercount Incrementeted");
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
		}
		return 1;
	}
//----------------------------------[TEST]-----------------------------------------------

	if(strcmp(cmd, "/test", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			new sstring[256];
			new playambu = GetPlayerVehicleID(playerid);
			format(sstring, sizeof(sstring), "currentpickups = %d gFighters = %d gFightLeader = %d dmtimer = %d DmHiScore = %d",pickups ,gFighters ,gFightLeader,dmtimer,DmHiScore);
			SendClientMessageRus(playerid, COLOR_GRAD1, sstring);
			format(sstring, sizeof(sstring), "currentcar = %d locked[%d] stealcar = %d stealcardest = %d MissionActive = %d",playambu,gCarLock[playambu],stealcar,stealcardest,MissionActive);
			SendClientMessageRus(playerid, COLOR_GRAD1, sstring);
			//GetPlayerVehicleID(playerid);
			/*
			for(new i = 0; i <= 24; i++)
			{
				format(sstring, sizeof(sstring), "currentpickups = %d", pickups);
				print(sstring);
			}

			//SetSpawnInfo(playerid, 2, 153, 0.0, 0.0, 0.0, 0.1, -1, -1, -1, -1, -1, -1);
		   // SpawnPlayer(playerid);
			if (CopCheck(playerid))
			{
				print("yes you are a cop");
			}
			else
			{
				print("not a cop cop");
			}
		    //printf("johnsid = %d",GetPlayerID("John_"));
			//SetPlayerCriminal(playerid,-1, "Armed Robbery",1,0);
			//GameTextForPlayerRus(playerid, string, 5000, 1);
			//SendClientMessageRus(playerid, COLOR_GRAD1, string);
			*/
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/patch", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
				SBizzInfo[0][sbPayComp] = 10000;
				SBizzInfo[1][sbPayComp] = 11000;
				SBizzInfo[2][sbPayComp] = 12000;
				SBizzInfo[3][sbPayComp] = 10000;
				SBizzInfo[4][sbPayComp] = 11000;
				SBizzInfo[5][sbPayComp] = 12000;
				SBizzInfo[6][sbPayComp] = 10000;
				SBizzInfo[7][sbPayComp] = 10000;
				SBizzInfo[8][sbPayComp] = 10000;
				SBizzInfo[9][sbPayComp] = 10000;
				SBizzInfo[10][sbPayComp] = 10000;

				BizzInfo[0][bPayComp] = 12000;
				BizzInfo[1][bPayComp] = 10000;
				BizzInfo[2][bPayComp] = 11000;
				BizzInfo[3][bPayComp] = 10000;
				BizzInfo[4][bPayComp] = 12000;
				BizzInfo[5][bPayComp] = 12000;
				BizzInfo[6][bPayComp] = 10000;
				BizzInfo[7][bPayComp] = 11000;
				BizzInfo[8][bPayComp] = 10000;
				BizzInfo[9][bPayComp] = 12000;
				BizzInfo[10][bPayComp] = 10000;
				BizzInfo[11][bPayComp] = 10020;
				BizzInfo[12][bPayComp] = 10010;
			/*
				SBizzInfo[0][sbProd] = 50;SBizzInfo[0][sbProdCap] = 500;SBizzInfo[0][sbComp] = 2;SBizzInfo[0][sbCompCap] = 10;SBizzInfo[0][sbProdCost] = 10;SBizzInfo[0][sbPayComp] = 10000;
				SBizzInfo[1][sbProd] = 50;SBizzInfo[1][sbProdCap] = 500;SBizzInfo[1][sbComp] = 4;SBizzInfo[1][sbCompCap] = 16;SBizzInfo[1][sbProdCost] = 4;SBizzInfo[1][sbPayComp] = 11000;
				SBizzInfo[2][sbProd] = 50;SBizzInfo[2][sbProdCap] = 240;SBizzInfo[2][sbComp] = 5;SBizzInfo[2][sbCompCap] = 20;SBizzInfo[2][sbProdCost] = 2;SBizzInfo[2][sbPayComp] = 12000;
				SBizzInfo[3][sbProd] = 50;SBizzInfo[3][sbProdCap] = 500;SBizzInfo[3][sbComp] = 3;SBizzInfo[3][sbCompCap] = 10;SBizzInfo[3][sbProdCost] = 7;SBizzInfo[3][sbPayComp] = 10000;
				SBizzInfo[4][sbProd] = 50;SBizzInfo[4][sbProdCap] = 500;SBizzInfo[4][sbComp] = 6;SBizzInfo[4][sbCompCap] = 10;SBizzInfo[4][sbProdCost] = 10;SBizzInfo[4][sbPayComp] = 11000;
				SBizzInfo[5][sbProd] = 50;SBizzInfo[5][sbProdCap] = 100;SBizzInfo[5][sbComp] = 4;SBizzInfo[5][sbCompCap] = 20;SBizzInfo[5][sbProdCost] = 1;SBizzInfo[5][sbPayComp] = 12000;
				SBizzInfo[6][sbProd] = 50;SBizzInfo[6][sbProdCap] = 100;SBizzInfo[6][sbComp] = 5;SBizzInfo[6][sbCompCap] = 20;SBizzInfo[6][sbProdCost] = 1;SBizzInfo[6][sbPayComp] = 10000;

				BizzInfo[0][bProd] = 50;BizzInfo[0][bProdCap] = 500;BizzInfo[0][bComp] = 6;BizzInfo[0][bCompCap] = 18;BizzInfo[0][bProdCost] = 2;BizzInfo[0][bPayComp] = 12000;
				BizzInfo[1][bProd] = 50;BizzInfo[1][bProdCap] = 500;BizzInfo[1][bComp] = 4;BizzInfo[1][bCompCap] = 10;BizzInfo[1][bProdCost] = 3;BizzInfo[1][bPayComp] = 10000;
				BizzInfo[2][bProd] = 50;BizzInfo[2][bProdCap] = 500;BizzInfo[2][bComp] = 5;BizzInfo[2][bCompCap] = 10;BizzInfo[2][bProdCost] = 4;BizzInfo[2][bPayComp] = 11000;
				BizzInfo[3][bProd] = 50;BizzInfo[3][bProdCap] = 500;BizzInfo[3][bComp] = 3;BizzInfo[3][bCompCap] = 10;BizzInfo[3][bProdCost] = 5;BizzInfo[3][bPayComp] = 10000;
				BizzInfo[4][bProd] = 50;BizzInfo[4][bProdCap] = 100;BizzInfo[4][bComp] = 6;BizzInfo[4][bCompCap] = 0;BizzInfo[4][bProdCost] = 0;BizzInfo[4][bPayComp] = 12000;
				BizzInfo[5][bProd] = 50;BizzInfo[5][bProdCap] = 100;BizzInfo[5][bComp] = 5;BizzInfo[5][bCompCap] = 0;BizzInfo[5][bProdCost] = 0;BizzInfo[5][bPayComp] = 12000;
				BizzInfo[6][bProd] = 50;BizzInfo[6][bProdCap] = 220;BizzInfo[6][bComp] = 4;BizzInfo[6][bCompCap] = 10;BizzInfo[6][bProdCost] = 10;BizzInfo[6][bPayComp] = 10000;
				BizzInfo[7][bProd] = 50;BizzInfo[7][bProdCap] = 100;BizzInfo[7][bComp] = 3;BizzInfo[7][bCompCap] = 0;BizzInfo[7][bProdCost] = 0;BizzInfo[7][bPayComp] = 11000;
				BizzInfo[8][bProd] = 50;BizzInfo[8][bProdCap] = 100;BizzInfo[8][bComp] = 6;BizzInfo[8][bCompCap] = 20;BizzInfo[8][bProdCost] = 1;BizzInfo[8][bPayComp] = 10000;
				BizzInfo[9][bProd] = 50;BizzInfo[9][bProdCap] = 100;BizzInfo[9][bComp] = 4;BizzInfo[9][bCompCap] = 20;BizzInfo[9][bProdCost] = 1;BizzInfo[9][bPayComp] = 12000;
				BizzInfo[10][bProd] = 50;BizzInfo[10][bProdCap] = 100;BizzInfo[10][bComp] = 3;BizzInfo[10][bCompCap] = 20;BizzInfo[10][bProdCost] = 1;BizzInfo[10][bPayComp] = 10000;
				BizzInfo[11][bProd] = 50;BizzInfo[11][bProdCap] = 500;BizzInfo[11][bComp] = 4;BizzInfo[11][bCompCap] = 10;BizzInfo[11][bProdCost] = 3;BizzInfo[11][bPayComp] = 10020;
				BizzInfo[12][bProd] = 50;BizzInfo[12][bProdCap] = 500;BizzInfo[12][bComp] = 5;BizzInfo[12][bCompCap] = 10;BizzInfo[12][bProdCost] = 4;BizzInfo[12][bPayComp] = 10010;

				BizzInfo[4][bProd] = 50;BizzInfo[4][bProdCap] = 100;BizzInfo[4][bComp] = 6;BizzInfo[4][bCompCap] = 10;BizzInfo[4][bProdCost] = 5;BizzInfo[4][bPayComp] = 12000;
				BizzInfo[5][bProd] = 50;BizzInfo[5][bProdCap] = 100;BizzInfo[5][bComp] = 5;BizzInfo[5][bCompCap] = 10;BizzInfo[5][bProdCost] = 5;BizzInfo[5][bPayComp] = 12000;
				BizzInfo[7][bProd] = 50;BizzInfo[7][bProdCap] = 100;BizzInfo[7][bComp] = 3;BizzInfo[7][bCompCap] = 10;BizzInfo[7][bProdCost] = 5;BizzInfo[7][bPayComp] = 11000;

				BizzInfo[0][bPriceMod] = 100;BizzInfo[1][bPriceMod] = 100;BizzInfo[2][bPriceMod] = 100;
				BizzInfo[3][bPriceMod] = 100;BizzInfo[4][bPriceMod] = 100;BizzInfo[5][bPriceMod] = 100;
				BizzInfo[6][bPriceMod] = 100;BizzInfo[7][bPriceMod] = 100;BizzInfo[8][bPriceMod] = 100;
				BizzInfo[9][bPriceMod] = 100;BizzInfo[10][bPriceMod] = 100;BizzInfo[11][bPriceMod] = 100;BizzInfo[12][bPriceMod] = 100;
				*/
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
		}
		return 1;
	}
//----------------------------------[TEST]-----------------------------------------------
	if(strcmp(cmd, "/testcam", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
					new Float:plx,Float:ply,Float:plz;
					new Float:clx,Float:cly,Float:clz;
					GetPlayerPos(playerid, plx, ply, plz);
					clx = plx;
					cly = ply+2;
					clz = plz+0.2;
					plz = plz+0.6;
					SetPlayerFacingAngle(playerid, 0.0);
					SetPlayerCameraPos(playerid,clx, cly, clz);
					SetPlayerCameraLookAt(playerid,plx, ply, plz);
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/prop", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			LoadProperty();
			LoadBizz();
			LoadSBizz();
			SendClientMessageRus(playerid, COLOR_GRAD1, "Настройки загружены");
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/tmppos", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			LoadTmp();
			SendClientMessageRus(playerid, COLOR_GRAD1, "TmpPos Reloaded");
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
		}
		return 1;
	}
//----------------------------------[UNCON]-----------------------------------------------

	if(strcmp(cmd, "/uncon", true) == 0)
	{

		SetCamBack(playerid);
		return 1;
	}

//----------------------------------[AdminChat]-----------------------------------------------
	if(strcmp(cmd, "/admin", true) == 0 || strcmp(cmd, "/a", true) == 0)
	{
		GetPlayerName(playerid, sendername, sizeof(sendername));
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: (/a)dmin [admin chat]");
			return 1;
		}
		format(string, sizeof(string), "%d админ %s: %s", PlayerInfo[playerid][pAdmin], sendername, result);
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendAdminMessage(COLOR_YELLOW, string);
		}
		printf("Admin %s: %s", sendername, result);
		return 1;
	}
//-------------------------------[Logout]--------------------------------------------------------------------------
	if (strcmp(cmd, "/logout", true) ==0 )
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			PlayerUpdate(playerid);
			gPlayerLogged[playerid] = 0;
			SendClientMessageRus(playerid, COLOR_GRAD1, "Теперь можете выходить.");
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
		}
	}
	if (strcmp(cmd, "/logoutpl", true) ==0 )
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /logoutpl [playerid/PartOfName]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, 0xAAAAAAAA, "Неправильный ID");
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			PlayerUpdate(giveplayerid);
			gPlayerLogged[giveplayerid] = 0;
			SendClientMessageRus(playerid, COLOR_GRAD1, "Игрок деавторизован.");
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
		}
	}
//-------------------------------[Logoutall]--------------------------------------------------------------------------
	if (strcmp(cmd, "/logoutall", true) ==0 )
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) == 1)
				{
					PlayerUpdate(i);
					gPlayerLogged[i] = 0;
				}
			}
			SendClientMessageRus(playerid, COLOR_GRAD1, "Все игроки деавторизованы.");
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
		}
	}
//--------------------------------------------------------------------------------------
//----------------------------------[cnn]-----------------------------------------------
	if(strcmp(cmd, "/cnn", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			GetPlayerName(playerid, sendername, sizeof(sendername));
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /cnn [cnn textformat ~n~=Newline ~r~=Red ~g~=Green ~b~=Blue ~w~=White ~y~=Yellow]");
				return 1;
			}
			format(string, sizeof(string), "~b~%s: ~w~%s",sendername,result);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) == 1)
				{
					GameTextForPlayerRus(i, string, 5000, 6);
				}
			}
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
		}
	}
	if(strcmp(cmd, "/cnnn", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			tmp = strtok(cmdtext, idx);
			new txtid;
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /cnnn <type> ");
				return 1;
			}
			txtid = strval(tmp);
			if(txtid == 2)
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "Нельзя выбрать 2 тип");
				return 1;
			}
			new length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			new offset = idx;
			new result[64];
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /cnnn <type> [cnnc textformat ~n~=Newline ~r~=Red ~g~=Green ~b~=Blue ~w~=White ~y~=Yellow]");
				return 1;
			}
			format(string, sizeof(string), "~w~%s",result);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) == 1)
				{
					GameTextForPlayerRus(i, string, 5000, txtid);
				}
			}
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
		}
	}
//[ADMIN]______________________________________________________________________________
//-----------------------------------[JAIL]-------------------------------------------------------------------------
	if(strcmp(cmd, "/ajail", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /ajail [playerid/PartOfName] [seconds]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
			//printf("stringnameid %d",giveplayerid);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /ajail [playerid/PartOfName] [seconds]");
			return 1;
		}
		new time = strval(tmp);

		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				SetPlayerInterior(giveplayerid,6);
				PlayerInfo[giveplayerid][pInt] = 6;
                SetPlayerPos(giveplayerid,264.395200,77.564040,1001.039000);
				format(string, sizeof(string), "Вы отправили %s(ID: %d) в тюрьму.", giveplayer,giveplayerid);
				//printf("AdmCmd: %s has jailed %s.", sendername, giveplayer);
				SendClientMessageRus(playerid, COLOR_GRAD1, string);
				SendClientMessageRus(giveplayerid, COLOR_GRAD1,"Вы были позажены за нарушение правил сервера.");
				PlayJailSound(1153 , 1154, 2000,264.395200, 77.564040, 1001.039000);
				JailTime[giveplayerid] = time+10;
				//TogglePlayerControllable(giveplayerid, 0);
				return 1;
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
				return 1;
			}
		}
		else
		{
			format(string, sizeof(string), "%d не активный игрок.", giveplayerid);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		return 1;
	}
	if(strcmp(cmd, "/jail", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /jail");
			return 1;
		}
		giveplayerid = strval(tmp);
		if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, 0xAAAAAAAA, "Неправильный ID");
		if(JailTime[giveplayerid] > 0 || gTeam[giveplayerid] != 4)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Этот игрок не может быть посажен сейчас.");
			printf("JailTime[giveplayerid](%d) gTeam[giveplayerid](%d)",JailTime[giveplayerid],gTeam[giveplayerid]);
			return 1;
		}
		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if (gTeam[playerid] == TEAM_BLUE)
			{
				if (TestDistance(playerid,giveplayerid,264.395200,77.564040,1001.039000,7))
				{
					//print("DEBUG Distancetested");
					new slice = ((PlayerInfo[giveplayerid][pLevel]*deathcost)+(1000)); //1k +your level
					SetPlayerPos(giveplayerid,264.395200,77.564040,1001.039000);
					SafeGivePlayerMoney(playerid, slice);
					SafeGivePlayerMoney(giveplayerid, -slice);
					PlayJailSound(1165 , 1166, 2000,264.395200, 77.564040, 1001.039000);
					format(string, sizeof(string), "~r~Suspect ~w~Detained~n~You Get ~g~$%d", slice);
					GameTextForPlayerRus(playerid, string, 5000, 1);
					format(string, sizeof(string), "~r~JAIL~n~~w~You Are fined ~n~~r~$%d", -slice);
					GameTextForPlayerRus(giveplayerid, string, 5000, 1);
					PlayerPlayMusic(playerid);
					JailTime[giveplayerid] = jailtime;
					SetPlayerFree(giveplayerid,playerid,"Отсидел свой срок",0,0);
					if(FlashTime[giveplayerid] == 0){FlashTime[giveplayerid] = 10;}
					//TogglePlayerControllable(giveplayerid, 0);
					return 1;
				}
				else
				{
					SendClientMessageRus(playerid, COLOR_GRAD1, "Один из вас слишком далеко от тюремной камеры!");
					return 1;
				}
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
				return 1;
			}
		}
		else
		{
			format(string, sizeof(string), "%d не активный игрок.", giveplayerid);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		return 1;
	}
//----------------------------------[UNJAIL]-----------------------------------------------
	if(strcmp(cmd, "/unjail", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /unjail [playerid/PartOfName]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				SetPlayerInterior(giveplayerid,6);
				PlayerInfo[playerid][pInt] = 6;
                SetPlayerPos(giveplayerid,268.3,77.4,1001.0);
				format(string, sizeof(string), "Вы освободили %s(ID: %d) из тюрьмы.", giveplayer,giveplayerid);
				//printf("AdmCmd: %s has jailed %s.", sendername, giveplayer);
				SendClientMessageRus(playerid, COLOR_GRAD1, string);
				SetPlayerWeapons(playerid);
				SendClientMessageRus(giveplayerid, COLOR_GRAD1,"Ты заплатил свой долг обществу.");
				PlayJailSound(1165 , 1166, 2000,264.395200, 77.564040, 1001.039000);
				JailTime[giveplayerid] = 10;
				//TogglePlayerControllable(giveplayerid, 0);
				return 1;
			}
			/*
			else if (gTeam[playerid] == TEAM_BLUE)
			{
				if (TestDistance(playerid,giveplayerid,264.395200,77.564040,1001.039000,7))
				{
					SetPlayerPos(giveplayerid,268.3,77.4,1001.0);
					format(string, sizeof(string), "You have released %s(player: %d) from jail.", giveplayer,giveplayerid);
					//printf("AdmCmd: %s has jailed %s.", sendername, giveplayer);
					SendClientMessageRus(playerid, COLOR_GRAD1, string);
					SetPlayerWeapons(playerid);
					SendClientMessageRus(giveplayerid, COLOR_GRAD1,"You have paid your debt to society.");
					PlayJailSound(1165 , 1166, 1000,264.395200, 77.564040, 1001.039000);
					//TogglePlayerControllable(giveplayerid, 0);
					return 1;
				}
				else
				{
					SendClientMessageRus(playerid, COLOR_GRAD1, "one of you is to far away from a jail cell!");
					return 1;
				}
			}
			*/
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для этой команды!");
				return 1;
			}
		}
		else
		{
			format(string, sizeof(string), "%d не активный игрок.", giveplayerid);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		return 1;
	}
//----------------------------------[TOD]-----------------------------------------------

	if(strcmp(cmd, "/tod", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /tod [timeofday] (0-23)");
			return 1;
		}
		new hour;
		hour = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
            SetWorldTime(hour);
			format(string, sizeof(string), "Время установлено на %d часов.", hour);
			BroadCast(COLOR_GRAD1, string);
		}
		/*
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "you are not authorized to use that command!");
		}
		*/
		return 1;
	}
//-----------------------------------editstat---------------------------------------
	if(strcmp(cmd, "/setstat", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /setstat [playerid/PartOfName] [statcode] [amount]");
			SendClientMessageRus(playerid, COLOR_GRAD4, "|1 Уровень |2 Здоровье |3 Апгрейды |4 Модель ");
			SendClientMessageRus(playerid, COLOR_GRAD3, "|5 Банк |6 Телефон |7 Опыт ");
			SendClientMessageRus(playerid, COLOR_GRAD2, "|8 Дом |9 Бизнес |10 Кейсы |11 HW |12 Гонки |13 WA |14 ВНН1");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, 0xAAAAAAAA, "Неправильный ID");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /setstat [playerid/PartOfName] [statcode] [amount]");
			SendClientMessageRus(playerid, COLOR_GRAD4, "|1 Уровень |2 Здоровье |3 Апгрейды");
			SendClientMessageRus(playerid, COLOR_GRAD3, "|4 Модель |5 Банк |6 Телефон");
			SendClientMessageRus(playerid, COLOR_GRAD2, "|7 Опыт |8 Дом |9 Бизнес");
			return 1;
		}
		new stat;
		stat = strval(tmp);
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /setstat [playerid/PartOfName] [statcode] [amount]");
			SendClientMessageRus(playerid, COLOR_GRAD4, "|1 Уровень |2 Здоровье |3 Апгрейды");
			SendClientMessageRus(playerid, COLOR_GRAD3, "|4 Модель |5 Банк |6 Телефон");
			SendClientMessageRus(playerid, COLOR_GRAD2, "|7 Опыт |8 Дом |9 Бизнес");
			return 1;
		}
		new amount;
		amount = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			switch (stat)
			{
				case 1:
				{
					PlayerInfo[giveplayerid][pLevel] = amount;
					format(string, sizeof(string), "Уровень игрока изменен на %d", amount);
				}
				case 2:
				{
					PlayerInfo[giveplayerid][pSHealth] = amount;
					format(string, sizeof(string), "Уровень здоровья игрока при респауне изменен на %d ", amount);
				}
				case 3:
				{
					PlayerInfo[giveplayerid][gPupgrade] = amount;
					format(string, sizeof(string), "Количество неиспользованных апгрейдов игрока изменено на %d", amount);
				}
				case 4:
				{
					PlayerInfo[giveplayerid][pModel] = amount;
					format(string, sizeof(string), "Модель игрока изменена на %d", amount);
				}
				case 5:
				{
					PlayerInfo[giveplayerid][pAccount] = amount;
					format(string, sizeof(string), "Сумма в банке игрока изменена на $%d", amount);
				}
				case 6:
				{
					PlayerInfo[giveplayerid][pPnumber] = amount;
					format(string, sizeof(string), "Телефонный номер игрока изменен на %d", amount);
				}
				case 7:
				{
					PlayerInfo[giveplayerid][pExp] = amount;
					format(string, sizeof(string), "Опыт игрока изменен на %d", amount);
				}
				case 8:
				{
					PlayerInfo[giveplayerid][pPhousekey] = amount;
					format(string, sizeof(string), "Игроку выдан ключ от %d дома", amount);
				}
				case 9:
				{
					PlayerInfo[giveplayerid][pPbiskey] = amount;
					format(string, sizeof(string), "Игроку быдан ключ от %d бизнеса", amount);
				}
				case 10:
				{
					PlayerInfo[giveplayerid][pCB] = amount;
					format(string, sizeof(string), "Количество кейсов игрока изменено на %d", amount);
				}
				case 11:
				{
					PlayerInfo[giveplayerid][pHW] = amount;
					format(string, sizeof(string), "The Player Business Key Was Set To %d", amount);
				}
				case 12:
				{
					PlayerInfo[giveplayerid][pSR] = amount;
					format(string, sizeof(string), "Количество гонок игрока изменено на %d", amount);
				}
				case 13:
				{
					PlayerInfo[giveplayerid][pWA] = amount;
					format(string, sizeof(string), "The Player Business Key Was Set To %d", amount);
				}
				case 14:
				{
					PlayerInfo[giveplayerid][pPEN] = amount;
					format(string, sizeof(string), "Количество убийств ВНН1 игрока изменено на %d", amount);
				}
				default:
				{
					format(string, sizeof(string), "Неправильный номер стата", amount);
				}

			}
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[SETINT]-----------------------------------------------
	if(strcmp(cmd, "/setint", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /setint [interiorid]");
			return 1;
		}
		new intid;
		intid = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SetPlayerInterior(playerid,intid);
			PlayerInfo[playerid][pInt] = intid;
			format(string, sizeof(string), "interiorid %d.", intid);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[SKYDIVE]------------------------------------------------
	if(strcmp(cmd, "/skydive", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 2)
		{
			GetPlayerPos(playerid, rx, ry, rz);
			if (IsPlayerConnected(playerid))
			{
				GivePlayerWeapon(playerid, 46, 0);
				SetPlayerPos(playerid,rx, ry, rz+1500);
				SendClientMessageRus(playerid, COLOR_WHITE, "GO!! GO!! GO!!");
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[FOURDIVE]------------------------------------------------
	if(strcmp(cmd, "/fourdive", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /fourdive [playerid1] [playerid2] [playerid3] [playerid4]");
			return 1;
		}
		new para1;
		new para2;
		new para3;
		new para4;
		para1 = strval(tmp);
		tmp = strtok(cmdtext, idx);
		para2 = strval(tmp);
		tmp = strtok(cmdtext, idx);
		para3 = strval(tmp);
		tmp = strtok(cmdtext, idx);
		para4 = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			if (IsPlayerConnected(para1)){ GivePlayerWeapon(para1, 46, 0); SetPlayerPos(para1,1536.0, -1360.0, 1350.0);SetPlayerInterior(para1,0);PlayerInfo[para1][pInt] = 0;SendClientMessageRus(para1, COLOR_WHITE, "GO!! GO!! GO!!");}
			if ((IsPlayerConnected(para2)) && (para2>0)) { GivePlayerWeapon(para2, 46, 0); SetPlayerPos(para2,1536.0, -1345.0, 1350.0);SetPlayerInterior(para2,0);PlayerInfo[para2][pInt] = 0;SendClientMessageRus(para2, COLOR_RED, "GO!! GO!! GO!!");}
			if ((IsPlayerConnected(para3)) && (para3>0)) { GivePlayerWeapon(para3, 46, 0); SetPlayerPos(para3,1552.0, -1345.0, 1350.0);SetPlayerInterior(para3,0);PlayerInfo[para3][pInt] = 0;SendClientMessageRus(para3, COLOR_RED, "GO!! GO!! GO!!");}
			if ((IsPlayerConnected(para4)) && (para4>0)) { GivePlayerWeapon(para4, 46, 0); SetPlayerPos(para4,1552.0, -1360.0, 1350.0);SetPlayerInterior(para4,0);PlayerInfo[para4][pInt] = 0;SendClientMessageRus(para4, COLOR_RED, "GO!! GO!! GO!!");}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[MAKEADMIN]------------------------------------------------
	if(strcmp(cmd, "/makeadmin", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /makeadmin [playerid/PartOfName] [level(1-3)]");
			return 1;
		}
		new para1;
		new level;
		if(IsStringAName(tmp))
		{
			para1 = GetPlayerID(tmp);
		}
		else
		{
			para1 = strval(tmp);
		}
		tmp = strtok(cmdtext, idx);
		level = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 1337 || (IsPlayerAdmin(playerid) && rconmakeadmin))
		{
			GetPlayerName(para1, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			PlayerInfo[para1][pAdmin] = level;
			printf("AdmCmd: %s назначил %s администратором %d уровня.", sendername, giveplayer, level);
			format(string, sizeof(string), "Вы были назначены администратором %d уровня админом %s", level, sendername);
			SendClientMessageRus(para1, COLOR_GRAD1, string);
			format(string, sizeof(string), "Вы назначили %s админом %d уровня.", giveplayer,level);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[MAKEADMIN]------------------------------------------------
	if(strcmp(cmd, "/makeraceman", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /makeraceman [playerid/PartOfName] [on 1 off 0)]");
			return 1;
		}
		new para1;
		new level;
		if(IsStringAName(tmp))
		{
			para1 = GetPlayerID(tmp);
		}
		else
		{
			para1 = strval(tmp);
		}
		tmp = strtok(cmdtext, idx);
		level = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			GetPlayerName(para1, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			gRaceGuy[para1] = level;
			printf("AdmCmd: %s has promoted %s to Race Creator.", sendername, giveplayer, level);
			format(string, sizeof(string), "Вы были сделаны создателем гонок админом %s", sendername);
			SendClientMessageRus(para1, COLOR_GRAD1, string);
			SendClientMessageRus(para1, COLOR_WHITE, "ПОДСКАЗКА: Теперь вы можете ввести /help чтобы посмотреть новые команды.");
			format(string, sizeof(string), "You have promoted %s to Race Creator.", giveplayer);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);

		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[setteam]------------------------------------------------
	if(strcmp(cmd, "/setteam", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /setteam [playerid/PartOfName] [team 1(civ) - 2(cop)]");
			return 1;
		}
		new para1;
		new level;
		if(IsStringAName(tmp))
		{
			para1 = GetPlayerID(tmp);
		}
		else
		{
			para1 = strval(tmp);
		}
		tmp = strtok(cmdtext, idx);
		level = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 2)
		{
			GetPlayerName(para1, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			PlayerInfo[para1][pTeam] = level;
			//PlayerUpdate(para1);
			gTeam[para1] = level;
			SetPlayerWeapons(para1);
			SetPlayerRandomSpawn(para1);
			//gPlayerSpawned[para1] = 0;
			//OnPlayerSpawn(para1);
			ClearCrime(para1);
			if (gPublicEnemy == para1)
			{
				gPublicEnemy = -1;
				KillTimer(offhook);
	    	}
			printf("AdmCmd: %s has switched %s to team %d.", sendername, giveplayer, level);
			format(string, sizeof(string), "Вы были перекинуты в команду %d админом %s", level, sendername);
			SendClientMessageRus(para1, COLOR_GRAD1, string);
			format(string, sizeof(string), "Вы перекинули %s в команду %d.", giveplayer,level);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/jointeam", true) == 0)
	{
        new sbiz;
		if (IsPlayerInRangeOfPoint(playerid, 3,SBizzInfo[11][sbEntrancex], SBizzInfo[11][sbEntrancey], SBizzInfo[11][sbEntrancez]))
		{
			sbiz = 11;
		}
		else if (IsPlayerInRangeOfPoint(playerid, 3,SBizzInfo[12][sbEntrancex], SBizzInfo[12][sbEntrancey], SBizzInfo[12][sbEntrancez]))
		{
			sbiz = 12;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы слишком далеко от нужного бизнеса");
			return 1;
		}
		if(GetPlayerMoney(playerid) < SBizzInfo[sbiz][sbEntcost])
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "У вас недостаточно денег");
			return 1;
		}
		if(SBizzInfo[sbiz][sbLock] == 1)
		{
			GameTextForPlayerRus(playerid, "~r~Closed", 5000, 1);
			return 1;
		}
		if(SBizzInfo[sbiz][sbProd] == 0)
		{
			GameTextForPlayerRus(playerid, "~r~Out Of Stock", 5000, 1);
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /jointeam [team 1(medic) - 2(cop)]");
			return 1;
		}
		new level = strval(tmp);
		if (level > 0 && level < 12)
		{
			if (gPublicEnemy == playerid)
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "Враг народа не может менять команду");
				return 1;
	    	}
			GetPlayerName(playerid, sendername, sizeof(sendername));
			PlayerInfo[playerid][pTeam] = level;
			gTeam[playerid] = level;
			ClearCrime(playerid);
			SetPlayerToTeamColor(playerid);
			format(string, sizeof(string), "%s, вы перешли в команду %d", sendername, level);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
			SafeGivePlayerMoney(playerid,-SBizzInfo[sbiz][sbEntcost]);
			SBizzInfo[sbiz][sbProd]--;
			SBizzInfo[sbiz][sbTakings] = SBizzInfo[sbiz][sbTakings]+SBizzInfo[sbiz][sbEntcost];
			new dood[MAX_PLAYER_NAME];
			GetPlayerName(playerid, dood, sizeof(dood));
			format(string, sizeof(string), "%s payed $%d to enter sbiz %d", dood, SBizzInfo[sbiz][sbEntcost], sbiz);
			printf("%s", string);
			PayLog(string);
			OnPropUpdate();
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Нет команды с таким номером");
		}
		return 1;
	}
//----------------------------------[GOTO]-----------------------------------------------
	if(strcmp(cmd, "/gotols", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1529.6,-1691.2,13.3);
				TelePos[playerid][0] = 0.0;TelePos[playerid][1] = 0.0;
			}
			else
			{
				SetPlayerPos(playerid, 1529.6,-1691.2,13.3);
			}
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы были телепортированы");
			SetPlayerInterior(playerid,0);
			PlayerInfo[playerid][pInt] = 0;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/gotolv", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1699.2, 1435.1, 10.7);
				TelePos[playerid][0] = 0.0;TelePos[playerid][1] = 0.0;
			}
			else
			{
				SetPlayerPos(playerid, 1699.2,1435.1, 10.7);
			}
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы были телепортированы");
			SetPlayerInterior(playerid,0);
			PlayerInfo[playerid][pInt] = 0;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/gotosf", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, -1417.0,-295.8,14.1);
				TelePos[playerid][0] = 0.0;TelePos[playerid][1] = 0.0;
			}
			else
			{
				SetPlayerPos(playerid, -1417.0,-295.8,14.1);
			}
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы были телепортированы");
			SetPlayerInterior(playerid,0);
			PlayerInfo[playerid][pInt] = 0;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/entercar", true) == 0)
    {
        if(IsPlayerConnected(playerid))
        {
            if (PlayerInfo[playerid][pAdmin] >= 2)
            {
                tmp = strtok(cmdtext, idx);
                if(!strlen(tmp))
                {
                    SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /entercar [ID машины] [позиция]");
                    return 1;
                }
                new playa;
                new health;
                playa = strval(tmp);
                tmp = strtok(cmdtext, idx);
                health = strval(tmp);
                PutPlayerInVehicle(playerid, playa, health);
            }
            else
            {
                SendClientMessageRus(playerid, COLOR_GRAD1, " Вы не можете использовать эту команду");
            }
        }
        return 1;
    }
	if ((strcmp("/putinveh", cmd, true) == 0)||(strcmp("/piv", cmd, true) == 0))
	{
		if(IsPlayerConnected(playerid))
		{
			if(PlayerInfo[playerid][pAdmin] > 2)
			{
				new pid[4];
				strmid(pid, strtok(cmdtext, idx), 0, sizeof(pid));
				new cid[4];
				strmid(cid, strtok(cmdtext, idx), 0, sizeof(cid));
				new sid[4];
				strmid(sid, strtok(cmdtext, idx), 0, sizeof(sid));
				if(!strlen(pid)||!strlen(cid)||!strlen(sid))
				{
					SendClientMessageRus(playerid, C_TIP, " ИСПОЛЬЗОВАНИЕ: /putinveh [player] [car] [seat]");
					return 1;
				}
				if(GetVehicleModel(strval(cid)) != 0)
				{
					if(IsPlayerConnected(strval(pid)))
					{
						PutPlayerInVehicle(strval(pid), strval(cid), strval(sid));
						SetCameraBehindPlayer(strval(pid));
						SendClientMessageRus(playerid, C_EVENT, " Игрок помещен в машину!");
						SendClientMessageRus(strval(pid), C_EVENT, " Вы помещены в машину администратором!");
					}
					else
					{
						SendClientMessageRus(playerid, C_WARNING, " Игрока с таким id нет на сервере!");
					}
				}
				else
				{
					SendClientMessageRus(playerid, C_WARNING, " Нет ТС с таким id!");
				}
			}
			else
			{
				SendClientMessageRus(playerid, C_WARNING, " Вы не админ!");
			}
		}
		return 1;
	}
	if(strcmp(cmd, "/gotocar", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /gotocar [carid]");
			return 1;
		}
		new testcar = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			new Float:cwx2,Float:cwy2,Float:cwz2;
			GetVehiclePos(testcar, cwx2, cwy2, cwz2);
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, cwx2, cwy2, cwz2);
				TelePos[playerid][0] = 0.0;TelePos[playerid][1] = 0.0;
			}
			else
			{
				SetPlayerPos(playerid, cwx2, cwy2, cwz2);
			}
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы были телепортированы");
			SetPlayerInterior(playerid,0);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/mark", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			GetPlayerPos(playerid, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
			SendClientMessageRus(playerid, COLOR_GRAD1, "Маркер для телепортации установлен");
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/gotomark", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
				TelePos[playerid][0] = 0.0;TelePos[playerid][1] = 0.0;
			}
			else
			{
				SetPlayerPos(playerid, TeleportDest[playerid][0],TeleportDest[playerid][1],TeleportDest[playerid][2]);
			}
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы были телепортированы");
			SetPlayerInterior(playerid,0);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/gotoin", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1416.107000,0.268620,1000.926000);
			}
			else
			{
				SetPlayerPos(playerid, 1416.107000,0.268620,1000.926000);
			}
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы были телепортированы");
			SetPlayerInterior(playerid,1);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/gotostad", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, -1435.75, -652.664, 1054.94);
			}
			else
			{
				SetPlayerPos(playerid, -1435.75, -652.664, 1054.94);
			}
			SetPlayerInterior(playerid,4);
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы были телепортированы");
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/gotojet", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar, 1.71875, 30.4062, 1200.34);
			}
			else
			{
				SetPlayerPos(playerid, 1.71875, 30.4062, 1200.34);
			}
			SetPlayerInterior(playerid,1);
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы были телепортированы");
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/goto", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /goto [playerid/PartOfName]");
			return 1;
		}
		new Float:plocx,Float:plocy,Float:plocz;
		new plo;
		if(IsStringAName(tmp))
		{
			plo = GetPlayerID(tmp);
		}
		else
		{
			plo = strval(tmp);
		}
		if (IsPlayerConnected(plo))
		{
			if (PlayerInfo[playerid][pAdmin] >= 1)
			{
				GetPlayerPos(plo, plocx, plocy, plocz);
				if(PlayerInfo[plo][pInt] > 0)
				{
					SetPlayerInterior(playerid,PlayerInfo[plo][pInt]);
					PlayerInfo[playerid][pInt] = PlayerInfo[plo][pInt];
					PlayerInfo[playerid][pLocal] = PlayerInfo[plo][pLocal];
				}
				if(PlayerInfo[playerid][pInt] == 0)
				{
					SetPlayerInterior(playerid,0);
				}
				if(plocz > 530.0 && PlayerInfo[plo][pInt] == 0) //the highest land point in sa = 526.8
				{
					SetPlayerInterior(playerid,1);
					PlayerInfo[playerid][pInt] = 1;
				}
				if (GetPlayerState(playerid) == 2)
				{
					new tmpcar = GetPlayerVehicleID(playerid);
					SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
					TelePos[playerid][0] = 0.0;TelePos[playerid][1] = 0.0;
				}
				else
				{
					SetPlayerPos(playerid,plocx,plocy+2, plocz);
				}
				SendClientMessageRus(playerid, COLOR_GRAD1, "Вы были телепортированы");
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
			}
		}
		else
		{
			format(string, sizeof(string), "%d не активный игрок.", plo);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		return 1;
	}
	if(strcmp(cmd, "/gotop", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /gotop [posid]");
			return 1;
		}
		new tmppo;
		tmppo = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			if (GetPlayerState(playerid) == 2)
			{
				new tmpcar = GetPlayerVehicleID(playerid);
				SetVehiclePos(tmpcar,Teletmp[tmppo][pTmpposx], Teletmp[tmppo][pTmpposy], Teletmp[tmppo][pTmpposz]);
				TelePos[playerid][0] = 0.0;TelePos[playerid][1] = 0.0;
			}
			else
			{
				SetPlayerPos(playerid,Teletmp[tmppo][pTmpposx], Teletmp[tmppo][pTmpposy], Teletmp[tmppo][pTmpposz]);
			}
			PlayerInfo[playerid][pInt] = Teletmp[tmppo][pTmpint];
			SetPlayerInterior(playerid,Teletmp[tmppo][pTmpint]);
			format(string, sizeof(string), "TmpPos Location: %d",tmppo);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[GETHERE]-----------------------------------------------
	if(strcmp(cmd, "/gethere", true) == 0)
	{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /gethere [playerid/PartOfName]");
				return 1;
			}
			new Float:plocx,Float:plocy,Float:plocz;
			new plo;
			if(IsStringAName(tmp))
			{
				plo = GetPlayerID(tmp);
			}
			else
			{
				plo = strval(tmp);
			}
			if (IsPlayerConnected(plo))
			{
				if ((IsPlayerAdmin(plo)) || PlayerInfo[plo][pAdmin] > 1337)
				{
					SendClientMessageRus(playerid, COLOR_GRAD1, "Попросите админа телепортироваться к вам.");
					return 1;
				}
				if (PlayerInfo[playerid][pAdmin] >= 3)
				{
					GetPlayerPos(playerid, plocx, plocy, plocz);
					if(PlayerInfo[playerid][pInt] > 0)
					{
						SetPlayerInterior(plo,PlayerInfo[playerid][pInt]);
						PlayerInfo[plo][pInt] = PlayerInfo[playerid][pInt];
						PlayerInfo[plo][pLocal] = PlayerInfo[playerid][pLocal];
					}
					if(PlayerInfo[playerid][pInt] == 0)
					{
						SetPlayerInterior(plo,0);
					}
					if(plocz > 930.0 && PlayerInfo[playerid][pInt] == 0) //the highest land point in sa = 526.8
					{
						SetPlayerInterior(plo,1);
						PlayerInfo[plo][pInt] = 1;
					}
					if (GetPlayerState(plo) == 2)
					{
						TelePos[plo][0] = 0.0;
						TelePos[plo][1] = 0.0;
						new tmpcar = GetPlayerVehicleID(plo);
						SetVehiclePos(tmpcar, plocx, plocy+4, plocz);
					}
					else
					{
						SetPlayerPos(plo,plocx,plocy+2, plocz);
					}
					SendClientMessageRus(plo, COLOR_GRAD1, "Вы были телепортированы");
				}
				else
				{
					SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
				}
			}
			else
			{
				format(string, sizeof(string), "%d не активный игрок.", plo);
				SendClientMessageRus(playerid, COLOR_GRAD1, string);
			}
			return 1;
	}
	if(strcmp(cmd, "/getcar", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /gethere [carid]");
			return 1;
		}
		new Float:plocx,Float:plocy,Float:plocz;
		new plo;
		plo = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			GetPlayerPos(playerid, plocx, plocy, plocz);
			SetVehiclePos(plo,plocx,plocy+4, plocz);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[GiveGun]------------------------------------------------
	if(strcmp(cmd, "/givegun", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			//SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /givegun [playerid/PartOfName] [weaponid(eg. 46 = Parachute)] [ammo]");
			//SendClientMessageRus(playerid, COLOR_RED, "Предупреждение: Несуществующая модель оружия приведет к падению сервера");
			return 1;
		}
		new playa;
		new gun;
		new ammo;
		if(IsStringAName(tmp))
		{
			playa = GetPlayerID(tmp);
		}
		else
		{
			playa = strval(tmp);
		}
		tmp = strtok(cmdtext, idx);
		gun = strval(tmp);
		if(gun<1 || gun > 46)
		{
			SendClientMessageRus(playerid, COLOR_YELLOW, "Модель оружия не может быть меньше 1 и больше 46");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		ammo = strval(tmp);
		if(ammo<1)
		{
			SendClientMessageRus(playerid, COLOR_YELLOW, "Количество патронов не может быть меньше 1");
			return 1;
		}
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			GivePlayerWeapon(playa, gun, ammo);
			printf("AdmCmd: %s gave %s Weapon %d",sendername,  giveplayer, gun);

		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[GiveHealth]------------------------------------------------
	if(strcmp(cmd, "/givehealth", true) == 0 || strcmp(cmd, "/sethp", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			//SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /givehealth [playerid/PartOfName] [health]");
			return 1;
		}
		new playa;
		new health;
		if(IsStringAName(tmp))
		{
			playa = GetPlayerID(tmp);
		}
		else
		{
			playa = strval(tmp);
		}
		tmp = strtok(cmdtext, idx);
		health = strval(tmp);
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			SetPlayerHealth(playa, health);
			printf("AdmCmd: %s gave %s %d Health",sendername,  giveplayer, health);
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "you are not authorized to use that command!");
		}
		return 1;
	}
	if(strcmp(cmd, "/givearmour", true) == 0 || strcmp(cmd, "/setarmour", true) == 0 || strcmp(cmd, "/setarmor", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			//SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /givehealth [playerid/PartOfName] [health]");
			return 1;
		}
		new playa;
		new health;
		if(IsStringAName(tmp))
		{
			playa = GetPlayerID(tmp);
		}
		else
		{
			playa = strval(tmp);
		}
		tmp = strtok(cmdtext, idx);
		health = strval(tmp);
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			SetPlayerArmour(playa, health);
			printf("AdmCmd: %s gave %s %d Armour",sendername,  giveplayer, health);
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "you are not authorized to use that command!");
		}
		return 1;
	}
//----------------------------------[GiveHealth]------------------------------------------------
	if(strcmp(cmd, "/checkup", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			//SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /checkup [playerid/PartOfName]");
			return 1;
		}
		new playa;
		new Float:oldhealth;
		new Float:newhealth;
		if(IsStringAName(tmp))
		{
			playa = GetPlayerID(tmp);
		}
		else
		{
			playa = strval(tmp);
		}
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		GetPlayerHealth(playerid, oldhealth);
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			SetPlayerHealth(playa, 10.0);
			GetPlayerHealth(playa, newhealth);
			if(newhealth != 10.0)
			{
				printf("AdmCmd: cheatfound");
			}
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//native GetPlayerHealth(playerid, &Float:health);
//native SetPlayerHealth(playerid, Float:health);
//----------------------------------[GiveMoney]------------------------------------------------
	if(strcmp(cmd, "/givemoney", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			//SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /givemoney [playerid/PartOfName] [money]");
			return 1;
		}
		new playa;
		new money;
		if(IsStringAName(tmp))
		{
			playa = GetPlayerID(tmp);
		}
		else
		{
			playa = strval(tmp);
		}
		tmp = strtok(cmdtext, idx);
		money = strval(tmp);
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			ResetPlayerMoney(playa);
			SafeGivePlayerMoney(playa, money);
			printf("AdmCmd: %s set %s to $%d",sendername,  giveplayer, money);
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "you are not authorized to use that command!");
		}
		return 1;
	}
//-----------------------------------[Slap]-----------------------------------------------
	if(strcmp(cmd, "/slap", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /slap [playerid/PartOfName]");
			return 1;
		}
		new playa;
		new Float:shealth;
		new Float:slx, Float:sly, Float:slz;
		if(IsStringAName(tmp))
		{
			playa = GetPlayerID(tmp);
		}
		else
		{
			playa = strval(tmp);
		}
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pAdmin] >=1)
		{
			GetPlayerHealth(playa, shealth);
			SetPlayerHealth(playa, shealth-5);
			GetPlayerPos(playa, slx, sly, slz);
			SetPlayerPos(playa, slx, sly, slz+5);
			PlaySoundAll(playa, 1130, slx, sly, slz+5);
			printf("AdmCmd: %s slapped %s",sendername,  giveplayer);
			format(string, sizeof(string), "AdmCmd: %s was slapped by %s",giveplayer ,sendername);
			SendClientMessageToAllRus(COLOR_RED, string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/mute", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /slap [playerid/PartOfName]");
			return 1;
		}
		new playa;
		if(IsStringAName(tmp))
		{
			playa = GetPlayerID(tmp);
		}
		else
		{
			playa = strval(tmp);
		}
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			if(Mute[playa] == 0)
			{
				Mute[playa] = 1;
				printf("AdmCmd: %s silenced %s",sendername,  giveplayer);
				format(string, sizeof(string), "AdmCmd: %s was silenced by %s",giveplayer ,sendername);
				SendClientMessageToAllRus(COLOR_RED, string);
			}
			else
			{
				Mute[playa] = 0;
				printf("AdmCmd: %s unsilenced %s",sendername,  giveplayer);
				format(string, sizeof(string), "AdmCmd: %s was unsilenced by %s",giveplayer ,sendername);
				SendClientMessageToAllRus(COLOR_RED, string);
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[Slap]------------------------------------------------
	if(strcmp(cmd, "/sslap", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /sslap [playerid/PartOfName]");
			return 1;
		}
		new playa;
		new Float:shealth;
		new Float:slx, Float:sly, Float:slz;
		if(IsStringAName(tmp))
		{
			playa = GetPlayerID(tmp);
		}
		else
		{
			playa = strval(tmp);
		}
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			GetPlayerHealth(playa, shealth);
			SetPlayerHealth(playa, shealth-5);
			GetPlayerPos(playa, slx, sly, slz);
			SetPlayerPos(playa, slx, sly, slz+5);
			PlaySoundAll(playa, 1130, slx, sly, slz+5);
			
			format(string, sizeof(string), "AdmCmd: %s Silent Slaps %s",sendername,  giveplayer);
			printf("%s",string);
			format(string, sizeof(string), "AdmCmd: %s was Silently Slap",giveplayer);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/mute", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /slap [playerid/PartOfName]");
			return 1;
		}
		new playa;
		if(IsStringAName(tmp))
		{
			playa = GetPlayerID(tmp);
		}
		else
		{
			playa = strval(tmp);
		}
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			if(Mute[playa] == 0)
			{
				Mute[playa] = 1;
				printf("AdmCmd: %s silenced %s",sendername,  giveplayer);
				format(string, sizeof(string), "AdmCmd: %s was silenced by %s",giveplayer ,sendername);
				SendClientMessageToAllRus(COLOR_RED, string);
			}
			else
			{
				Mute[playa] = 0;
				printf("AdmCmd: %s unsilenced %s",sendername,  giveplayer);
				format(string, sizeof(string), "AdmCmd: %s was unsilenced by %s",giveplayer ,sendername);
				SendClientMessageToAllRus(COLOR_RED, string);
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[Slap]------------------------------------------------
	if(strcmp(cmd, "/ss", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /ss [playerid/PartOfName]");
			return 1;
		}
		new playa;
		new Float:shealth;
		if(IsStringAName(tmp))
		{
			playa = GetPlayerID(tmp);
		}
		else
		{
			playa = strval(tmp);
		}
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			GetPlayerHealth(playa, shealth);
			format(string, sizeof(string), "AdmCmd: %s has %.2f health",giveplayer ,shealth);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
			printf(string);
			SetPlayerHealth(playa, shealth-40);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[Slap]------------------------------------------------
	if(strcmp(cmd, "/sc", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /sc [playerid/PartOfName]");
			return 1;
		}
		new playa;
		new Float:shealth;
		if(IsStringAName(tmp))
		{
			playa = GetPlayerID(tmp);
		}
		else
		{
			playa = strval(tmp);
		}
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			GetPlayerHealth(playa, shealth);
			format(string, sizeof(string), "AdmCmd: %s has %f health",giveplayer ,shealth);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
			printf(string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[Kick]------------------------------------------------
	if(strcmp(cmd, "/kick", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /kick [playerid]");
			return 1;
		}
		new playa;
		if(IsStringAName(tmp))
		{
			playa = GetPlayerID(tmp);
		}
		else
		{
			playa = strval(tmp);
		}
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			Kick(playa);
			format(string, sizeof(string), "AdmCmd: %s Kicked %s",sendername,  giveplayer);
			printf("%s",string);
			format(string, sizeof(string), "AdmCmd: %s was kicked by %s",giveplayer ,sendername);
			SendClientMessageToAllRus(COLOR_RED, string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[Freeze]------------------------------------------------
	if(strcmp(cmd, "/freeze", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /freeze [playerid]");
			return 1;
		}
		new playa;
		if(IsStringAName(tmp))
		{
			playa = GetPlayerID(tmp);
		}
		else
		{
			playa = strval(tmp);
		}
		if(PlayerInfo[playa][pAdmin] > 0)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Админ не может быть заморожен");
			return 1;
		}
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pAdmin] >= 2)
		{
			TogglePlayerControllable(playa, 0);
			format(string, sizeof(string), "AdmCmd: %s Freezes %s",sendername,  giveplayer);
			printf("%s",string);
			format(string, sizeof(string), "AdmCmd: %s was Frozen by %s",giveplayer ,sendername);
			SendClientMessageToAllRus(COLOR_RED, string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}

//----------------------------------[Freeze]------------------------------------------------
	if(strcmp(cmd, "/sf", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /sf [playerid]");
			return 1;
		}
		new playa;
		if(IsStringAName(tmp))
		{
			playa = GetPlayerID(tmp);
		}
		else
		{
			playa = strval(tmp);
		}
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pAdmin] >= 2)
		{
			TogglePlayerControllable(playa, 0);
			format(string, sizeof(string), "AdmCmd: %s SFreezes %s",sendername,  giveplayer);
			printf("%s",string);
			format(string, sizeof(string), "AdmCmd: %s was SFrozen",giveplayer);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[Thaw]------------------------------------------------
	if(strcmp(cmd, "/thaw", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /thaw [playerid]");
			return 1;
		}
		new playa;
		if(IsStringAName(tmp))
		{
			playa = GetPlayerID(tmp);
		}
		else
		{
			playa = strval(tmp);
		}
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			TogglePlayerControllable(playa, 1);
			format(string, sizeof(string), "AdmCmd: %s Thaw %s",sendername,  giveplayer);
			printf("%s",string);
			format(string, sizeof(string), "AdmCmd: %s was Thawed by %s",giveplayer ,sendername);
			SendClientMessageToAllRus(COLOR_RED, string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[Ban]------------------------------------------------
	if(strcmp(cmd, "/ban", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /ban [playerid]");
			return 1;
		}
		new playa = strval(tmp);
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pAdmin] >= 1338)
		{
			format(string, sizeof(string), "AdmCmd: %s Banned %s",sendername,  giveplayer);
			printf("%s",string);
			format(string, sizeof(string), "AdmCmd: %s был забанен админом %s",giveplayer ,sendername);
			PlayerInfo[playa][pAdmin] = PlayerInfo[playa][pLevel];
			PlayerInfo[playa][pLevel] = -999;
			SendClientMessageToAllRus(COLOR_RED, string);
			Ban(playa);
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			format(string, sizeof(string), "AdmCmd: %s Banned %s",sendername,  giveplayer);
			printf("%s",string);
			format(string, sizeof(string), "AdmCmd: %s был забанен админом %s",giveplayer ,sendername);
			SendClientMessageToAllRus(COLOR_RED, string);
			PlayerInfo[playa][pAdmin] = PlayerInfo[playa][pLevel];
			PlayerInfo[playa][pLevel] = -999;
			Ban(playa);
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			if(PlayerInfo[playa][pLevel] > 2)
			{
				format(string, sizeof(string), "AdmNote: %s is level %d",playa,  PlayerInfo[playa][pLevel]);
				SendClientMessageRus(playerid,COLOR_RED, string);
				return 1;
			}
			format(string, sizeof(string), "AdmCmd: %s Banned %s",sendername,  giveplayer);
			printf("%s",string);
			format(string, sizeof(string), "AdmCmd: %s был забанен админом %s",giveplayer ,sendername);
			SendClientMessageToAllRus(COLOR_RED, string);
			PlayerInfo[playa][pAdmin] = PlayerInfo[playa][pLevel];
			PlayerInfo[playa][pLevel] = -999;
			Ban(playa);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[Ban]------------------------------------------------
	if(strcmp(cmd, "/sban", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /sban [playerid]");
			return 1;
		}
		new playa;
		if(IsStringAName(tmp))
		{
			playa = GetPlayerID(tmp);
		}
		else
		{
			playa = strval(tmp);
		}
		GetPlayerName(playa, giveplayer, sizeof(giveplayer));
		GetPlayerName(playerid, sendername, sizeof(sendername));
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			PlayerInfo[playa][pAdmin] = PlayerInfo[playa][pLevel];
			PlayerInfo[playa][pLevel] = -999;
			Ban(playa);
			format(string, sizeof(string), "AdmCmd: %s Silently Banned %s",sendername,  giveplayer);
			printf("%s",string);
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}

	/*
//----------------------------------[Mod]------------------------------------------------
	if(strcmp(cmd, "/mod", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			//SendClientMessageRus(playerid, COLOR_GRAD2, "USAGE: /mod [carmodid] 1034~1041");
			return 1;
		}
		new playa;
		playa = strval(tmp);
		new modcar = GetPlayerVehicleID(playerid);
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			AddVehicleComponent(modcar, playa);
			if (gdebug){printf("DEBUG modcar = %d mod = %d", modcar, playa);}
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "you are not authorized to use that command!");
		}
		return 1;
	}
	*/
//----------------------------------[EndRound]-----------------------------------------------

	if(strcmp(cmd, "/endround", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			GameModeInitExitFunc();
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[EndRound]-----------------------------------------------

//----------------------------------[GMX]-----------------------------------------------

	if(strcmp(cmd, "/gmx", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			GameModeExit();
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[mission]-----------------------------------------------

	if(strcmp(cmd, "/mission", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			PrePlayerNewMission();
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//----------------------------------[missionstop]-----------------------------------------------
/*	if(strcmp(cmd, "/missionstop", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			MissionActive = 0;
			CheckpointReset();
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					SetVehicleParamsForPlayerEx(stealcar,i,0,0);
				}
			}
			SendClientMessageRus(playerid, COLOR_GRAD1, "missions stopped type /mission to restart");
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "you are not authorized to use that command!");
		}
		return 1;
	}
*/
///<----------------------------[customrace]-------------------
	if (strcmp(cmd, "/sp", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /sp [1(resets)/2/3/4]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			new idx2 = strval(tmp);
			if(idx2 == 1)
			{
				new idx3 = 1;
				while (idx3 < sizeof(gRandomDMSpawns))
				{
					GetPlayerPos(playerid, gRandomDMSpawns[idx3][0], gRandomDMSpawns[idx3][1], gRandomDMSpawns[idx3][2]);
					idx3++;
				}
				gDMWbounds[0] = 50000000.0;gDMWbounds[1] = -50000000.0;gDMWbounds[2] = 50000000.0;gDMWbounds[3] = -50000000.0;
			}
			GetPlayerPos(playerid, gRandomDMSpawns[idx2][0], gRandomDMSpawns[idx2][1], gRandomDMSpawns[idx2][2]);
			format(string, sizeof(string), "DM Spawnpoint %d Set!",idx2);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
			SetPlayerCheckpointFixed(playerid,gRandomDMSpawns[idx2][0], gRandomDMSpawns[idx2][1], gRandomDMSpawns[idx2][2],4);
			PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
			return 1;
		}
		else
		{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if (strcmp(cmd, "/cam", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /cam [1/2/3/4]");
			return 1;
		}
		Unspec[playerid][sCam] = strval(tmp);
		format(string, sizeof(string), "Переключение к камере %d",Unspec[playerid][sCam]);
		SendClientMessageRus(playerid, COLOR_GRAD1, string);
		return 1;
	}
	if (strcmp(cmd, "/dmn", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			new Float:tmp1,Float:tmp2;
			GetPlayerPos(playerid, tmp1,gDMWbounds[2], tmp2);
			format(string, sizeof(string), "Северная точка ДМ установлена!");
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
			SetPlayerCheckpointFixed(playerid,tmp1,gDMWbounds[2], tmp2,4.0);
			PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
			return 1;
		}
		else
		{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if (strcmp(cmd, "/dms", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			new Float:tmp1,Float:tmp2;
			GetPlayerPos(playerid, tmp1,gDMWbounds[3], tmp2);
			format(string, sizeof(string), "Южная точка ДМ установлена!");
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
			SetPlayerCheckpointFixed(playerid,tmp1,gDMWbounds[3], tmp2,4.0);
			PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
			return 1;
		}
		else
		{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if (strcmp(cmd, "/dme", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			new Float:tmp1,Float:tmp2;
			GetPlayerPos(playerid, gDMWbounds[0],tmp1, tmp2);
			format(string, sizeof(string), "Восточная точка ДМ установлена!");
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
			SetPlayerCheckpointFixed(playerid,gDMWbounds[0],tmp1, tmp2,4.0);
			PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
			return 1;
		}
		else
		{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if (strcmp(cmd, "/dmw", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			new Float:tmp1,Float:tmp2;
			GetPlayerPos(playerid, gDMWbounds[1],tmp1, tmp2);
			format(string, sizeof(string), "Западная точка ДМ установлена!");
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
			gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
			SetPlayerCheckpointFixed(playerid,gDMWbounds[1],tmp1, tmp2,4.0);
			PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
			return 1;
		}
		else
		{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if (strcmp(cmd, "/savedm", true)==0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /savedm [dmname]");
				return 1;
			}
			SaveDM(playerid,tmp);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if (strcmp(cmd, "/loaddm", true)==0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /loaddm [dmname]");
				return 1;
			}
			LoadDM(playerid,tmp);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if (strcmp(cmd, "/stopdm", true)==0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			gFighters=0;
			gFightLeader=0;
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					if(gPlayerFighter[i] == 1)
					{
						gPlayerFighter[i] = 0;
						TogglePlayerControllable(i, 1);
						SetPlayerRandomSpawn(i);
						//SetPlayerWorldBounds(i,500000.0,-500000.0,500000.0,-500000.0);
					}
				}
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if (strcmp(cmd, "/laps", true) == 0)
	{
		if(MissionActive > 5 && MissionActive < 8)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Вы не можете редактировать количество кругов во время гонки");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /laps <amount>");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			new cpid = strval(tmp);
			RaceInfo[rLaps]	= cpid;
			SendClientMessageRus(playerid, COLOR_GRAD2, "Количество кругов установлено");
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if (strcmp(cmd, "/cp", true) == 0)
	{
		if(MissionActive > 5 && MissionActive < 8)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Нельзя создавать чекпойнты во время гонки");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /cp [1/2/3/4]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			new cpid = strval(tmp);
			if(cpid == 1)
			{
				GetPlayerPos(playerid, RaceInfo[rStartx], RaceInfo[rStarty], RaceInfo[rStartz]);
				SendClientMessageRus(playerid, COLOR_GRAD1, "Race Waypoint 1 Set!");
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
				SetPlayerCheckpointFixed(playerid,RaceInfo[rStartx], RaceInfo[rStarty], RaceInfo[rStartz], 16);
				PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
				return 1;
			}
			else if(cpid == 2)
			{
				GetPlayerPos(playerid, RaceInfo[rMidx], RaceInfo[rMidy], RaceInfo[rMidz]);
				SendClientMessageRus(playerid, COLOR_GRAD1, "Race Waypoint 2 Set!");
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
				SetPlayerCheckpointFixed(playerid,RaceInfo[rMidx], RaceInfo[rMidy], RaceInfo[rMidz], 8);
				PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
				return 1;
			}
			else if(cpid == 3)
			{
				GetPlayerPos(playerid,RaceInfo[rMid2x], RaceInfo[rMid2y], RaceInfo[rMid2z]);
				SendClientMessageRus(playerid, COLOR_GRAD1, "Race Waypoint 3 Set!");
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
				SetPlayerCheckpointFixed(playerid,RaceInfo[rMid2x], RaceInfo[rMid2y], RaceInfo[rMid2z], 8);
				PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
				return 1;
			}
			else
			{
				GetPlayerPos(playerid,RaceInfo[rEndx], RaceInfo[rEndy], RaceInfo[rEndz]);
				SendClientMessageRus(playerid, COLOR_GRAD1, "Race Waypoint 4 Set!");
				gPlayerCheckpointStatus[playerid] = CHECKPOINT_NONE;
				SetPlayerCheckpointFixed(playerid,RaceInfo[rEndx], RaceInfo[rEndy], RaceInfo[rEndz], 8);
				PlayerPlaySound(playerid, 1150, 0.0, 0.0, 0.0);
				rsx = RaceInfo[rStartx];rsy = RaceInfo[rStarty];rsz =RaceInfo[rStartz];
				rmx = RaceInfo[rMidx];rmy = RaceInfo[rMidy];rmz = RaceInfo[rMidz];
				rm2x = RaceInfo[rMid2x];rm2y = RaceInfo[rMid2y];rm2z = RaceInfo[rMid2z];
				rex = RaceInfo[rEndx];rey = RaceInfo[rEndy];rez = RaceInfo[rEndz];
				randomrace = 0;
				return 1;
			}
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
//		return 1;
	}
	if(strcmp(cmd, "/startrace", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			MissionActive = 0;
			if (gdebug){print("DEBUG MissionActive = 0");}
			CheckpointReset();
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					SetVehicleParamsForPlayerEx(stealcar,playerid,0,0);
					LapCount[i] = 0;
					StartTime[i] = 0;
				}
			}
			MissionActive = 5;
			if (gdebug){print("DEBUG MissionActive = 5");}
			gRaceFin = 0;
			gRaceMid = 0;
			gRaceMid2 = 0;
			gRaceEnd = 0;
			gLaps = 0;
			KillTimer(raceendtimer);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) == 1)
				{
					if (gTeam[i] >= 3)
					{
						JobGive(i);
					}
				}
			}
			SendClientMessageRus(playerid, COLOR_GRAD1, "Гонка запущена");
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/randomrace", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			if(randomrace == 1)
			{
				randomrace = 0;
				SendClientMessageRus(playerid, COLOR_GRAD2, "Случайный выбор гонок включен");
				rsx = RaceInfo[rStartx];rsy = RaceInfo[rStarty];rsz =RaceInfo[rStartz];
				rmx = RaceInfo[rMidx];rmy = RaceInfo[rMidy];rmz = RaceInfo[rMidz];
				rm2x = RaceInfo[rMid2x];rm2y = RaceInfo[rMid2y];rm2z = RaceInfo[rMid2z];
				rex = RaceInfo[rEndx];rey = RaceInfo[rEndy];rez = RaceInfo[rEndz];
			}
			else if(randomrace == 0)
			{
				randomrace = 1;
				SendClientMessageRus(playerid, COLOR_GRAD2, "Случайный выбор гонок выключен");
			}
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
	}
	if(strcmp(cmd, "/setrace", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			new racename[64];
			new name[64];
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /setrace [racename] [position-1-2-3-4]");
				format(string, sizeof(string), "Список гонок (1. %s) (2. %s) (3. %s) (4. %s) ",Races[0],Races[1],Races[2],Races[3]);
				SendClientMessageRus(playerid, COLOR_GREEN,string);
				format(string, sizeof(string), "Список гонок (5. %s) (6. %s) (7. %s) (8. %s) ",Races[4],Races[5],Races[6],Races[7]);
				SendClientMessageRus(playerid, COLOR_GREEN,string);
				return 1;
			}
			strmid(name, tmp, 0, strlen(tmp), 255);
			format(racename, sizeof(racename), "%s.race",name);
			new File: file = fopen(racename, io_read);
			if (!file)
			{
				SendClientMessageRus(playerid, COLOR_GREEN,"Файл не найден");
				return 1;
			}
			fclose(file);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /setrace [racename] [position-1-2-3-4]");
				return 1;
			}
			new raceid = strval(tmp)-1;
			racelist = strval(tmp);
			strmid(Races[raceid], name, 0, strlen(name), 255);
			format(string, sizeof(string), "Новый список (1. %s) (2. %s) (3. %s) (4. %s) ",Races[0],Races[1],Races[2],Races[3]);
			SendClientMessageRus(playerid, COLOR_GREEN,string);
			format(string, sizeof(string), "Новый список (5. %s) (6. %s) (7. %s) (8. %s) ",Races[4],Races[5],Races[6],Races[7]);
			SendClientMessageRus(playerid, COLOR_GREEN,string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
	}
	if(strcmp(cmd, "/racelist", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			if(racelist == 0)
			{
				racelist = 1;
				SendClientMessageRus(playerid, COLOR_GRAD2, "Race List Enabled");
				format(string, sizeof(string), "Список гонок (1. %s) (2. %s) (3. %s) (4. %s) ",Races[0],Races[1],Races[2],Races[3]);
				SendClientMessageRus(playerid, COLOR_GREEN,string);
				format(string, sizeof(string), "Список гонок (5. %s) (6. %s) (7. %s) (8. %s) ",Races[4],Races[5],Races[6],Races[7]);
				SendClientMessageRus(playerid, COLOR_GREEN,string);
			}
			else if(racelist != 0)
			{
				racelist = 0;
				SendClientMessageRus(playerid, COLOR_GRAD2, "Список гонок выключен");
			}
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
	}
	if(strcmp(cmd, "/footmode", true) == 0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			if(nocarcash == 1)
			{
				nocarcash = 0;
				SendClientMessageRus(playerid, COLOR_GRAD2, "Теперь кейс можно подбирать на авто");
			}
			else if(nocarcash == 0)
			{
				nocarcash = 1;
				SendClientMessageRus(playerid, COLOR_GRAD2, "Теперь кейс можно подбрать только пешком");
			}
			return 1;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
	}
	if (strcmp(cmd, "/racedelay", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /racedelay [seconds]");
			format(string, 256, "Время ожидания старта гонки установлено на %d секунд", racedelay/1000);
			SendClientMessageRus(playerid, COLOR_GRAD2, string);
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			new weaponid = strval(tmp);
			if(weaponid > 240 || weaponid < 10)
			{
				SendClientMessageRus(playerid, COLOR_GRAD2, "Минимум 10 Максимум 240");
				return 1;
			}
			racedelay = weaponid*1000;
			format(string, 256, "Время ожидания старта гонки установлено на %d секунд", weaponid);
			SendClientMessageRus(playerid, COLOR_GRAD2, string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if (strcmp(cmd, "/saverace", true)==0)
	{
		if(MissionActive > 5 && MissionActive < 8)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Нельзя редактировать гонки, когда они активны");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /saverace [racename]");
				return 1;
			}
			SaveRace(playerid,tmp);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if (strcmp(cmd, "/loadrace", true)==0)
	{
		if(MissionActive > 5 && MissionActive < 8)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "Нельзя редактировать гонки, когда они активны");
		}
		if (PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pAdmin] == -1 || gRaceGuy[playerid])
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /loadrace [racename](disables racelist)");
				return 1;
			}
			LoadRace(playerid,tmp);
			racelist = 0;
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if (strcmp(cmd, "/unban", true)==0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /unbanplayer [playername]");
				return 1;
			}
			if(!LoadPlayer(playerid,tmp))
			{
				return 1;
			}
			if(PLlayerInfo[playerid][plAdmin] == 0)
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Этот игрок не забанен!");
				return 1;
			}
			else
			{
				PLlayerInfo[playerid][plLevel] = PLlayerInfo[playerid][plAdmin];
				PLlayerInfo[playerid][plAdmin] = 0;
				SavePlayer(playerid,tmp);
				SendClientMessageRus(playerid, COLOR_GRAD1, "Игрок разбанен");
			}
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if (strcmp(cmd, "/loadpl", true)==0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /loadplayer [playername]");
				return 1;
			}
			LoadPlayer(playerid,tmp);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if (strcmp(cmd, "/savepl", true)==0)
	{
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /saveplayer [playername]");
				return 1;
			}
			SavePlayer(playerid,tmp);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//<-----------------------------[SpawnWeapon]-----------------------------------------------------------------------
	if (strcmp(cmd, "/drop", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			//SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /drop [weaponid]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			new weaponid = strval(tmp);
			new Float:px, Float:py, Float:pz;
			GetPlayerPos(playerid, px, py, pz);
			new coordsstring[256];
			format(coordsstring, 256, "AddStaticPickup(%d, 2, %.1f,%.1f,%.1f);\n", weaponid, px, py, pz);
			printf("AdmCmd:%d was spawned", weaponid);
			AddStaticPickup(weaponid, 15, px, py, pz);
			pickups++;
			new File:hFile;
			hFile = fopen("coords.txt", io_append);
			fwrite(hFile, coordsstring);
			fclose(hFile);
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
	if(strcmp(cmd, "/pos", true) == 0)
	{
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessageRus(playerid, COLOR_YELLOW, "ИСПОЛЬЗОВАНИЕ: /pos [comment]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			new Float:px, Float:py, Float:pz;
			GetPlayerPos(playerid, px, py, pz);
			new coordsstring[256];
			format(coordsstring, 256, "%.1f,%.1f,%.1f // %s\n", px, py, pz,result);
			new File:hFile;
			hFile = fopen("pos.txt", io_append);
			fwrite(hFile, coordsstring);
			fclose(hFile);

		}
		return 1;
	}
	if(strcmp(cmd, "/addcop", true) == 0)
	{
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessageRus(playerid, COLOR_YELLOW, "ИСПОЛЬЗОВАНИЕ: /addcop [copname]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 2 || PlayerInfo[playerid][pAdmin] == -2)
		{
			new Float:px, Float:py, Float:pz;
			GetPlayerPos(playerid, px, py, pz);
			new coordsstring[256];
			format(coordsstring, 256, "%s\n",result);
			new File:hFile;
			hFile = fopen("cops.cfg", io_append);
			fwrite(hFile, coordsstring);
			fclose(hFile);
			SendClientMessageRus(playerid, COLOR_GRAD1, "Игрок добавлен в список полицейских");
		}
		return 1;
	}
	if(strcmp(cmd, "/addmed", true) == 0)
	{
		new length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		new offset = idx;
		new result[64];
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessageRus(playerid, COLOR_YELLOW, "ИСПОЛЬЗОВАНИЕ: /addmed [copname]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 2 || PlayerInfo[playerid][pAdmin] == -3)
		{
			new Float:px, Float:py, Float:pz;
			GetPlayerPos(playerid, px, py, pz);
			new coordsstring[256];
			format(coordsstring, 256, "%s\n",result);
			new File:hFile;
			hFile = fopen("meds.cfg", io_append);
			fwrite(hFile, coordsstring);
			fclose(hFile);
			SendClientMessageRus(playerid, COLOR_GRAD1, "Игрок добавлен в список медиков");
		}
		return 1;
	}
//<-----------------------------[SpawnVehicle]-----------------------------------------------------------------------
	if (strcmp(cmd, "/vec", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			//SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /vec [vehicleid]");
			return 1;
		}
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			new weaponid = strval(tmp);
			new Float:px, Float:py, Float:pz, Float:pa;
			GetPlayerFacingAngle(playerid,pa);
			GetPlayerPos(playerid, px, py, pz);
			new coordsstring[256];
			format(coordsstring, 256, "CreateVehicle(%d, %.1f,%.1f,%.1f,%.1f,-1,-1,300);\n", weaponid, px, py, pz ,pa);
			printf("AdmCmd:vech: %d was spawned", weaponid);
			CreateVehicle(weaponid, px, py, pz, pa,-1,-1,300);
			new File:hFile;
			hFile = fopen("coords.txt", io_append);
			fwrite(hFile, coordsstring);
			fclose(hFile);
		}
		else
		{
			//SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}
		return 1;
	}
//<-----------------------------[PlaySound]-----------------------------------------------------------------------
	if (strcmp(cmd, "/ps", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /ps [soundid] eg. (1052 - 1058)(1020 - 1022), 1035");
			return 1;
		}
		new weaponid = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 2)
		{
			for(new i = 0; i < MAX_PLAYERS; i++) { if(IsPlayerConnected(i) == 1) { PlayerPlaySound(i, weaponid, 0.0, 0.0, 0.0); } }
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}

		return 1;
	}
//<-----------------------------[PlaySound]-----------------------------------------------------------------------
	if (strcmp(cmd, "/admins", true) == 0)
	{
		SendClientMessageRus(playerid, COLOR_GRAD1, "Админы онлайн:");
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) == 1 && PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAdmin] < 1338)
			{
				GetPlayerName(i, sendername, sizeof(sendername));
				format(string, 256, "%d админ: %s", PlayerInfo[i][pAdmin], sendername);
				SendClientMessageRus(playerid, COLOR_GRAD2, string);
			}
		}
		return 1;
	}
//<-----------------------------[cashbox]-----------------------------------------------------------------------
	if (strcmp(cmd, "/cashbox", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /cashbox [0-1] This mission on 1 off 0");
			format(string, sizeof(string), "cb:%d sr:%d hw:%d dm:%d", cashbox,streetrace,hotwire,deathmatch);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
			return 1;
		}
		new weaponid = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			cashbox=weaponid;
			format(string, sizeof(string), "cb:%d sr:%d hw:%d dm:%d", cashbox,streetrace,hotwire,deathmatch);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}

		return 1;
	}
//<-----------------------------[streetrace]-----------------------------------------------------------------------
	if (strcmp(cmd, "/streetrace", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /streetrace [0-1] This mission on 1 off 0");
			format(string, sizeof(string), "cb:%d sr:%d hw:%d dm:%d", cashbox,streetrace,hotwire,deathmatch);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
			return 1;
		}
		new weaponid = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			streetrace=weaponid;
			format(string, sizeof(string), "cb:%d sr:%d hw:%d dm:%d", cashbox,streetrace,hotwire,deathmatch);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}

		return 1;
	}
//<-----------------------------[hotwire]-----------------------------------------------------------------------
	if (strcmp(cmd, "/hotwire", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /hotwire [0-1] This mission on 1 off 0");
			format(string, sizeof(string), "cb:%d sr:%d hw:%d dm:%d", cashbox,streetrace,hotwire,deathmatch);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
			return 1;
		}
		new weaponid = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			hotwire=weaponid;
			format(string, sizeof(string), "cb:%d sr:%d hw:%d dm:%d", cashbox,streetrace,hotwire,deathmatch);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}

		return 1;
	}
	if (strcmp(cmd, "/deathmatch", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD2, "ИСПОЛЬЗОВАНИЕ: /deathmatch [0-1] This mission on 1 off 0");
			format(string, sizeof(string), "cb:%d sr:%d hw:%d dm:%d", cashbox,streetrace,hotwire,deathmatch);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
			return 1;
		}
		new weaponid = strval(tmp);
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			deathmatch=weaponid;
			format(string, sizeof(string), "cb:%d sr:%d hw:%d dm:%d", cashbox,streetrace,hotwire,deathmatch);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы не авторизованы для использования этой команды!");
		}

		return 1;
	}
//---------------------------------------------------------------------------------------
	if( strcmp( cmd, "/hidepm", true ) == 0 )
	{
		if (PlayerInfo[playerid][pAdmin] >= 6)
	    	HidePM[ playerid ] = 1;
	    SendClientMessageRus( playerid, COLOR_YELLOW, "You won't recieve other player's PM messages anymore.");
	    return 1;
	}
	if( strcmp( cmd, "/showpm", true ) == 0 )
	{
    	if (PlayerInfo[playerid][pAdmin] >= 6)
	    	HidePM[ playerid ] = 0;
    	SendClientMessageRus( playerid, COLOR_YELLOW, "You will now see other player's PM messages again.");
	    return 1;
	}
//----------------------------------[HELP]-----------------------------------------------
	if(strcmp(cmd, "/help", true) == 0)
	{
		SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
		//SendClientMessageRus(playerid, COLOR_YELLOW,"This script was made by Denver ( Astro )");
	    SendClientMessageRus(playerid, COLOR_GRAD1,"*** ACCOUNT *** /rules /regnick /login /changenick /changepass /level /buylevel /upgrade");
		SendClientMessageRus(playerid, COLOR_GRAD2,"*** GENERAL *** /pay /charity /time /buy /votekick /vote /unrentcar /givekey /switchkey /id");
		SendClientMessageRus(playerid, COLOR_GRAD2,"*** GENERAL *** /resetupgrades(100k) /betrace /betdm /bets /buygun /bestbuy /bestsale");
  		SendClientMessageRus(playerid, COLOR_GRAD3,"*** CHAT *** (/w)hisper (/o)oc (/s)hout (/l)ocal (/ad)vertise /me /togooc");
		SendClientMessageRus(playerid, COLOR_GRAD4,"*** BANK *** /balance /withdraw /deposit /wiretransfer /loan, ATM Only: /balance /withdraw");
		if (gTeam[playerid] == 2)
		{
			SendClientMessageRus(playerid, COLOR_GRAD5, "*** SAPD *** (/r)adio (/d)epartments (/m)egaphone (/su)spect /mdc /free /jail /duty /lock");
		}
		if (gTeam[playerid] == 1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD5, "*** SAMD *** (/r)adio (/d)epartments /heal /lock");
		}
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD6, "*** ADMIN *** (/a)dmin (/ah)elp");
		}
		if (PlayerInfo[playerid][pAdmin] == -1 || PlayerInfo[playerid][pAdmin] >= 3 || gRaceGuy[playerid])
		{
			SendClientMessageRus(playerid, COLOR_GRAD6, "*** RACE EDIT *** /cp /racedelay /laps /randomrace /racelist /setrace /saverace /loadrace");
		}
		SendClientMessageRus(playerid, COLOR_GRAD6,"*** OTHER *** /cellphonehelp /househelp /renthelp /businesshelp");
		SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");

		return 1;
	}

//------------------------------------------------------------------------------------------------------
//----------------------------------[HELP]-----------------------------------------------
	if(strcmp(cmd, "/rules", true) == 0)
	{
		SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
		SendClientMessageRus(playerid, COLOR_YELLOW,"PLEASE READ THESE RULES, THANKS.");
	    SendClientMessageRus(playerid, COLOR_RED,"KICKABLE OFFENCES: Spamming, Race start killing, Constant Flaming, Bug Abuse & DB Abuse (THE SAWNOFF BUG IS ALLOWED)");
		SendClientMessageRus(playerid, COLOR_RED,"BANNABLE OFFENCES: Cheating, Constant Spamming, Impostering Admins & Ignoring Rules");
		SendClientMessageRus(playerid, COLOR_WHITE,"OTHER THINGS: There are other things admins may do to you, Jail, Freeze, Slap etc");
  		SendClientMessageRus(playerid, COLOR_WHITE,"/admins to find out whos on, if you need more info ask.");
  		SendClientMessageRus(playerid, COLOR_YELLOW,"OWNER: [NB]Ryankilla Co-Owner: [:Ai:]UrAdEaDmAn");
		SendClientMessageRus(playerid, COLOR_YELLOW,"CURRENT ADMINS: [oasis]Kj, [SiN]Z!GGY & [NB]Ewan");
 		if (gTeam[playerid] == 2)
		
		return 1;
		}
//----------------------------------[HELP]-----------------------------------------------
	if(strcmp(cmd, "/cellphonehelp", true) == 0)
	{
		SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
		if (PlayerInfo[playerid][pPnumber] > 0)
		{
			SendClientMessageRus(playerid, COLOR_WHITE,"*** HELP *** type a command for more help");
			SendClientMessageRus(playerid, COLOR_GRAD3,"*** CELLPHONE *** (/c)all 'eg: /call 911' /sms (/p)ickup (/h)angup /number");
			SendClientMessageRus(playerid, COLOR_GRAD4,"*** OTHER *** /help /househelp /renthelp /businesshelp");
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_WHITE,"You can buy a cell phone in any 24-7");
		}
		return 1;
	}
	if(strcmp(cmd, "/househelp", true) == 0)
	{
		SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
		SendClientMessageRus(playerid, COLOR_WHITE,"*** HOUSE HELP *** type a command for more help");
		SendClientMessageRus(playerid, COLOR_GRAD3,"*** HOUSE *** /enter /exit /lock /home /heal /houseupgrade (/hu) /setrentable /tv (off/dm/race/pen/door)");
		SendClientMessageRus(playerid, COLOR_GRAD3,"*** HOUSE *** /carupgrade /carcolor /evictall /towcar /fixcar /modcar /modst /modlr /setrent /evict /housewithdraw");
		SendClientMessageRus(playerid, COLOR_GRAD4,"*** OTHER *** /cellphonehelp /help /renthelp /businesshelp");
		return 1;
	}
	if(strcmp(cmd, "/renthelp", true) == 0)
	{
		SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
		SendClientMessageRus(playerid, COLOR_WHITE,"*** RENTING HELP *** type a command for more help");
		SendClientMessageRus(playerid, COLOR_GRAD3,"*** RENT *** /unrent /enter /exit /lock /home");
		SendClientMessageRus(playerid, COLOR_GRAD4,"*** OTHER *** /cellphonehelp /househelp /help /businesshelp");
		return 1;
	}
	if(strcmp(cmd, "/businesshelp", true) == 0)
	{
		SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
		SendClientMessageRus(playerid, COLOR_WHITE,"*** BUSINESS HELP *** type a command for more help");
		SendClientMessageRus(playerid, COLOR_GRAD3,"*** BUSINESS *** /bizinfo /compprice /pricemod /bizfee");
		SendClientMessageRus(playerid, COLOR_GRAD4,"*** BUSINESS *** /enter /exit /lock /sellbiz /bizwithdraw /bizupgrade");
		SendClientMessageRus(playerid, COLOR_GRAD4,"*** OTHER *** /cellphonehelp /househelp /renthelp /help");
		return 1;
	}
	if(strcmp(cmd, "/ahelp", true) == 0 || strcmp(cmd, "/ah", true) == 0)
	{
		SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
		if (PlayerInfo[playerid][pAdmin] >= 1)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "*1* MODERATOR *** /stats /setint /mute /kick /ban /goto /cnn /a(dmin) chat");
		}
		if (PlayerInfo[playerid][pAdmin] >= 2)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2,"*2* ADMIN *** /skydive /setteam /bigears /ps /cnn /addcop /addmed /freeze /thaw /ajail /unjail /recon /cam /entercar");
		}
		if (PlayerInfo[playerid][pAdmin] >= 3)
		{
			SendClientMessageRus(playerid, COLOR_GRAD3,"*3* ADMIN *** /noooc /makeadmin /fourdive /dmweapon /loaddm /savedm /sp /startdm /stopdm /gotols /unban /healcar");
			SendClientMessageRus(playerid, COLOR_GRAD4,"*** ADMIN *** /mission /cashbox /streetrace /hotwire /endround /mark /gotomark /gotolv /gotosf /gethere /tod /putinveh");
		}
		if (PlayerInfo[playerid][pAdmin] >= 6)
		{
			SendClientMessageRus(playerid, COLOR_GRAD2,"*6* ADMIN *** /veh /destroycars /gotoc");
		}
		if (PlayerInfo[playerid][pAdmin] >= 1337)
		{
			SendClientMessageRus(playerid, COLOR_GRAD5,"*** 1337+ *** /loadpl /savepl /sban /sethp /setarmour /givegun /givemoney /makeadmin /setstat /gmx /asellhouse /tod /gotocar /sslap");
			SendClientMessageRus(playerid, COLOR_GRAD6,"*** ADMIN *** /mole /hq /logout /payday /logoutpl /logoutall /drop /vec /pos /test /spawn /incmis /editlevel /editprod");
		}
		if (PlayerInfo[playerid][pAdmin] >= 1338)
		{
			SendClientMessageRus(playerid, COLOR_GRAD6,"***1338 This makes you invisible in the admin list");
		}
		SendClientMessageRus(playerid, COLOR_GREEN,"_______________________________________");
		return 1;
	}
	if(strcmp(cmd, "/healcar", true) == 0)
	{
 		if(PlayerInfo[playerid][pAdmin] >= 3)
		{
			new health;
			tmp = strtok(cmdtext, idx);
			health = strval(tmp);
			if(health == 0)
			{
				TogglePlayerControllable(playerid, 0);
				RemovePlayerFromVehicle(playerid);
				TogglePlayerControllable(playerid, 1);
				SetVehicleToRespawn(GetPlayerVehicleID(playerid));
			}
			else if(health >= 1000)
			{
			    RepairVehicle(GetPlayerVehicleID(playerid));
			    SetVehicleHealth(GetPlayerVehicleID(playerid), health);
			}
			else
			{
				SetVehicleHealth(GetPlayerVehicleID(playerid), health);
			}
			GetPlayerName(playerid, sendername, sizeof(sendername));
       		format(string, 256, "AdmWarning: %s починил свою машину на %d", sendername,health);
			ABroadCast(COLOR_YELLOW,string,1);
		}
		return 1;
	}
	if(strcmp(cmd, "/contract", true) == 0) //no finnish
	{
		if(PlayerInfo[playerid][pLevel] < 3)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Эта команда доступна с 3 уровня.");
			return 1;
		}
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /contract [playerid/PartOfName] [amount]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(!IsPlayerConnected(giveplayerid)) return SendClientMessage(playerid, 0xAAAAAAAA, "Неправильный ID");
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /contract [playerid/PartOfName] [amount]");
			return 1;
		}
		moneys = strval(tmp);
		if (IsPlayerConnected(giveplayerid))
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			playermoney = GetPlayerMoney(playerid);
			if (moneys > 0 && playermoney >= moneys)
			{
				SafeGivePlayerMoney(playerid, (0 - moneys));
				Contract[giveplayerid] = Contract[giveplayerid]+moneys;
				format(string, sizeof(string), "%s has placed a contract on %s,for $%d.",sendername, giveplayer, moneys);
				PayLog(string);
				PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
				BroadCast(COLOR_YELLOW, string);
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_GRAD1, "Неправильная сумма контракта.");
			}
		}
		else
		{
				format(string, sizeof(string), "%d не активный игрок.", giveplayerid);
				SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		return 1;
	}
	if(strcmp(cmd, "/votekick", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /votekick [playerid/PartOfName]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if(IsPlayerAdmin(giveplayerid) || PlayerInfo[giveplayerid][pAdmin] >= 3)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Нельзя устраивать голосование за кик админа!");
			return 1;
		}
		if(PlayerInfo[giveplayerid][pLevel] >= 3)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Уровень данного игрока больше 2");
			return 1;
		}
		if (IsPlayerConnected(giveplayerid) && gPlayerSpawned[giveplayerid] == 1)
		{
			GetPlayerName(giveplayerid, giveplayer, sizeof(giveplayer));
			GetPlayerName(playerid, sendername, sizeof(sendername));
			VoteKick[giveplayerid] = 1;
			KickVote[giveplayerid] = 1;
			format(string, sizeof(string), "%s has started a vote to kick %s, type /vote %d to vote yes",sendername, giveplayer,giveplayerid);
			PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
			BroadCast(COLOR_YELLOW, string);
		}
		else
		{
				format(string, sizeof(string), "%d не активный игрок.", giveplayerid);
				SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		return 1;
	}
	if(strcmp(cmd, "/vote", true) == 0)
	{
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "ИСПОЛЬЗОВАНИЕ: /vote [playerid]");
			return 1;
		}
		if(IsStringAName(tmp))
		{
			giveplayerid = GetPlayerID(tmp);
		}
		else
		{
			giveplayerid = strval(tmp);
		}
		if (VoteKick[giveplayerid] == 0)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Нет голосований за кик этого игрока");
			return 1;
		}
		if (LastVote[playerid] == giveplayerid)
		{
			SendClientMessageRus(playerid, COLOR_GRAD1, "Вы можете проголосовать только 1 раз");
			return 1;
		}
		if (IsPlayerConnected(giveplayerid))
		{
			KickVote[giveplayerid]++;
			LastVote[playerid] = giveplayerid;
			SendClientMessageRus(playerid, COLOR_GRAD1, "Ваш голос учтен, спасибо за участие");
		}
		else
		{
			format(string, sizeof(string), "%d не активный игрок.", giveplayerid);
			SendClientMessageRus(playerid, COLOR_GRAD1, string);
		}
		return 1;
	}
	return 1;
}
//------------------------------------------------------------------------------------------------------
public HouseLevel(playerid)
{
	new h = PlayerInfo[playerid][pPhousekey];
	if(h == -1)
	{
		return 0;
	}
	if(h <= 4)
	{
		return 1;
	}
	if(h >= 5 && h <= 9)
	{
		return 2;
	}
	if(h >= 10 && h <= 18)
	{
		return 3;
	}
	if(h >= 19 && h <= 22)
	{
		return 4;
	}
	if(h >= 23 && h <= 25)
	{
		return 5;
	}
	if(h == 26)
	{
		return 6;
	}
	if(h == 27)
	{
		return 7;
	}
	if(h >= 28 && h <= 31)
	{
		return 7;
	}
	return 0;
}

public CHouseLevel(houseid)
{
	if(houseid <= 4)
	{
		return 3;
	}
	if(houseid >= 29 && houseid <= 30)
	{
		return 4;
	}
	if(houseid >= 5 && houseid <= 9)
	{
		return 5;
	}
	if(houseid >= 10 && houseid <= 18 || houseid == 28)
	{
		return 7;
	}
	if(houseid >= 19 && houseid <= 22)
	{
		return 8;
	}
	if(houseid >= 23 && houseid <= 25)
	{
		return 9;
	}
	if(houseid == 26)
	{
		return 10;
	}
	if(houseid == 27)
	{
		return 11;
	}
	if(houseid >= 28 && houseid <= 31)
	{
		return 12;
	}
	return 0;
}

public Decript(string[])
{
	if (gdebug){printf("DEBUG string = %s", string);}
	for(new x=0; x < strlen(string); x++)
	  {
		  string[x] -= (3^x) * (x % 15);
		  if(string[x] > (0xff))
		  {
			  string[x] -= 256;
		  }
	  }
	if (gdebug){printf("DEBUG decript = %s", string);}
	return 1;
}

public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if (gdebug >= 3){printf("DEBUG ProxDetector()");}
	new Float:posx, Float:posy, Float:posz;
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	//radi = 2.0; //Trigger Radius
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			if(!BigEar[i])
			{
				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);
				//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
				if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
				{
					SendClientMessageRus(i, col1, string);
				}
				else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
				{
					SendClientMessageRus(i, col2, string);
				}
				else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
				{
					SendClientMessageRus(i, col3, string);
				}
				else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
				{
					SendClientMessageRus(i, col4, string);
				}
				else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
				{
					SendClientMessageRus(i, col5, string);
				}
			}
			else
			{
				SendClientMessageRus(i, col1, string);
			}
		}
	}
	return 1;
}

public CrimInRange(Float:radi, playerid,copid)
{
	if (gdebug >= 0){printf("DEBUG CrimProxDetector()");}
	new Float:posx, Float:posy, Float:posz;
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	GetPlayerPos(copid, posx, posy, posz);
	tempposx = (oldposx -posx);
	tempposy = (oldposy -posy);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)))
	{
		return 1;
	}
	return 0;
}

public CrimProxDetector(Float:radi, playerid,col1,col2,col3,col4,col5,col6,col7,col8,col9,col10)
{
	if (gdebug >= 3){printf("DEBUG CrimProxDetector()");}
	new Float:posx, Float:posy, Float:posz;
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy;
	new count;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	for(count = 10; count >= 0; count=count-1)
	{
		//printf("counter = %d",count);
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) == 1 && gTeam[i] == 2 && FlashTime[i] == 0)
			{
				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				if (((tempposx < radi/count) && (tempposx > -radi/count)) && ((tempposy < radi/count) && (tempposy > -radi/count)))
				{
					//printf("DEBUG: player %d has at range %d",i,count);
					if (count == 10) {SetPlayerColor(playerid,col1);return 1;}
					else if (count == 9) {SetPlayerColor(playerid,col1);return 1;}
					else if (count == 8) {SetPlayerColor(playerid,col2);return 1;}
					else if (count == 7) {SetPlayerColor(playerid,col3);return 1;}
					else if (count == 6) {SetPlayerColor(playerid,col4);return 1;}
					else if (count == 5) {SetPlayerColor(playerid,col5);return 1;}
					else if (count == 4) {SetPlayerColor(playerid,col6);return 1;}
					else if (count == 3) {SetPlayerColor(playerid,col7);return 1;}
					else if (count == 2) {SetPlayerColor(playerid,col8);return 1;}
					else if (count == 1) {SetPlayerColor(playerid,col9);return 1;}
					else {SetPlayerColor(playerid,col10);return 1;}
				}

			}
		}
	}
	return 1;
}



public ProxDetectorS(Float:radi, playerid, targetid)
{
	if (gdebug >= 3){printf("DEBUG ProxDetectorS()");}
	new Float:posx, Float:posy, Float:posz;
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	//radi = 2.0; //Trigger Radius
	GetPlayerPos(targetid, posx, posy, posz);
	tempposx = (oldposx -posx);
	tempposy = (oldposy -posy);
	tempposz = (oldposz -posz);
	//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		return 1;
	}
	return 0;
}

public TestDistance(playerid,giveplayerid,Float:tarx,Float:tary,Float:tarz,Float:radi)
{
	if (gdebug >= 3){printf("DEBUG TestDistance()");}
	new Float:posx, Float:posy, Float:posz;
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new Float:tempposx, Float:tempposy, Float:tempposz;
	GetPlayerPos(playerid, oldposx, oldposy, oldposz);
	//radi = 2.0; //Trigger Radius
	GetPlayerPos(giveplayerid, posx, posy, posz);
	tempposx = (tarx -oldposx);
	tempposy = (tary -oldposy);
	tempposz = (tarz -oldposz);
	//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
	if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
	{
		if (gdebug >= 2){printf("DEBUG TestDistance2()");}
		tempposx = (tarx -posx);
		tempposy = (tary -posy);
		tempposz = (tarz -posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			if (gdebug >= 2){printf("DEBUG TestDistance3()");}
			return 1;
		}
	}
	else
	{
		return 0;
	}
	return 0;
}

public PlayerInArea()
{
	new Float:x, Float:y, Float:z;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			GetPlayerPos(i, x, y, z);
			//printf("DEBUGpia: X:%f Y:%f Z:%f",x, y, z);
			if(x<=2720.00 && x>=1220.00 && y<=2600.00 && y>=850.00 && z<=1100.0 && z>=900.0 || IsPlayerInRangeOfPoint(i, 2.0, 1119.0,-1.7,1000.6))
			{
				new string[64];
				format(string, sizeof(string), "~r~Closed");
				GameTextForPlayerRus(i, string, 5000, 6);
				SetPlayerInterior(i,12);
				PlayerInfo[i][pInt] = 12;
				SetPlayerPos(i,1022.599975,-1123.699951,23.799999);
			}
		}
	}
	return 1;
}

public PlayerInArena()
{
	new Float:x, Float:y, Float:z;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			GetPlayerPos(i, x, y, z);
			if((gPlayerFighter[i] != 1 && PlayerInfo[i][pAdmin] < 1 && Spectate[i] == -1))
			{
				if(x<=gDMWbounds[0]+50 && x>=gDMWbounds[1]-50 && y<=gDMWbounds[2]+50 && y>=gDMWbounds[3]-50)
				{
					GameTextForPlayerRus(i, "~w~Warning You Are Approaching A~n~~r~Restricted Area~n~~w~Turn back or be shot", 5000, 6);
				}
				if(x<=gDMWbounds[0]+25 && x>=gDMWbounds[1]-25 && y<=gDMWbounds[2]+25 && y>=gDMWbounds[3]-25)
				{
					SetPlayerHealth(i, 0.0);
				}
			}
			if(gPlayerFighter[i])
			{
				if(x>gDMWbounds[0])
				{
					SetPlayerPos(i, gDMWbounds[0], y,z); // Warp the player
					GameTextForPlayerRus(i, "~w~You cannot leave~n~~r~DEATHMATCH", 5000, 6);
				}
				if(x<gDMWbounds[1])
				{
					SetPlayerPos(i, gDMWbounds[1], y,z); // Warp the player
					GameTextForPlayerRus(i, "~w~You cannot leave~n~~r~DEATHMATCH", 5000, 6);
				}
				if(y>gDMWbounds[2])
				{
					SetPlayerPos(i, x,gDMWbounds[2],z); // Warp the player
					GameTextForPlayerRus(i, "~w~You cannot leave~n~~r~DEATHMATCH", 5000, 6);
				}
				if(y<gDMWbounds[3])
				{
					SetPlayerPos(i, x,gDMWbounds[3],z); // Warp the player
					GameTextForPlayerRus(i, "~w~You cannot leave~n~~r~DEATHMATCH", 5000, 6);
				}
			}
		}
	}
	return 1;
}

public PenInArea()
{
		new Float:x, Float:y, Float:z;
		if(gPublicEnemy != -1)
		{
			GetPlayerPos(gPublicEnemy, x, y, z);
			if(z>900.0)
			{
				new house = PlayerInfo[gPublicEnemy][pLocal];
				GameTextForPlayerRus(gPublicEnemy, "~w~There is nowhere to hide", 5000, 1);
				SetPlayerInterior(gPublicEnemy,0);
				PlayerInfo[gPublicEnemy][pInt] = 0;
				PlayerInfo[gPublicEnemy][pLocal] = -1;
				if(house > 99 && house != -1)
				{
					SetPlayerPos(gPublicEnemy, BizzInfo[house-99][bEntrancex], BizzInfo[house-99][bEntrancey],BizzInfo[house-99][bEntrancez]); // Warp the player
				}
				else if(house < 99 && house != -1)
				{
					SetPlayerPos(gPublicEnemy, HouseInfo[house][hEntrancex], HouseInfo[house][hEntrancey],HouseInfo[house][hEntrancez]); // Warp the player
				}
				else
				{
					SetPlayerPos(gPublicEnemy, 1350.1,-1279.1,13.3); // Warp the player to amunation
				}
			}
			if(z <= -0.5)
			{
				GameTextForPlayerRus(gPublicEnemy, "~w~Public Enemy Can Not Swim", 5000, 1);
				SetPlayerHealth(gPublicEnemy,0.0);
			}
			if(x == PenPos[0] && y == PenPos[1] && z == PenPos[2])
			{
				for(new i = 0; i < MAX_PLAYERS; i++)
				{
					if(IsPlayerConnected(i) && gTeam[i] == 2 && CrimInRange(5.0, gPublicEnemy,i))
					{
						SetPlayerHealth(gPublicEnemy, 0.0);
						OnPlayerDeath(gPublicEnemy, i, 0);
					}
				}
			}
			PenPos[0] = x ;PenPos[1]= y;PenPos[2]= z;
		}
		return 1;
}

public CustomPickups()
{
	new Float:oldposx, Float:oldposy, Float:oldposz;
	new string[128];
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			GetPlayerPos(i, oldposx, oldposy, oldposz);
			new tmpcar = GetPlayerVehicleID(i);
			/*
			if(gPlayerSpawned[i] && IsPlayerInRangeOfPoint(i, 10.0, 1520.1,-1473.2,9.2))
			{
				new string[128];
				format(string, sizeof(string), "~w~Wheel Arch Angels~n~Type ~g~/enter ~w~to use");
				GameTextForPlayerRus(i, string, 5000, 3);
			}
			*/
			if(oldposx!=0.0 && oldposy!=0.0 && oldposz!=0.0)
			{
				for(new h = 0; h < sizeof(SBizzInfo); h++)
				{
					if(IsATruck(tmpcar) && IsPlayerInRangeOfPoint(i, 10.0, SBizzInfo[h][sbEntrancex], SBizzInfo[h][sbEntrancey], SBizzInfo[h][sbEntrancez]))
					{
						format(string, sizeof(string), "~w~%s~n~~r~Components Required~w~: %d~n~~g~Paying~w~: $%d~n~~g~Funds: ~w~: $%d",SBizzInfo[h][sbDiscription],(SBizzInfo[h][sbCompCap]-SBizzInfo[h][sbComp]),SBizzInfo[h][sbPayComp],SBizzInfo[h][sbTakings]);
						GameTextForPlayerRus(i, string, 5000, 3);
						return 1;
					}
					if(IsPlayerInRangeOfPoint(i, 2.0, SBizzInfo[h][sbEntrancex], SBizzInfo[h][sbEntrancey], SBizzInfo[h][sbEntrancez]))
					{
						if(SBizzInfo[h][sbOwned] == 1)
						{
							format(string, sizeof(string), "~w~%s~w~~n~Owner : %s~n~Entrance Fee : ~g~$%d ~w~Level : %d ~n~to enter type /enter",SBizzInfo[h][sbDiscription],SBizzInfo[h][sbOwner],SBizzInfo[h][sbEntcost],SBizzInfo[h][sbLevel]);
						}
						else
						{
							format(string, sizeof(string), "~w~%s~w~~n~This Business is for sale~n~Cost: ~g~$%d ~w~Level : %d ~n~to buy this Business type /buybiz",SBizzInfo[h][sbDiscription],SBizzInfo[h][sbValue],SBizzInfo[h][sbLevel]);
						}
						GameTextForPlayerRus(i, string, 5000, 3);
						return 1;
					}
				}
				for(new h = 0; h < sizeof(HouseInfo); h++)
				{
					if(IsPlayerInRangeOfPoint(i, 2.0, HouseInfo[h][hEntrancex], HouseInfo[h][hEntrancey], HouseInfo[h][hEntrancez]))
					{
						if(HouseInfo[h][hOwned] == 1)
						{
							if(HouseInfo[h][hRentabil] == 0)
							{
								format(string, sizeof(string), "~w~This House is owned by~n~%s~n~Level : %d",HouseInfo[h][hOwner],HouseInfo[h][hLevel]);
							}
							else
							{
								format(string, sizeof(string), "~w~This House is owned by~n~%s~n~Rent: $%d Level : %d~n~Type /rentroom to rent a room",HouseInfo[h][hOwner],HouseInfo[h][hRent],HouseInfo[h][hLevel]);
							}
							GameTextForPlayerRus(i, string, 5000, 3);
							return 1;
						}
						else
						{
							format(string, sizeof(string), "~w~This House is for sale~n~Discription: %s ~n~Cost: ~g~$%d~n~~w~ Level : %d~n~to buy this house type /buyhouse",HouseInfo[h][hDiscription],HouseInfo[h][hValue],HouseInfo[h][hLevel]);
						}
						GameTextForPlayerRus(i, string, 5000, 3);
						return 1;
					}
				}
				for(new h = 0; h < sizeof(BizzInfo); h++)
				{
					if(IsATruck(tmpcar) && IsPlayerInRangeOfPoint(i, 10.0, BizzInfo[h][bEntrancex], BizzInfo[h][bEntrancey], BizzInfo[h][bEntrancez]))
					{
						format(string, sizeof(string), "~w~%s~n~~r~Components Required~w~: %d~n~~g~Paying~w~: $%d~n~~g~Funds: ~w~: $%d",BizzInfo[h][bDiscription],(BizzInfo[h][bCompCap]-BizzInfo[h][bComp]),BizzInfo[h][bPayComp],BizzInfo[h][bTakings]);
						GameTextForPlayerRus(i, string, 5000, 3);
						return 1;
					}
					if(IsPlayerInRangeOfPoint(i, 2.0, BizzInfo[h][bEntrancex], BizzInfo[h][bEntrancey], BizzInfo[h][bEntrancez]))
					{
						if(BizzInfo[h][bOwned] == 1)
						{
							format(string, sizeof(string), "~w~%s~w~~n~Owner : %s~n~Entrance Fee : ~g~$%d ~w~Level : %d ~n~to enter type /enter",BizzInfo[h][bDiscription],BizzInfo[h][bOwner],BizzInfo[h][bEntcost],BizzInfo[h][bLevel]);
						}
						else
						{
							format(string, sizeof(string), "~w~%s~w~~n~This Business is for sale~n~Cost: ~g~$%d ~w~Level : %d ~n~to buy this Business type /buybiz",BizzInfo[h][bDiscription],BizzInfo[h][bValue],BizzInfo[h][bLevel]);
						}
						GameTextForPlayerRus(i, string, 5000, 3);
						return 1;
					}
				}
			}
		}
	}
	return 1;
}

public IdleKick()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1 && PlayerInfo[i][pAdmin] < 1)
		{
			GetPlayerPos(i, PlayerPos[i][0], PlayerPos[i][1], PlayerPos[i][2]);
			//printf("player %d\n x = %f\n y = %f\n z = %f\n x2 = %f\n y2 = %f\n z2 = %f\n",i, PlayerPos[i][0],PlayerPos[i][1],PlayerPos[i][2],PlayerPos[i][3],PlayerPos[i][4],PlayerPos[i][5]);
			if(PlayerPos[i][0] == PlayerPos[i][3] && PlayerPos[i][1] == PlayerPos[i][4] && PlayerPos[i][2] == PlayerPos[i][5])
			{
				Kick(i);
			}
			PlayerPos[i][3] = PlayerPos[i][0];
			PlayerPos[i][4] = PlayerPos[i][1];
			PlayerPos[i][5] = PlayerPos[i][2];
		}
	}
}

public AntiCamp()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			if(SafeTime[i] > 0)
			{
				SafeTime[i]--;
			}
			if(SafeTime[i] == 1)
			{
				if(gPlayerAccount[i] == 1 && gPlayerLogged[i] == 0)
				{
					SendClientMessageRus(i, COLOR_RED, "Вам нужно было авторизоватся ( /login <password> )");
					Kick(i);
				}
			}
		}
	}
}

public AntiTeleport()
{
	new plname[MAX_PLAYER_NAME];
	new string[256];
	new Float:maxspeed = 175.0;
	new money;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1 && (GetPlayerState(i) == 2))
		{
			GetPlayerPos(i, TelePos[i][3], TelePos[i][4], TelePos[i][5]);
			if(TelePos[i][5] > 550.0)
			{
				TelePos[i][0] = 0.0;
				TelePos[i][1] = 0.0;
			}
			//printf("player %d\n x = %f\n y = %f\n z = %f\n x2 = %f\n y2 = %f\n z2 = %f\n",i, PlayerPos[i][0],PlayerPos[i][1],PlayerPos[i][2],PlayerPos[i][3],PlayerPos[i][4],PlayerPos[i][5]);
			if(TelePos[i][0] != 0.0)
			{
				new Float:xdist = TelePos[i][3]-TelePos[i][0];
				new Float:ydist = TelePos[i][4]-TelePos[i][1];
				new Float:sqxdist = xdist*xdist;
				new Float:sqydist = ydist*ydist;
				new Float:distance = (sqxdist+sqydist)/31;
				if(gSpeedo[i] == 2)
				{
					if(distance <10)
					{
						format(string, 256, "~n~~n~~n~~n~~n~~n~~n~~g~mph :   ~w~%.0f",distance);
					}
					if(distance > 10 && distance < 100)
					{
						format(string, 256, "~n~~n~~n~~n~~n~~n~~n~~g~mph :  ~w~%.0f",distance);
					}
					if(distance > 100)
					{
						format(string, 256, "~n~~n~~n~~n~~n~~n~~n~~g~mph : ~w~%.0f",distance);
					}
					GameTextForPlayerRus(i, string, 2000, 5);
				}
				if(distance > maxspeed)
				{
					new tmpcar = GetPlayerVehicleID(i);
					if(!IsAPlane(tmpcar))
					{
						GetPlayerName(i, plname, sizeof(plname));
						format(string, 256, "AdmWarning: [%d]%s %.0f mph",i,plname,distance);
						Speeder = i;
						ABroadCast(COLOR_YELLOW,string,1);
					}
				}
			}
			if(TelePos[i][5] < 550.0 && TelePos[i][3] != 0.0)
			{
				TelePos[i][0] = TelePos[i][3];
				TelePos[i][1] = TelePos[i][4];
			}
			
/////////////Money Anticheat/////////////////
			money = GetPlayerMoney(i);
			if(money > PlayerInfo[i][pCash] + 500) GivePlayerMoney(i, PlayerInfo[i][pCash] - money);
			else PlayerInfo[i][pCash] = money;
		}
	}
}


public RaceSpec(playerid)
{
	new tmplaps;
	new bestracer;
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1 && LapCount[i] > 0)
		{
			if(LapCount[i] > tmplaps)
			{
				bestracer = i;
				tmplaps = LapCount[i];
			}
		}
	}
	if(Spectate[playerid] != bestracer)
	{
		new sstring[256];
		new giveplayer[MAX_PLAYER_NAME];
		GetPlayerName(bestracer, giveplayer, sizeof(giveplayer));
		format(sstring, sizeof(sstring), "~w~%s",giveplayer);
		GameTextForPlayerRus(playerid, sstring, 5000, 1);
		Spectate[playerid] = bestracer;
	}
	return 1;
}

public BestPlayer(playerid)
{
	new bestplayer;
	bestplayer = lastkiller;
	if(gSuperCop != -1)
	{
		bestplayer = gSuperCop;
	}
	if(Spectate[playerid] != bestplayer)
	{
		new sstring[256];
		new giveplayer[MAX_PLAYER_NAME];
		GetPlayerName(bestplayer, giveplayer, sizeof(giveplayer));
		format(sstring, sizeof(sstring), "~w~%s",giveplayer);
		GameTextForPlayerRus(playerid, sstring, 5000, 1);
		Spectate[playerid] = bestplayer;
	}
	return 1;
}

public PenDelay(playerid)
{
	new bestplayer;
	new sstring[256];
	bestplayer = gPublicEnemy;
	if(bestplayer == -1)
	{
		TVMode[playerid] = 1;
		GameTextForPlayerRus(playerid, "~w~                True~n~                   ~b~Crime", 5000, 6);
		BestPlayer(playerid);
		return 1;
	}
	if(Spectate[playerid] != bestplayer)
	{
		new giveplayer[MAX_PLAYER_NAME];
		GetPlayerName(bestplayer, giveplayer, sizeof(giveplayer));
		format(sstring, sizeof(sstring), "~p~Starring ~n~~w~%s",giveplayer);
		GameTextForPlayerRus(playerid, sstring, 5000, 1);
		Spectate[playerid] = bestplayer;
	}
	return 1;
}

public SpeedDelay(playerid)
{
	new bestplayer;
	new sstring[256];
	bestplayer = Speeder;
	if(bestplayer == -1)
	{
		TVMode[playerid] = 1;
		GameTextForPlayerRus(playerid, "~w~                True~n~                   ~b~Crime", 5000, 6);
		BestPlayer(playerid);
		return 1;
	}
	if(Spectate[playerid] != bestplayer)
	{
		new giveplayer[MAX_PLAYER_NAME];
		GetPlayerName(bestplayer, giveplayer, sizeof(giveplayer));
		format(sstring, sizeof(sstring), "~p~Starring ~n~~w~%s",giveplayer);
		GameTextForPlayerRus(playerid, sstring, 5000, 1);
		Spectate[playerid] = bestplayer;
	}
	return 1;
}


public DMPlayer(playerid)
{
	new bestplayer;
	bestplayer = DmHiPlayer;
	if(bestplayer == -1)
	{
		TVMode[playerid] = 1;
		GameTextForPlayerRus(playerid, "~w~                True~n~                   ~b~Crime", 5000, 6);
		BestPlayer(playerid);
		return 1;
	}
	if(Spectate[playerid] != bestplayer)
	{
		new sstring[256];
		new giveplayer[MAX_PLAYER_NAME];
		GetPlayerName(bestplayer, giveplayer, sizeof(giveplayer));
		format(sstring, sizeof(sstring), "~w~%s~n~  score:~r~ %d",giveplayer,DmScore[bestplayer]);
		GameTextForPlayerRus(playerid, sstring, 5000, 1);
		Spectate[playerid] = bestplayer;
	}
	return 1;
}

public InHouse()
{
			new Float:oldposx, Float:oldposy, Float:oldposz;
			new string[256];
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i) == 1)
				{
					if(PlayerInfo[i][pLocal] != -1)
					{
						new house = PlayerInfo[i][pLocal];
						GetPlayerPos(i, oldposx, oldposy, oldposz);
						if(oldposz != 0.0)
						{
							if(oldposz < 600.0)
							{
								//new string[64];
								//format(string, sizeof(string), "~w~rexit");
								if(house == 10000)
								{
									if (!IsPlayerInRangeOfPoint(i, 6,-2724.0,217.9,4.1))
									{
										if (GetPlayerState(i) == 2)
										{
											new tmpcar = GetPlayerVehicleID(i);
											SetVehiclePos(tmpcar, 1520.1,-1473.2,9.2);
											SetVehicleZAngle(tmpcar, 270.0);
										}
										else
										{
											SetPlayerPos(i, 1520.1,-1473.2,9.2);
										}
										new oldcash = gSpentCash[i];
										new Total = GetPlayerMoney(i) - oldcash;
										printf("Total %d = GetPlayerMoney(playerid) %d - oldcash %d",Total,GetPlayerMoney(i),oldcash);
										new name[MAX_PLAYER_NAME];
										SBizzInfo[1][sbTakings] = SBizzInfo[1][sbTakings]-Total;
										GetPlayerName(i, name, sizeof(name));
										format(string,128,"<< %s has left the modshop with $%d >>",name,Total);
										PayLog(string);
										gSpentCash[i] = 0;
										TelePos[i][0] = 0.0;
										TelePos[i][1] = 0.0;
										PlayerInfo[i][pLocal] = -1;
										SetPlayerInterior(i,0);
										PlayerInfo[i][pInt] = 0;
										Spectate[i] = -1;
									}
								}
								if(house > 10000)
								{
									new tmpcar = GetPlayerVehicleID(i);
									if (!IsPlayerInRangeOfPoint(i, 6,1040.6,-1021.0,31.7) && house == 10001 ||!IsPlayerInRangeOfPoint(i, 6,-2720.5,217.5,4.1) && house == 10002 ||!IsPlayerInRangeOfPoint(i, 6,2644.6,-2044.9,13.3) && house == 10003)
									{
										if (GetPlayerState(i) == 2)
										{
											SetVehiclePos(tmpcar, HouseCarSpawns[tmpcar-1][0], HouseCarSpawns[tmpcar-1][1], HouseCarSpawns[tmpcar-1][2]);
											SetVehicleZAngle(tmpcar, HouseCarSpawns[tmpcar-1][3]);
										}
										else
										{
											SetPlayerPos(i, HouseCarSpawns[tmpcar-1][0], HouseCarSpawns[tmpcar-1][1], HouseCarSpawns[tmpcar-1][2]);
										}
										new oldcash = gSpentCash[i];
										new Total = GetPlayerMoney(i) - oldcash;
										printf("Total %d = GetPlayerMoney(playerid) %d - oldcash %d",Total,GetPlayerMoney(i),oldcash);
										new name[MAX_PLAYER_NAME];
										SBizzInfo[1][sbTakings] = SBizzInfo[1][sbTakings]-Total;
										GetPlayerName(i, name, sizeof(name));
										format(string,128,"<< %s has left the homemodshop with $%d >>",name,Total);
										PayLog(string);
										gSpentCash[i] = 0;
										TelePos[i][0] = 0.0;
										TelePos[i][1] = 0.0;
										PlayerInfo[i][pLocal] = -1;
										SetPlayerInterior(i,0);
										PlayerInfo[i][pInt] = 0;
										Spectate[i] = -1;
									}
								}
								if(house >= 99 && house != 10000)
								{
									if(house == 7+99 && PlayerInfo[i][pPbiskey] != 7) //casino) //casino
									{
										new oldcash = gSpentCash[i];
										new Total = GetPlayerMoney(i) - oldcash;
										printf("Total %d = GetPlayerMoney(playerid) %d - oldcash %d",Total,GetPlayerMoney(i),oldcash);
										new name[MAX_PLAYER_NAME];
										BizzInfo[7][bTakings] = BizzInfo[7][bTakings]-Total;
										GetPlayerName(i, name, sizeof(name));
										format(string,128,"<< %s has left the casino with $%d >>",name,Total);
										PayLog(string);
										gSpentCash[i] = 0;
									}
									SetPlayerPos(i, BizzInfo[house-99][bEntrancex], BizzInfo[house-99][bEntrancey],BizzInfo[house-99][bEntrancez]); // Warp the player
									PlayerInfo[i][pLocal] = -1;
									SetPlayerInterior(i,0);
									PlayerInfo[i][pInt] = 0;
								}
								else if(house < 99 && house != 10000)
								{
									SetPlayerPos(i, HouseInfo[house][hEntrancex], HouseInfo[house][hEntrancey],HouseInfo[house][hEntrancez]); // Warp the player
									PlayerInfo[i][pLocal] = -1;
									SetPlayerInterior(i,0);
									PlayerInfo[i][pInt] = 0;
								}
							}
						}
					}
				}
			}
		//	return 1;
}


public IsStringAName(string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			new testname[MAX_PLAYER_NAME];
			GetPlayerName(i, testname, sizeof(testname));
			//printf("IsS:testname = %s : string = %s",testname,string);
			if(strcmp(testname, string, true, strlen(string)) == 0)
			{
				//printf("TRUE IsS:testname = %s : string = %s",testname,string);
				return 1;
			}
		}
	}
	return 0;
}

public GetPlayerID(string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i) == 1)
		{
			new testname[MAX_PLAYER_NAME];
			GetPlayerName(i, testname, sizeof(testname));
			//printf("GetP:testname = %s : string = %s",testname,string);
			if(strcmp(testname, string, true, strlen(string)) == 0)
			{
				//printf("TRUE GetP:testname = %s : string = %s playerid %d",testname,string, i);
				return i;
			}
		}
	}
	return -1;
}

public OnPlayerText(playerid, text[])
{
	if(Mute[playerid] == 1)
	{
		SendClientMessageRus(playerid, TEAM_CYAN_COLOR, "Вы были заткнуты администратором");
		return 0;
	}
	if(Mobile[playerid] != -1)
	{
		new string [128];
		new sendername[MAX_PLAYER_NAME];
		new idx;
		new tmp[MAX_PLAYER_NAME];
		tmp = strtok(text, idx);
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s Says (cellphone): %s", sendername, text);
		ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		//printf("callers line %d called %d caller %d",Mobile[Mobile[playerid]],Mobile[playerid],playerid);
		if(Mobile[playerid] == 914)
		{
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, TEAM_CYAN_COLOR, "Диспетчер: Извините, я не понимаю.");
				return 0;
			}
			new turner[MAX_PLAYER_NAME];
			new wanted[128];
			GetPlayerName(playerid, turner, sizeof(turner));
			SendClientMessageRus(playerid, TEAM_CYAN_COLOR, "Диспетчер: Мы сообщим всем патрульным в этом районе.");
			SendClientMessageRus(playerid, TEAM_CYAN_COLOR, "Спасибо, что сообщили о происшествии");
			format(wanted, sizeof(wanted), "Диспетчер: Внимание всем подразделениям Доложил: %s",turner);
			SendTeamBeepMessage(1, TEAM_CYAN_COLOR, wanted);
			format(wanted, sizeof(wanted), "Диспетчер: Происшествие: %s",text);
			SendTeamMessage(1, TEAM_CYAN_COLOR, wanted);
			if(FlashTime[playerid] == 0){FlashTime[playerid] = 10;}
			SendClientMessageRus(playerid, COLOR_GRAD2, "Связь прервана...");
			Mobile[playerid] = -1;
			return 0;
		}
		if(Mobile[playerid] == 913)
		{
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_ALLDEPT, "Диспетчер: Извините, я не понимаю");
				return 0;
			}
			if ((strcmp("нет", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("нет")))
			{
				new turner[MAX_PLAYER_NAME];
				new wanted[128];
				GetPlayerName(playerid, turner, sizeof(turner));
				SendClientMessageRus(playerid, COLOR_DBLUE, "Полиция: Мы сообщим всем патрулям в этом районе.");
				SendClientMessageRus(playerid, COLOR_DBLUE, "Спасибо за сообщение");
				format(wanted, sizeof(wanted), "HQ: Всем подразделениям! Доложил: %s",turner);
				SendTeamBeepMessage(2, COLOR_DBLUE, wanted);
				format(wanted, sizeof(wanted), "HQ: Происшествие: %s, Подозреваемый: Unknown",PlayerCrime[playerid][pAccusing]);
				SendTeamMessage(2, COLOR_DBLUE, wanted);
				if(FlashTime[playerid] == 0){FlashTime[playerid] = 10;}
				SendClientMessageRus(playerid, COLOR_GRAD2, "Связь прервана...");
				Mobile[playerid] = -1;
				return 0;
			}
			new badguy;
			if(IsStringAName(tmp))
			{
				badguy = GetPlayerID(tmp);
			}
			else
			{
				badguy = strval(tmp);
			}
			if (gTeam[badguy] == 2 || gTeam[badguy] == 1)
			{
				SendClientMessageRus(playerid, COLOR_DBLUE, "Полиция: Сообщите в сулжбу собственной безопасности. Это экстренная линия");
				SendClientMessageRus(playerid, COLOR_GRAD2, "Связь прервана...");
				Mobile[playerid] = -1;
				return 0;
			}
			if (gTeam[badguy] >= 4)
			{
				SendClientMessageRus(playerid, COLOR_DBLUE, "Полиция: Данный игрок уже находится в розыске");
				SendClientMessageRus(playerid, COLOR_DBLUE, "Спасибо, что сообщили о происшествии");
				SendClientMessageRus(playerid, COLOR_GRAD2, "They Hung Up...");
				Mobile[playerid] = -1;
				return 0;
			}
			if (badguy == playerid)
			{
				SendClientMessageRus(playerid, COLOR_DBLUE, "Полиция: Не страдайте фигнёй, это экстренная линия.");
				SendClientMessageRus(playerid, COLOR_GRAD2, "Связь прервана...");
				Mobile[playerid] = -1;
				return 0;
			}
			if (IsPlayerConnected(badguy))
			{
				SendClientMessageRus(playerid, COLOR_DBLUE, "Полиция: Мы сообщили всем патрулям в этом районе.");
				SendClientMessageRus(playerid, COLOR_DBLUE, "Спасибо, что сообщили о происшествии");
				SetPlayerCriminal(badguy,playerid, PlayerCrime[playerid][pAccusing],0,0);
				if(FlashTime[badguy] == 0){FlashTime[playerid] = 10;}
				if(FlashTime[playerid] == 0){FlashTime[playerid] = 10;}
				SendClientMessageRus(playerid, COLOR_GRAD2, "They Hung Up...");
				Mobile[playerid] = -1;
				return 0;
			}
			else
			{
				format(string, sizeof(string), "Полиция: У меня нет информации о %s, вы уверены, что правильно указали имя?",tmp);
				SendClientMessageRus(playerid, COLOR_DBLUE, string);
				return 0;
			}
		}
		if(Mobile[playerid] == 912)
		{
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_ALLDEPT, "Диспетчер: Извините, я не понимаю.");
				return 0;
			}
			strmid(PlayerCrime[playerid][pAccusing], text, 0, strlen(text), 255);
			SendClientMessageRus(playerid, COLOR_DBLUE, "Полиция: Если вы знаете имя преступника, назовите его, иначе скажите нет.");
			Mobile[playerid] = 913;
			return 0;
		}
		if(Mobile[playerid] == 911)
		{
			if(!strlen(tmp))
			{
				SendClientMessageRus(playerid, COLOR_ALLDEPT, "Диспетчер: Извините, я не понял, полиция или скорая?");
				return 0;
			}
			else if ((strcmp("полиция", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("полиция")))
			{
				SendClientMessageRus(playerid, COLOR_ALLDEPT, "Диспетчер: Переключаю вас на полицию. Пожалуйста, подождите.");
				Mobile[playerid] = 912;
				SendClientMessageRus(playerid, COLOR_DBLUE, "Полиция: Пожалуйста, сообщите коротко о преступлении.");
				return 0;
			}
			else if ((strcmp("скорая", tmp, true, strlen(tmp)) == 0) && (strlen(tmp) == strlen("скорая")))
			{
				SendClientMessageRus(playerid, COLOR_ALLDEPT, "Диспетчер: Я переключу вас на скорую, пожалуйста подождите.");
				Mobile[playerid] = 914;
				SendClientMessageRus(playerid, TEAM_CYAN_COLOR, "Диспетчер: Пожалуйста сообщите кратко о происшествии.");
				return 0;
			}
			else
			{
				SendClientMessageRus(playerid, COLOR_ALLDEPT, "Диспетчер: Извините, я не понимаю, полиция или скорая?");
				return 0;
			}
		}
		if(IsPlayerConnected(Mobile[playerid]) == 1 && Mobile[Mobile[playerid]] == playerid)
		{
			SendClientMessageRus(Mobile[playerid], COLOR_YELLOW,string);
		}
		else
		{
			SendClientMessageRus(playerid, COLOR_YELLOW,"Здесь никого нет");
		}
		return 0;
	}
	if (realchat)
	{
		new string [128];
		new sendername[MAX_PLAYER_NAME];
		GetPlayerName(playerid, sendername, sizeof(sendername));
		format(string, sizeof(string), "%s Says %s", sendername, text);
		ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		return 0;
	}
	return 1;
}

public SetCamBack(playerid)
{
	new Float:plocx,Float:plocy,Float:plocz;
	GetPlayerPos(playerid, plocx, plocy, plocz);
	SetPlayerPos(playerid, -1863.15, -21.6598, 1060.15); // Warp the player
	SetPlayerInterior(playerid,14);
	//SetPlayerPos(playerid, plocx, plocy, plocz); // Warp the player
	//SetPlayerInterior(playerid,0);
}

public FixHour(hour)
{
	//if (gdebug >= 2){printf("DEBUG FixHour(%d)",hour);}
	hour = timeshift+hour;
	if (hour < 0)
	{
		hour = hour+24;
	}
	else if (hour > 23)
	{
		hour = hour-24;
	}
	shifthour = hour;
	return 1;
}

public AddsOn()
{
	if (gdebug >= 2){printf("DEBUG AddsOn()");}
	adds=1;
	return 1;
}
//--------------------------------------------------------------------------------------------
public OnPlayerPrivmsg(senderid, playerid, text[] )
{
	new string[256];
	new name[MAX_PLAYER_NAME]; // Reciever
	new name2[MAX_PLAYER_NAME]; // Sender
	GetPlayerName( playerid, name, MAX_PLAYER_NAME );
	GetPlayerName( senderid, name2, MAX_PLAYER_NAME );
	//format(string, sizeof(string), "[pm] %s %d %s %d %s", name, playerid, name2, senderid, text);
	//add_log( string );
	format(string, sizeof(string), "PM sent to %s (ID:%d): %s", name, playerid, text);
	SendClientMessageRus(senderid, 0xFCF54500, string);
	format(string, sizeof(string), "PM from %s (ID:%d): %s", name2, senderid, text);
	SendClientMessageRus(playerid, 0xFFDC1800, string);
	format( string, sizeof( string ), "PM from %s(ID:%d) to %s(ID:%d): %s", name2, senderid, name, playerid, text );
	// Now inform admins about it
	for( new i = 0; i < MAX_PLAYERS; i ++ )
	{
		if( IsPlayerConnected( i ) )
		{
		    if (PlayerInfo[i][pAdmin] >= 1337)
		    {
		        // Level 3 admin or higher, may see PM. Well... do we want to see PM's?
		        // Oh, and the recieving player shouldn't see this either.
		        if( HidePM[ i ] != 1 && i != playerid )
				{
				    // Yay, send the notice.
				    SendClientMessageRus( i, COLOR_YELLOW, string );
				}
			}
		}
	}
	return 1;
}
//--------------------------------------------------------------------------------------------------

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	new p1, p2;
	p1 = vParams[vehicleid][forplayerid] & 2;
	p2 = vParams[vehicleid][forplayerid] & 1;
	SetVehicleParamsForPlayer(vehicleid, forplayerid, p1, p2);
    return 1;
}

public SetVehicleParamsForPlayerEx(vehicleid, playerid, para1, para2)
{
	vParams[vehicleid][playerid] = para1*2 + para2;
	if(IsVehicleStreamedIn(vehicleid, playerid))
	    SetVehicleParamsForPlayer(vehicleid, playerid, para1, para2);
	return 1;
}

public OnPlayerInteriorChange(playerid,newinteriorid,oldinteriorid)
{
    PlayerInfo[playerid][pInt] = newinteriorid;
    if(oldinteriorid == 15 && newinteriorid == 0)
        SetPlayerVirtualWorld(playerid, 0);
    if(oldinteriorid == 0 && newinteriorid == 15)
        SetPlayerVirtualWorld(playerid, 1);
    return 1;
}

public OnVehicleSpawn(vehicleid)
{
	if(vehicleid == stealcar)
	{
    	new Float:px, Float:py, Float:pz;
		GetVehiclePos(stealcar, px, py, pz);
		CheckpointReset();
		SetAllPlayerCheckpoint(px, py, pz, 4.0, CHECKPOINT_NONE);
	}
	return 1;
}

MovePlayer(playerid, Float:radius, Float:zangle, Float:vertdelta, wcar = 1)
{
	if (gdebug > 0){print("DEBUG test246");}
	new Float:px;
	new Float:py;
	new Float:pz;
	new Float:za;
	if(GetPlayerState(playerid) == 2)
	{
     	GetVehicleZAngle(GetPlayerVehicleID(playerid), za);
		GetVehiclePos(GetPlayerVehicleID(playerid), px, py, pz);
		if(wcar)
		{
			SetVehiclePos(GetPlayerVehicleID(playerid), px + radius * floatcos(zangle + za + 90, degrees), py + radius * floatsin(zangle + za + 90, degrees), pz + vertdelta);
			SetVehicleZAngle(GetPlayerVehicleID(playerid), za);
		}
		else
		{
		 	SetPlayerPos(playerid, px + radius * floatcos(zangle + za + 90, degrees), py + radius * floatsin(zangle + za + 90, degrees), pz + vertdelta);
			SetPlayerFacingAngle(playerid, za);
		}
	}
	else
	{
		GetPlayerFacingAngle(playerid, za);
		GetPlayerPos(playerid, px, py, pz);
		SetPlayerPos(playerid, px + radius * floatcos(zangle + za + 90, degrees), py + radius * floatsin(zangle + za + 90, degrees), pz + vertdelta);
		SetPlayerFacingAngle(playerid, za);
	}
	return 1;
}

public SafeGivePlayerMoney(playerid, money)
{
	PlayerInfo[playerid][pCash] += money;
	GivePlayerMoney(playerid, money);
	return GetPlayerMoney(playerid);
}

public SetPlayerCheckpointFixed(playerid, Float:px, Float:py, Float:pz, Float:radius)
{
	DisablePlayerCheckpoint(playerid);
	return SetPlayerCheckpoint(playerid, Float:px, Float:py, Float:pz, Float:radius);
}
