#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
    level.button2 = "^2[{vote yes}] ^5No FX & FullBright   ^2[{vote no}] ^5Render Distance";
    level thread onPlayerConnect();
}
onPlayerConnect()
{
    for (;;)
    {
        level waittill("connected", player);
        player thread povertyBoost();  
        player thread hud();
    }
}
povertyBoost()
{
    self endon("disconnect");
    self.fx_state = false;
    self.fullbright_state = false;
    self.r_zfar = 0;
    self notifyOnPlayerCommand("fx", "vote yes");
    self notifyOnPlayerCommand( "fullbright", "vote no");
    self notifyOnPlayerCommand( "drawdist", "vote no");

    for (;;)
    {
        msg = self waittill_any_return("fx", "fullbright", "drawdist");
        switch (msg) 
        {
            case "fx":
                if (self.fx_state) 
                {
                    self.fx_state = false;
                    self setClientDvar("fx_enable", 0);
                    self setClientDvar("r_fog", 0);
                    self setClientDvar("fx_drawclouds", 0);
                    self setClientDvar("r_lightmap", 3);
                    self iPrintLn("^5NO FX^1/^5FullBright^1/^5NO Fog");
                }
                else if (!self.fx_state) 
                {                    
                    self.fx_state = true;
                    self setClientDvar("fx_enable", 1);
                    self setClientDvar("r_fog", 1);
                    self setClientDvar("fx_drawclouds", 1);
                    self setClientDvar("r_lightmap", 1);
                    self iPrintLn("^1Disabled");
                }
                break;
            case "fullbright":
                if (!self.fullbright_state) 
                {
                    self.fullbright_state = true;
                }
                else if (self.fullbright_state) 
                {
                    self.fullbright_state = false;
                }
                break;
            case "drawdist":
                switch (self.r_zfar) 
                {
                    case 0:
                        self.r_zfar = 3000;
                        self setClientDvar("r_zfar", 3000);
                self iPrintLn("^53000");
                        break;
                    case 3000:
                        self.r_zfar = 2000;
                        self setClientDvar("r_zfar", 2000);
                self iPrintLn("^52000");
                        break;
                    case 2000:
                        self.r_zfar = 1000;
                        self setClientDvar("r_zfar", 1000);
                self iPrintLn("^51000");
                        break;
                    case 1000:
                        self.r_zfar = 500;
                        self setClientDvar("r_zfar", 500);
                self iPrintLn("^5500");
                        break;
                    case 500:
                        self.r_zfar = 0;
                        self setClientDvar("r_zfar", 0);
                    self iPrintLn("^1Disabled");
                        break;
                }
                break;
        }
    }
}
hud()
{
    self._hud = self createFontString( "7", 0.8 );
    self._hud setPoint( "TOP", "LEFT", 110, 30 );
    self._hud setText(level.button2 + "\n");
    self._hud.hideWhenInMenu = true;
}