#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;

init()
{
    level thread hud();
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill( "connected", player );
        player thread onPlayerSpawned();
        player thread speedhud();
        player thread hud();
        player thread DisplayPlayerKillstreak();
    }
}
speedhud()
{
    self endon("disconnect");
    level endon("game_ended");
    
    self.speedometer = createFontString("default", 1.6 );
    self.speedometer setPoint( "CENTER", "BOTTOM", "CENTER", -20 );
    self.speedometer.label = &"^7";
    self.speedometer.glowColor = (0.30, 0.00, 1.00);
    self.speedometer.glowAlpha = 1;

    for(;;) {
        vel = self getvelocity();
        self.speedometer setValue(int(sqrt( vel[0] * vel[0] + vel[1] * vel[1] )));
        wait 0.1;
    }
}
onPlayerSpawned()
{
    self endon("disconnect");
    for(;;)
    {
        self waittill("spawned_player");
    }
}

hud()
{
        self endon("disconnect");
        displayText = self createServerFontString( "objective", 0.8 );
        i = 0;
        for( ;; )
        {
                if(i == -1300) 
		{
                        i = 1300;
                }

                displayText setPoint( "TOPLEFT", "TOPLEFT", 5, 106);
                displayText setText("^5Discord: ^7Discord Link here");
                displayText.hideWhenInMenu = true;
                wait .03;
                i--;
        }
}
DisplayPlayerKillstreak()
{
    self endon ("disconnect");
    level endon("game_ended");

    self.killstreak_text = createFontString( "Objective", 0.65 );
    self.killstreak_text setPoint( "CENTER", "TOP", "CENTER", 7.5 );
    self.killstreak_text.label = &"^5 | KILLSTREAK: ";

    kills_text_x = -49;
    kills_text_x_move = 2.5;
    self.kills_text = createFontString( "Objective", 0.65 );
    self.kills_text setPoint( kills_text_x, "TOP", kills_text_x, 7.5 );
    self.kills_text.label = &"^5KILLS: ";

    self.deaths_text = createFontString( "Objective", 0.65 );
    self.deaths_text setPoint( 56.5, "TOP", 56.5, 7.5 );
    self.deaths_text.label = &"^5 | DEATHS: ";

    while(true)
    {
        if(self.playerstreak != self.pers["cur_kill_streak"])
        {
            self.playerstreak = self.pers["cur_kill_streak"];
            self.killstreak_text setValue(self.pers["cur_kill_streak"]);
        }

        if (self.pers["kills"] >= 10 && self.kills_text.x == kills_text_x)
        {
            self.kills_text.x = self.kills_text.x - kills_text_x_move;
        }
        else if (self.pers["kills"] >= 100 && self.kills_text.x == kills_text_x - kills_text_x_move)
        {
            self.kills_text.x = self.kills_text.x - kills_text_x_move;
        }

        self.kills_text setValue(self.pers["kills"]);
        self.deaths_text setValue(self.pers["deaths"]);

        wait 0.01;
    }
}