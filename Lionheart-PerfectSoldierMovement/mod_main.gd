extends Node


func _init() -> void:
	var dir = ModLoaderMod.get_unpacked_dir() + "Lionheart-PerfectSoldierMovement/extensions/"
	ModLoaderMod.install_script_extension(dir + "entities/units/movement_behaviours/player_movement_behaviour.gd")
