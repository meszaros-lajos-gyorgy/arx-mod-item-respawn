// initialize variables and make sure the respawner can't be picked up
on init {
  setinteractivity none
  collision off

  set §respawn_when -1
  set £item_to_be_spawned "none"

  accept
}

// custom event for storing what item needs to be spawned
// expects the full path of an entity, for example:
// "provisions/mushroom/food_mushroom"
on set_respawn_item {
  set £item_to_be_spawned ^$param1
  accept
}

// custom event that gets sent by the item that got picked up
on enable {
  if (£item_to_be_spawned == "none") {
    accept
  }

  set §respawn_when ^gameseconds
  // add 2 minutes worth of seconds to the current in-game time
  inc §respawn_when 120

  accept
}

// this event gets called every second by the game
on main {
  if (£item_to_be_spawned == "none") {
    accept
  }

  if (§respawn_when == -1) {
    accept
  }

  if (^gameseconds < §respawn_when) {
    accept
  }

  set §respawn_when -1

  spawn item ~£item_to_be_spawned~ self
  sendevent set_respawner_id ^last_spawned ~^me~

  accept
}
