extends Node

var options_node_script = load("res://mods-unpacked/Lionheart-CurseEverything/curse_everything_options.gd")

func _init():
	var dir = ModLoaderMod.get_unpacked_dir() + "Lionheart-CurseEverything/extensions/"
	
	ModLoaderMod.install_script_extension(dir + "dlcs/dlc_1/effect_behaviours/scene/curse_scene_effect_behavioiur.gd")
	ModLoaderMod.install_script_extension(dir + "singletons/item_service.gd")
	ModLoaderMod.install_script_extension(dir + "singletons/run_data.gd")
	ModLoaderMod.install_script_extension(dir + "ui/menus/pages/main_menu.gd")
	ModLoaderMod.install_script_extension(dir + "ui/menus/run/character_selection.gd")
	ModLoaderMod.install_script_extension(dir + "ui/menus/run/weapon_selection.gd")

func _ready():
	var options_node = options_node_script.new()
	options_node.set_name("CurseEverythingOptions")
	$"/root".call_deferred("add_child", options_node)
	options_node.call_deferred("load_configs")
