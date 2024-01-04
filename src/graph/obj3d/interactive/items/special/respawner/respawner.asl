// initialize variables and make sure the respawner can't be picked up
on init {
  setinteractivity none
  collision off

  set §respawn_started_at -1
  set £item_to_be_spawned "none"

  set #respawn_delay_in_seconds 120

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

  set §respawn_started_at ^gameseconds

  accept
}

// this event gets called every second by the game
on main {
  if (£item_to_be_spawned == "none") {
    accept
  }

  if (§respawn_started_at == -1) {
    accept
  }

  set §respawn_when §respawn_started_at
  inc §respawn_when #respawn_delay_in_seconds

  if (^gameseconds < §respawn_when) {
    accept
  }

  set §respawn_started_at -1

  spawn item ~£item_to_be_spawned~ self
  sendevent set_respawner_id ^last_spawned ~^me~

  accept
}
