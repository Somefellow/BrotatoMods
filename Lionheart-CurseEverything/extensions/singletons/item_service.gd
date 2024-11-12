extends "res://singletons/item_service.gd"


func apply_item_effect_modifications(item: ItemParentData, player_index: int) -> ItemParentData:
    var options = $"/root/CurseEverythingOptions"

    if options.force_curse:
        item = options.dlc.curse_item(item, player_index, options.disable_curse_random, options.min_curse_modifier)

    return .apply_item_effect_modifications(item, player_index)


func process_item_box(consumable_data: ConsumableData, wave: int, player_index: int) -> ItemParentData:
    var options = $"/root/CurseEverythingOptions"
    options.load_mod_options()

    options.force_curse = options.enable_curse_crate_items

    var item = .process_item_box(consumable_data, wave, player_index)

    options.force_curse = false

    return item


func get_player_shop_items(wave: int, player_index: int, args: ItemServiceGetShopItemsArgs) -> Array:
    var options = $"/root/CurseEverythingOptions"
    options.load_mod_options()

    options.force_curse = options.enable_curse_crate_items

    var items = .get_player_shop_items(wave, player_index, args)

    options.force_curse = false

    return items
