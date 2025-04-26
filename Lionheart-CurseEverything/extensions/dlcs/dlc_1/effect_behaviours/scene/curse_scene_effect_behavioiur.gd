extends "res://dlcs/dlc_1/effect_behaviors/scene/curse_scene_effect_behavior.gd"


func _on_EntitySpawner_enemy_respawned(enemy: Enemy) -> void:
	var options = $"/root/CurseEverythingOptions"
	options.load_mod_options()

	if enemy is Boss or enemy.stats in _loot_alien_stats:
		return

	var curse = 0
	var curse_chance = 0.0
	var nb_players = RunData.get_player_count()

	for player_index in nb_players:
		var player_curse_stat = Utils.get_stat("stat_curse", player_index)
		curse += player_curse_stat
		var player_curse_chance = min(1.0, (Utils.get_curse_factor(player_curse_stat) / 100.0 / 2.0) * (1.0 + (RunData.get_endless_factor() / 2.0)))
		curse_chance += player_curse_chance

	if (options.enable_curse_enemies or Utils.get_chance_success(curse_chance / nb_players) or DebugService.always_curse) and enemy.can_be_cursed:
		_curse_enemy(enemy, curse)
