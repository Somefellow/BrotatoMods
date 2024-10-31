extends "res://ui/menus/run/weapon_selection.gd"


func _on_selections_completed()->void :
    for player_index in _player_weapons.size():
        var weapon = _player_weapons[player_index]

        if weapon != null:
            var options_node = $"/root/CurseEverythingOptions"
            options_node.load_mod_options()
        
            if options_node.enable_curse_starting_gear:
                weapon = options_node.dlc.curse_item(weapon, player_index, options_node.disable_curse_random)

            var _weapon = RunData.add_weapon(weapon, player_index, true)

    RunData.add_starting_items_and_weapons()
    _change_scene(MenuData.difficulty_selection_scene)
