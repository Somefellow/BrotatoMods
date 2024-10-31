extends Node


const MOD_NAME = "Lionheart-CurseAllItems"


func _init() -> void:
	var dir = ModLoaderMod.get_unpacked_dir().plus_file(MOD_NAME)
	ModLoaderMod.install_script_extension(dir + "/extensions/singletons/item_service.gd")


func _ready() -> void:
	ModLoaderLog.info("Ready!", MOD_NAME)
