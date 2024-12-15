extends "res://entities/units/movement_behaviors/player_movement_behavior.gd"


func get_player_index() -> int:
	if RunData.is_coop_run:
		for i in range(CoopService.connected_players.size()):
			if CoopService.connected_players[i][0] == device:
				return i
	return 0


func get_movement() -> Vector2:
	var player_index := get_player_index()
	if not RunData.get_player_effect_bool("can_attack_while_moving", player_index) and not ProgressData.is_manual_aim(player_index):
		var player = $"/root/Main"._players[player_index]
		for weapon in player.current_weapons:
			if (weapon._current_cooldown == 0 and
				weapon._current_target.size() > 0 and
				is_instance_valid(weapon._current_target[0]) and
				Utils.is_between(weapon._current_target[1], weapon.current_stats.min_range, weapon.get_max_range())):

				return Vector2.ZERO

	return .get_movement()
