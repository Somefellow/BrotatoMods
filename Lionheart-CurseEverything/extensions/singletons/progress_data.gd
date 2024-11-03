extends "res://singletons/progress_data.gd"


func load_dlc_pcks()->void :
    .load_dlc_pcks()
    
    var dir = ModLoaderMod.get_unpacked_dir() + "Lionheart-CurseEverything/extensions/"
    ModLoaderMod.install_script_extension(dir + "dlcs/dlc_1/effect_behaviours/scene/curse_scene_effect_behavioiur.gd")
    ModLoaderMod.install_script_extension(dir + "dlcs/dlc_1/dlc_1_data.gd")