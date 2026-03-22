extends "res://ui/menus/run/character_selection.gd"


func _on_selections_completed() -> void:
	var options = $"/root/CurseEverythingOptions"
	options.load_mod_options()

	if options.enable_curse_character:
		_on_selections_completed_with_curse(options)
	else:
		._on_selections_completed()


func _on_selections_completed_with_curse(options) -> void:
	for player_index in RunData.get_player_count():
		var character = _player_characters[player_index]
		character = options.dlc.curse_item(character, player_index, options.disable_curse_random, options.min_curse_modifier)
		RunData.add_character(character, player_index)

	if Utils.on_nintendo_nx_or_ounce and RunData.is_coop_run:
		OS.set_max_controller_count(RunData.get_player_count())
	if RunData.some_player_has_weapon_slots():
		_change_scene(MenuData.weapon_selection_scene)
	else:
		RunData.add_starting_items_and_weapons()
		_change_scene(MenuData.difficulty_selection_scene)
