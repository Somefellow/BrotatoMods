extends "res://ui/menus/pages/main_menu.gd"


const CurseEverythingOptions = preload("res://mods-unpacked/Lionheart-CurseEverything/curse_everything_options.gd")


func _ready() -> void:
	var options = CurseEverythingOptions.new()

	options.set_name("CurseEverythingOptions")

	$"/root".add_child(options)
