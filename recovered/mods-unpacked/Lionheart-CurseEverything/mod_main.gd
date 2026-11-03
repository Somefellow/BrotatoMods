extends Node


var options_script = load("res://mods-unpacked/Lionheart-CurseEverything/curse_everything_options.gd")


func _init() -> void:
	var dir = ModLoaderMod.get_unpacked_dir() + "Lionheart-CurseEverything/extensions/"

	ModLoaderMod.install_script_extension(dir + "singletons/item_service.gd")
	ModLoaderMod.install_script_extension(dir + "singletons/run_data.gd")
	ModLoaderMod.install_script_extension(dir + "ui/menus/ingame/upgrades_ui.gd")
	ModLoaderMod.install_script_extension(dir + "ui/menus/pages/main_menu.gd")
	ModLoaderMod.install_script_extension(dir + "ui/menus/run/character_selection.gd")
	ModLoaderMod.install_script_extension(dir + "ui/menus/run/weapon_selection.gd")
	# DLC content now ships inside Brotato.pck, so these can be installed up front with the rest
	ModLoaderMod.install_script_extension(dir + "dlcs/dlc_1/dlc_1_data.gd")
	ModLoaderMod.install_script_extension(dir + "effect_behaviors/scenes/curse_scene_effect_behavior.gd")

	_add_translations()


func _add_translations() -> void:
	var t := Translation.new()
	t.locale = "en"
	t.add_message("CURSE_EVERYTHING_ENABLE_CURSE_CHARACTER",    "Enable Curse Character")
	t.add_message("CURSE_EVERYTHING_ENABLE_CURSE_STARTING_GEAR","Enable Curse Starting Gear")
	t.add_message("CURSE_EVERYTHING_ENABLE_CURSE_CRATE_ITEMS",  "Enable Curse Crate Items")
	t.add_message("CURSE_EVERYTHING_ENABLE_CURSE_SHOP_ITEMS",   "Enable Curse Shop Items")
	t.add_message("CURSE_EVERYTHING_ENABLE_CURSE_ENEMIES",      "Enable Curse Enemies")
	t.add_message("CURSE_EVERYTHING_ENABLE_CURSE_ANY_ENEMY",    "Enable Curse Any Enemy")
	t.add_message("CURSE_EVERYTHING_DISABLE_CURSE_RANDOM",      "Disable Curse Randomisation")
	t.add_message("CURSE_EVERYTHING_MIN_CURSE_MODIFIER",        "Min Curse Modifier")
	TranslationServer.add_translation(t)
