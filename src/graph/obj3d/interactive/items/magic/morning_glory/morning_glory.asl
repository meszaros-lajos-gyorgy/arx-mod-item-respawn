ON INIT {
 SETNAME [description_morning_glory]
 SET_MATERIAL CLOTH
 SET_GROUP PROVISIONS
 SET_PRICE 80
 PLAYERSTACKSIZE 10
 SET_STEAL 50
 SET §scale 80
 SET #TMP ~^RND_40~
 INC §scale #TMP 
 SETSCALE §scale
 SET_WEIGHT 0
 ACCEPT
}

ON COMBINE {
  IF (^$param1 ISCLASS "CRUSHER") {
    PLAY "CRUSHING"
    REPLACEME \\magic\\Powder_morning_glory\\Powder_morning_glory

    goto init_respawn

    ACCEPT
  }

  ACCEPT
}

ON FEINTE {
 SET §scale 5
 SETSCALE §scale
 OBJECT_HIDE SELF YES
 ACCEPT
}
ON CUSTOM { 
 IF (^$PARAM1 == "APPEAR") {
  IF (§done == 1) ACCEPT
  SET §done 1
  SENDEVENT CUSTOM MORNING_GLORY_0001 "APPEAR"
  SENDEVENT CUSTOM MORNING_GLORY_0002 "APPEAR"
  SENDEVENT CUSTOM MORNING_GLORY_0003 "APPEAR"
  SENDEVENT CUSTOM MORNING_GLORY_0004 "APPEAR"
  SENDEVENT CUSTOM MORNING_GLORY_0008 "APPEAR"
  SENDEVENT CUSTOM MORNING_GLORY_0008 "APPEAR"
  OBJECT_HIDE SELF OFF
  HALO -os 80
  TIMERhalo 1 7 HALO -f
  //PLAY "SFX_PLAYER_APPEARS"
  PLAYANIM ACTION1
  TIMERscale -m 19 50 GOTO SCALE 
  ACCEPT
 }
 ACCEPT
}
 
>>SCALE
SETSCALE §scale
INC §scale 5
ACCEPT

// ---------------------------

on initend {
  set £respawner_id "none"
  set §respawn_initiated 0

  accept
}

on game_ready {
  if (£respawner_id != "none") {
    accept
  }

  if (^ininitpos == 0) {
    accept
  }

  spawn item special/respawner/respawner self
  set £respawner_id ^last_spawned
  sendevent set_respawn_item £respawner_id "magic/morning_glory/morning_glory"
  accept
}

on set_respawner_id {
  set £respawner_id ^$param1
  accept
}

>>init_respawn {
  set §respawn_initiated 1
  sendevent enable  £respawner_id nop
  accept
}

on main {
  if (^dist_~£respawner_id~ <= 0.00001) {
    accept
  }

  if (§respawn_initiated == 1) {
    accept
  }

  goto init_respawn
  accept
}
