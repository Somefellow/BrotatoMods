extends "res://singletons/item_service.gd"


var apply_curse: = false


func apply_item_effect_modifications(item: ItemParentData, player_index: int)->ItemParentData:
    if apply_curse:
        var options_node = $"/root/CurseEverythingOptions"
        options_node.load_mod_options()

        item = options_node.dlc.curse_item(item, player_index, options_node.disable_curse_random, options_node.min_curse_modifier)

    return item


func process_item_box(consumable_data: ConsumableData, wave: int, player_index: int)->ItemParentData:
    var options_node = $"/root/CurseEverythingOptions"
    options_node.load_mod_options()
    
    apply_curse = options_node.enable_curse_crate_items

    var item = .process_item_box(consumable_data, wave, player_index)

    apply_curse = false

    return item


func get_player_shop_items(wave: int, player_index: int, args: ItemServiceGetShopItemsArgs)->Array:
    var options_node = $"/root/CurseEverythingOptions"
    options_node.load_mod_options()

    apply_curse = options_node.enable_curse_shop_items

    var items = .get_player_shop_items(wave, player_index, args)

    apply_curse = false

    return items
