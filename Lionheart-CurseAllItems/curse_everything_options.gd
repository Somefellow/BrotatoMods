extends Node 

signal setting_changed(setting_name, value, mod_name)

# This Mirrors Configs to act as a backup and make reads shorter without string lookups
var enable_curse_character
var enable_curse_starting_gear
var enable_curse_crate_items
var enable_curse_shop_items
var enable_curse_enemies
var enable_curse_any_enemy
var disable_curse_random

var dlc

func _ready():
	if ProgressData.is_dlc_available_and_active("abyssal_terrors"):
		dlc = ProgressData.get_dlc_data("abyssal_terrors")
		if dlc:
			reset_defaults()
			load_mod_options()
		else:
			disable_all()
	else:
		disable_all()

func load_mod_options():
	if not $"/root/ModLoader".has_node("dami-ModOptions"):
		return

	var mod_configs = get_node("/root/ModLoader/dami-ModOptions/ModsConfigInterface").mod_configs

	if mod_configs.has("Lionheart-CurseEverything"):
		var config = mod_configs["Lionheart-CurseEverything"]
		
		if config.has("ENABLE_CURSE_CHARACTER"):
			enable_curse_character = config["ENABLE_CURSE_CHARACTER"]
		
		if config.has("ENABLE_CURSE_STARTING_GEAR"):
			enable_curse_starting_gear = config["ENABLE_CURSE_STARTING_GEAR"]
			
		if config.has("ENABLE_CURSE_CRATE_ITEMS"):
			enable_curse_crate_items = config["ENABLE_CURSE_CRATE_ITEMS"]
		
		if config.has("ENABLE_CURSE_SHOP_ITEMS"):
			enable_curse_shop_items = config["ENABLE_CURSE_SHOP_ITEMS"]
		
		if config.has("ENABLE_CURSE_ENEMIES"):
			enable_curse_enemies = config["ENABLE_CURSE_ENEMIES"]
		
		if config.has("DISABLE_CURSE_RANDOM"):
			disable_curse_random = config["DISABLE_CURSE_RANDOM"]

		if config.has("ENABLE_CURSE_ANY_ENEMY"):
			enable_curse_any_enemy = config["ENABLE_CURSE_ANY_ENEMY"]

func reset_defaults() -> void:
	enable_curse_character = true
	enable_curse_starting_gear = true
	enable_curse_crate_items = true
	enable_curse_shop_items = true
	enable_curse_enemies = false
	enable_curse_any_enemy = true
	disable_curse_random = true

func disable_all() -> void:
	enable_curse_character = false
	enable_curse_starting_gear = false
	enable_curse_crate_items = false
	enable_curse_shop_items = false
	enable_curse_enemies = false
	enable_curse_any_enemy = false
	disable_curse_random = false
