extends "res://entities/units/player/player.gd"


func _on_ItemAttractArea_area_entered(item: Item) -> void:
	var has_damage_effect := item is Consumable and (item as Consumable).has_damage_effect()
	var full_health := current_stats.health == max_stats.health

	var should_attract_item := not has_damage_effect or full_health
	if not should_attract_item:
		return

	var item_already_attracted_by_player := item.attracted_by != null
	if should_attract_item and not item_already_attracted_by_player:
		item.attracted_by = self

	if global_position.distance_squared_to(item.global_position) < global_position.distance_squared_to(item.attracted_by.global_position):
		item.attracted_by = self
