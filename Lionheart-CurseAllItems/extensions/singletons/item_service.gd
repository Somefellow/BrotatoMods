extends "res://singletons/item_service.gd"


func process_item_box(consumable_data: ConsumableData, wave: int, player_index: int)->ItemParentData:
    var owned_items: Array = RunData.get_player_items(player_index)
    
    for locked_item in RunData.get_player_locked_shop_items(player_index):
        if locked_item[0] is ItemData:
            owned_items.push_back(locked_item[0])
    var args: = GetRandItemForWaveArgs.new()
    args.owned_and_shop_items = owned_items
    if consumable_data.my_id == "consumable_legendary_item_box":
        args.fixed_tier = Tier.LEGENDARY

    var options_node = $"/root/CurseEverythingOptions"
    options_node.load_mod_options()
    
    var item: = _get_rand_item_for_wave(wave, player_index, TierData.ITEMS, args, options_node.enable_curse_crate_items)
    return item


func get_player_shop_items(wave: int, player_index: int, args: ItemServiceGetShopItemsArgs)->Array:
    var new_items: = []
    var nb_weapons_guaranteed = 0
    var nb_weapons_added = 0
    var guaranteed_items = RunData.get_player_effect("guaranteed_shop_items", player_index).duplicate()

    var nb_locked_weapons = 0

    for locked_item in args.locked_items:
        if locked_item[0] is WeaponData:
            nb_locked_weapons += 1

    if RunData.current_wave <= MAX_WAVE_TWO_WEAPONS_GUARANTEED:
        nb_weapons_guaranteed = 2
    elif RunData.current_wave <= MAX_WAVE_ONE_WEAPON_GUARANTEED:
        nb_weapons_guaranteed = 1

    var minimum_weapons_in_shop = RunData.get_player_effect("minimum_weapons_in_shop", player_index)
    nb_weapons_guaranteed = max(nb_weapons_guaranteed, minimum_weapons_in_shop)

    for i in args.count:

        var type

        if RunData.current_wave <= MAX_WAVE_TWO_WEAPONS_GUARANTEED:
            type = TierData.WEAPONS if (nb_weapons_added + nb_locked_weapons < nb_weapons_guaranteed) else TierData.ITEMS
        elif guaranteed_items.size() > 0:
            type = TierData.ITEMS
        else :
            type = TierData.WEAPONS if (Utils.get_chance_success(CHANCE_WEAPON) or nb_weapons_added + nb_locked_weapons < nb_weapons_guaranteed) else TierData.ITEMS

        if type == TierData.WEAPONS:
            nb_weapons_added += 1

        if not RunData.player_has_weapon_slots(player_index):
            type = TierData.ITEMS

        var new_item

        if type == TierData.ITEMS and guaranteed_items.size() > 0:
            new_item = apply_item_effect_modifications(get_element(items, guaranteed_items[0][0]), player_index)
            guaranteed_items.pop_front()
        else :
            
            
            var rand_item_args: = GetRandItemForWaveArgs.new()
            rand_item_args.excluded_items = args.prev_items + new_items
            rand_item_args.owned_and_shop_items = args.owned_and_shop_items
            rand_item_args.increase_tier = args.increase_tier
            rand_item_args.fixed_tier = Tier.LEGENDARY

            var options_node = $"/root/CurseEverythingOptions"
            options_node.load_mod_options()

            new_item = _get_rand_item_for_wave(wave, player_index, type, rand_item_args, options_node.enable_curse_shop_items)

        new_items.push_back([new_item, wave])
    return new_items

func _get_rand_item_for_wave(wave: int, player_index: int, type: int, args: GetRandItemForWaveArgs, force_curse: bool = false)->ItemParentData:
    var rand_wanted = randf()
    var item_tier = get_tier_from_wave(wave, player_index, args.increase_tier)

    if args.fixed_tier != - 1:
        item_tier = args.fixed_tier

    if type == TierData.WEAPONS:
        var min_weapon_tier = RunData.get_player_effect("min_weapon_tier", player_index)
        var max_weapon_tier = RunData.get_player_effect("max_weapon_tier", player_index)
        item_tier = clamp(item_tier, min_weapon_tier, max_weapon_tier)

    var pool = get_pool(item_tier, type)
    var backup_pool = get_pool(item_tier, type)
    var items_to_remove = []

    
    for shop_item in args.excluded_items:
        pool = remove_element_by_id(pool, shop_item[0])
        backup_pool = remove_element_by_id(pool, shop_item[0])

    if type == TierData.WEAPONS:
        var bonus_chance_same_weapon_set = max(0, (MAX_WAVE_ONE_WEAPON_GUARANTEED + 1 - RunData.current_wave) * (BONUS_CHANCE_SAME_WEAPON_SET / MAX_WAVE_ONE_WEAPON_GUARANTEED))
        var chance_same_weapon_set = CHANCE_SAME_WEAPON_SET + bonus_chance_same_weapon_set
        var bonus_chance_same_weapon = max(0, (MAX_WAVE_ONE_WEAPON_GUARANTEED + 1 - RunData.current_wave) * (BONUS_CHANCE_SAME_WEAPON / MAX_WAVE_ONE_WEAPON_GUARANTEED))
        var chance_same_weapon = CHANCE_SAME_WEAPON + bonus_chance_same_weapon

        var no_melee_weapons: bool = RunData.get_player_effect_bool("no_melee_weapons", player_index)
        var no_ranged_weapons: bool = RunData.get_player_effect_bool("no_ranged_weapons", player_index)
        var no_duplicate_weapons: bool = RunData.get_player_effect_bool("no_duplicate_weapons", player_index)
        var no_structures: bool = RunData.get_player_effect("remove_shop_items", player_index).has("structure")

        var player_sets: Array = RunData.get_player_sets(player_index)
        var unique_weapon_ids: Dictionary = RunData.get_unique_weapon_ids(player_index)

        for item in pool:
            if no_melee_weapons and item.type == WeaponType.MELEE:
                backup_pool = remove_element_by_id(backup_pool, item)
                items_to_remove.push_back(item)
                continue

            if no_ranged_weapons and item.type == WeaponType.RANGED:
                backup_pool = remove_element_by_id(backup_pool, item)
                items_to_remove.push_back(item)
                continue

            if no_duplicate_weapons:
                for weapon in unique_weapon_ids.values():
                    
                    if item.weapon_id == weapon.weapon_id and item.tier < weapon.tier:
                        backup_pool = remove_element_by_id(backup_pool, item)
                        items_to_remove.push_back(item)
                        break

                    
                    elif item.my_id == weapon.my_id and weapon.upgrades_into == null:
                        backup_pool = remove_element_by_id(backup_pool, item)
                        items_to_remove.push_back(item)
                        break

            if no_structures and EntityService.is_weapon_spawning_structure(item):
                backup_pool = remove_element_by_id(backup_pool, item)
                items_to_remove.append(item)

            if rand_wanted < chance_same_weapon:
                if not item.weapon_id in unique_weapon_ids:
                    items_to_remove.push_back(item)
                    continue

            elif rand_wanted < chance_same_weapon_set:
                var remove: = true
                for set in item.sets:
                    if set.my_id in player_sets:
                        remove = false
                if remove:
                    items_to_remove.push_back(item)
                    continue

    elif type == TierData.ITEMS:
        if Utils.get_chance_success(CHANCE_WANTED_ITEM_TAG) and RunData.get_player_character(player_index).wanted_tags.size() > 0:
            for item in pool:
                var has_wanted_tag = false

                for tag in item.tags:
                    if RunData.get_player_character(player_index).wanted_tags.has(tag):
                        has_wanted_tag = true
                        break

                if not has_wanted_tag:
                    items_to_remove.push_back(item)

        var remove_item_tags: Array = RunData.get_player_effect("remove_shop_items", player_index)
        for tag_to_remove in remove_item_tags:
            for item in pool:
                if tag_to_remove in item.tags:
                    items_to_remove.append(item)

    var limited_items = get_limited_items(args.owned_and_shop_items)

    for key in limited_items:
        if limited_items[key][1] >= limited_items[key][0].max_nb:
            backup_pool = remove_element_by_id(backup_pool, limited_items[key][0])
            items_to_remove.push_back(limited_items[key][0])

    for item in items_to_remove:
        pool = remove_element_by_id(pool, item)

    var elt

    if pool.size() == 0:
        if backup_pool.size() > 0:
            elt = Utils.get_rand_element(backup_pool)
        else :
            elt = Utils.get_rand_element(_tiers_data[item_tier][type])
    else :
        elt = Utils.get_rand_element(pool)
        if elt.my_id == "item_axolotl" and randf() < 0.5:
            elt = Utils.get_rand_element(pool)

    if DebugService.force_item_in_shop != "" and randf() < 0.5:
        elt = get_element(items, DebugService.force_item_in_shop)

    if force_curse:
        var dlc = ProgressData.get_dlc_data("abyssal_terrors")
        if dlc:
            var options_node = $"/root/CurseEverythingOptions"
            options_node.load_mod_options()

            elt = dlc.curse_item(elt, player_index, options_node.disable_curse_random)

    return apply_item_effect_modifications(elt, player_index)