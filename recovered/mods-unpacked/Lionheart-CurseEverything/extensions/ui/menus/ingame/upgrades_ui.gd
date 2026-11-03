extends "res://ui/menus/ingame/upgrades_ui.gd"


func _get_extra_crate_item(player_index: int) -> ItemParentData:
    var options = $"/root/CurseEverythingOptions"
    options.load_mod_options()

    options.force_curse = options.enable_curse_crate_items

    var item = ._get_extra_crate_item(player_index)

    options.force_curse = false

    # Fixed extra items (not random rolls) don't go through the item generator, so curse them here
    if options.enable_curse_crate_items:
        item = options.dlc.curse_item(item, player_index, options.disable_curse_random, options.min_curse_modifier)

    return item
