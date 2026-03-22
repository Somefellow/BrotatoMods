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
		var element = _player_weapons[player_index]

		if element != null:
			element = options.dlc.curse_item(element, player_index, options.disable_curse_random, options.min_curse_modifier)
			if element is WeaponData:
				var _weapon = RunData.add_weapon(element, player_index, true)
			elif element is ItemData:
				var _item = RunData.add_item(element, player_index, true)

	RunData.add_starting_items_and_weapons()
	_change_scene(MenuData.difficulty_selection_scene)
