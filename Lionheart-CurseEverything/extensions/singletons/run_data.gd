extends "res://singletons/run_data.gd"


func add_starting_items_and_weapons() -> void:
	var options = $"/root/CurseEverythingOptions"
	options.load_mod_options()

	if options.enable_curse_starting_gear:
		for player_index in players_data.size():
			var effects := get_player_effects(player_index)

			for item_id in effects["starting_item"]:
				for i in item_id[1]:
					var item = ItemService.get_element(ItemService.items, item_id[0])
					item = options.dlc.curse_item(item, player_index, options.disable_curse_random, options.min_curse_modifier)
					add_item(item, player_index)

			for weapon_id in effects["starting_weapon"]:
				for i in weapon_id[1]:
					var weapon = ItemService.get_element(ItemService.weapons, weapon_id[0])
					weapon = options.dlc.curse_item(weapon, player_index, options.disable_curse_random, options.min_curse_modifier)
					var _weapon = add_weapon(weapon, player_index)

			for item_id in effects["cursed_starting_item"]:
				for i in item_id[1]:
					var item = ItemService.get_element(ItemService.items, item_id[0])
					item = options.dlc.curse_item(item, player_index, options.disable_curse_random, options.min_curse_modifier)
					add_item(item, player_index)

			for weapon_id in effects["cursed_starting_weapon"]:
				for i in weapon_id[1]:
					var weapon = ItemService.get_element(ItemService.weapons, weapon_id[0])
					options.dlc.curse_item(weapon, player_index, options.disable_curse_random, options.min_curse_modifier)
					var _weapon = add_weapon(weapon, player_index)
	else:
		.add_starting_items_and_weapons()
