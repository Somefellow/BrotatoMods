extends "res://ui/menus/run/weapon_selection.gd"


func _on_selections_completed() -> void:
	var options = $"/root/CurseEverythingOptions"
	options.load_mod_options()

	if options.enable_curse_starting_gear:
		_on_selections_completed_with_curse(options)
	else:
		._on_selections_completed()


func _on_selections_completed_with_curse(options) -> void:
	for player_index in _player_weapons.size():
		var weapon = _player_weapons[player_index]

		if weapon != null:
			weapon = options.dlc.curse_item(weapon, player_index, options.disable_curse_random, options.min_curse_modifier)
			var _weapon = RunData.add_weapon(weapon, player_index, true)

	RunData.add_starting_items_and_weapons()
	_change_scene(MenuData.difficulty_selection_scene)
