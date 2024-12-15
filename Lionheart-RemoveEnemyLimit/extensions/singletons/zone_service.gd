extends "res://singletons/zone_service.gd"


func get_wave_data(my_id: int, index: int) -> Resource:
    var wave = .get_wave_data(my_id, index)
    wave.max_enemies += 1000000
    return wave
