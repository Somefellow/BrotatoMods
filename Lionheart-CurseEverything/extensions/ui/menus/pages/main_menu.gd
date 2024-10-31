extends "res://ui/menus/pages/main_menu.gd"


const CurseEverythingOptions = preload("res://mods-unpacked/Lionheart-CurseEverything/curse_everything_options.gd")


func _ready():
	var options_node = CurseEverythingOptions.new()

	options_node.set_name("CurseEverythingOptions")

	$"/root".add_child(options_node)
