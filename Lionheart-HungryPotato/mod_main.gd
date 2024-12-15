extends Node


func _init() -> void:
	var dir = ModLoaderMod.get_unpacked_dir() + "Lionheart-HungryPotato/extensions/"

	ModLoaderMod.install_script_extension(dir + "entities/units/player/player.gd")
