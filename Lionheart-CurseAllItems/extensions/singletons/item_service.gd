extends "res://singletons/item_service.gd"


func apply_item_effect_modifications(item: ItemParentData, player_index: int)->ItemParentData:
	
	if ProgressData.is_dlc_available_and_active("abyssal_terrors"):
		item = ProgressData.get_dlc_data("abyssal_terrors").curse_item(item, player_index, true)

	return .apply_item_effect_modifications(item, player_index)
