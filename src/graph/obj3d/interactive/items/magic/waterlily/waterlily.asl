ON INIT {
 SETNAME [description_water_lily]
 SET_MATERIAL CLOTH
 SET_GROUP PROVISIONS
 SET_PRICE 25
 PLAYERSTACKSIZE 10
 SET_STEAL 50
 SET_WEIGHT 0
 ACCEPT
}

ON COMBINE {
  IF (^$param1 ISCLASS "CRUSHER") {
    PLAY "CRUSHING"
    REPLACEME "\\magic\\Powder_water_lily\\Powder_water_lily"

    goto init_respawn

    ACCEPT
  }

  ACCEPT
}

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
  sendevent set_respawn_item £respawner_id "magic/waterlily/waterlily"
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
