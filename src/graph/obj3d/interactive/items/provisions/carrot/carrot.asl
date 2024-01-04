ON INIT {
 SETNAME [description_carrot]
 SET_MATERIAL CLOTH
 SET_GROUP PROVISIONS
 SET_GROUP FOOD
 SET_PRICE 5
 PLAYERSTACKSIZE 10
 SET_STEAL 50
 SET_FOOD 2
 SET_WEIGHT 0
 ACCEPT
}
ON INVENTORYUSE {
 PLAY "eat"
 SPECIALFX HEAL 1
 EATME

 goto init_respawn

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
  sendevent set_respawn_item £respawner_id "provisions/carrot/carrot"
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
