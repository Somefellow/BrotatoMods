extends "res://ui/menus/run/character_selection.gd"


func _on_selections_completed()->void :
	for player_index in RunData.get_player_count():
		var character = _player_characters[player_index]

		var options_node = $"/root/CurseEverythingOptions"
		options_node.load_mod_options()
		
		if options_node.enable_curse_character:
			character = options_node.dlc.curse_item(character, player_index, options_node.disable_curse_random, options_node.min_curse_modifier)

		RunData.add_character(character, player_index)

	if RunData.some_player_has_weapon_slots():
		_change_scene(MenuData.weapon_selection_scene)
	else :
		_change_scene(MenuData.difficulty_selection_scene)
