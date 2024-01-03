ON INIT {
 SET_SHADOW OFF
 SETNAME [description_mushroom]
 SET_MATERIAL CLOTH
 SET_GROUP PROVISIONS
 SET_GROUP FOOD
 SET_PRICE 8
 PLAYERSTACKSIZE 10
 SET_STEAL 50
 SET_FOOD 2
 SET_WEIGHT 0
 SET §scale 80
 SET §rnd ~^RND_40~
 INC §scale §rnd
 SETSCALE §scale
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

  spawn item special/respawner/respawner self
  set £respawner_id ^last_spawned
  sendevent set_respawn_item £respawner_id "provisions/mushroom/food_mushroom"
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
  // ^ininitpos only works for items that are specified in the DLF file
  if (^dist_~£respawner_id~ <= 0.00001) {
    accept
  }

  if (§respawn_initiated == 1) {
    accept
  }

  goto init_respawn
  accept
}
