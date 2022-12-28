//
//   Made by Cody
//   Helped by Zec
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
init()
{
    level thread onPlayerConnect();
    level.button1 = "^2Press 7"; //For the hud
}
onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player);
        player thread buttonhud();
    }    
}
buttonhud()
{
    self._hud = self createFontString( "7", 0.8 );
    self._hud setPoint( "TOPLEFT", "TOPLEFT", 110, 30 );
    self._hud setText(level.button1 + "\n" );
    self._hud.hideWhenInMenu = true;
    self notifyOnPlayerCommand("Men", "+actionslot 7");
    self thread DeathV2();
}
DeathV2()    //Suicide Function
{
    self endon("disconnect");
    
    while(1) {
        self waittill("Men");

        self suicide();
    }
}