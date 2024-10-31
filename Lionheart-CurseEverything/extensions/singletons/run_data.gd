extends "res://singletons/run_data.gd"


func add_starting_items_and_weapons()->void :
	var options_node = $"/root/CurseEverythingOptions"
	options_node.load_mod_options()

	if options_node.enable_curse_starting_gear:
		for player_index in players_data.size():
			var effects: = get_player_effects(player_index)

			for item_id in effects["starting_item"]:
				for i in item_id[1]:
					var item = ItemService.get_element(ItemService.items, item_id[0])
					item = options_node.dlc.curse_item(item, player_index, options_node.disable_curse_random)
					add_item(item, player_index)

			for weapon_id in effects["starting_weapon"]:
				for i in weapon_id[1]:
					var weapon = ItemService.get_element(ItemService.weapons, weapon_id[0])
					weapon = options_node.dlc.curse_item(weapon, player_index, options_node.disable_curse_random)
					var _weapon = add_weapon(weapon, player_index)

			for item_id in effects["cursed_starting_item"]:
				for i in item_id[1]:
					var item = ItemService.get_element(ItemService.items, item_id[0])
					item = options_node.dlc.curse_item(item, player_index, options_node.disable_curse_random)
					add_item(item, player_index)

			for weapon_id in effects["cursed_starting_weapon"]:
				for i in weapon_id[1]:
					var weapon = ItemService.get_element(ItemService.weapons, weapon_id[0])
					options_node.dlc.curse_item(weapon, player_index, options_node.disable_curse_random)
					var _weapon = add_weapon(weapon, player_index)
	else:
		.add_starting_items_and_weapons()

