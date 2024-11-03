extends Node


var options_node_script = load("res://mods-unpacked/Lionheart-CurseEverything/curse_everything_options.gd")


func _init():
	var dir = ModLoaderMod.get_unpacked_dir() + "Lionheart-CurseEverything/extensions/"
	
	ModLoaderMod.install_script_extension(dir + "singletons/item_service.gd")
	ModLoaderMod.install_script_extension(dir + "singletons/run_data.gd")
	ModLoaderMod.install_script_extension(dir + "singletons/progress_data.gd") # DLC extensions in here
	ModLoaderMod.install_script_extension(dir + "ui/menus/ingame/upgrades_ui.gd")
	ModLoaderMod.install_script_extension(dir + "ui/menus/pages/main_menu.gd")
	ModLoaderMod.install_script_extension(dir + "ui/menus/run/character_selection.gd")
	ModLoaderMod.install_script_extension(dir + "ui/menus/run/weapon_selection.gd")
