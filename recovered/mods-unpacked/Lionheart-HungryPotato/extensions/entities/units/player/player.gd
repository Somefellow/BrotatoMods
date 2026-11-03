extends "res://entities/units/player/player.gd"


func _on_ItemAttractArea_area_entered(item: Item) -> void:
	if not _hungry_potato_should_attract(item):
		return

	var is_closer := item.attracted_by != null and global_position.distance_squared_to(item.global_position) < global_position.distance_squared_to(item.attracted_by.global_position)
	if item.attracted_by == null or is_closer:
		item.attracted_by = self
		# Items that have settled on the ground stop processing physics, so wake them up to fly to the player.
		item.set_physics_process(true)


func _hungry_potato_should_attract(item: Item) -> bool:
	if not item is Consumable:
		return true

	var consumable_data = (item as Consumable).consumable_data
	if consumable_data == null:
		return false

	# Meca/mutant fruit choose the evolution path, so leave them for the player to pick up deliberately.
	if consumable_data.my_id_hash == Keys.consumable_meca_fruit_hash or consumable_data.my_id_hash == Keys.consumable_mutant_fruit_hash:
		return false

	# Some consumables can only be picked up by certain players; attracting them would leave them stuck on the player.
	if not RunData.can_pick_up_consumable(consumable_data, player_index):
		return false

	# Consumables that deal damage (e.g. poisoned fruit) are only attracted at full health.
	if _hungry_potato_has_damage_effect(consumable_data):
		return current_stats.health == max_stats.health

	return true


func _hungry_potato_has_damage_effect(consumable_data: ConsumableData) -> bool:
	for effect in consumable_data.effects:
		if effect is ConsumableDamageEffect:
			return true
	return false
