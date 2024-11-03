extends "res://ui/menus/ingame/upgrades_ui.gd"


func set_extra_items_in_crate_effect(player_index: int)->void :
    if _extra_items_to_process[player_index]:
        return 

    var extra_item_effects: Array = RunData.get_player_effect("extra_item_in_crate", player_index)
    for effect in extra_item_effects:
        if Utils.get_chance_success(effect[1] / 100.0):
            var item_data
            var add_item = true

            if effect[0] == "random":
                item_data = ItemService.get_rand_item_for_wave(RunData.current_wave, player_index)
                RunData.add_tracked_value(player_index, "item_treasure_map", 1)
            else :
                item_data = ItemService.get_item_from_id(effect[0]).duplicate()
                item_data.value = 1
                var player_items = RunData.get_player_items(player_index)

                for locked_item in RunData.get_player_locked_shop_items(player_index):
                    if locked_item[0] is ItemData:
                        player_items.push_back(locked_item[0])

                var limited_items = ItemService.get_limited_items(player_items)

                if limited_items.has(item_data.my_id) and limited_items[item_data.my_id][1] >= limited_items[item_data.my_id][0].max_nb:
                    add_item = false

            if add_item:
                var options_node = $"/root/CurseEverythingOptions"
                options_node.load_mod_options()

                if options_node.enable_curse_crate_items:
                    item_data = options_node.dlc.curse_item(item_data, player_index, options_node.disable_curse_random, options_node.min_curse_modifier)

                _extra_items_to_process[player_index].append(item_data)
