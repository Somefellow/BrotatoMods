extends "res://ui/menus/ingame/upgrades_ui.gd"


func set_extra_items_in_crate_effect(player_index: int) -> void:
    var options = $"/root/CurseEverythingOptions"
    options.load_mod_options()
    
    options.force_curse = options.enable_curse_crate_items

    .set_extra_items_in_crate_effect(player_index)

    options.force_curse = false
