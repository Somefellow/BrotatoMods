extends "res://entities/units/movement_behaviors/player_movement_behavior.gd"


func get_movement()->Vector2:
	if not RunData.is_coop_run and not RunData.get_player_effect_bool("can_attack_while_moving", 0) and not ProgressData.is_manual_aim(0):
		var player = $"/root/Main"._players[0]
		for weapon in player.current_weapons:
			if (weapon._current_cooldown == 0 and
                weapon._current_target.size() > 0 and
				is_instance_valid(weapon._current_target[0]) and
				Utils.is_between(weapon._current_target[1], weapon.current_stats.min_range, weapon.get_max_range())):

				return Vector2.ZERO

	return .get_movement()
