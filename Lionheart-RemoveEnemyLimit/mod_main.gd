extends Node


func _init() -> void:
	var dir = ModLoaderMod.get_unpacked_dir() + "Lionheart-RemoveEnemyLimit/extensions/"

	ModLoaderMod.install_script_extension(dir + "singletons/zone_service.gd")
