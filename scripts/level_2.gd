extends LinkButton

@export var scene_to_load: String

func _on_Level2_pressed():
	global.reset_game()
	get_tree().change_scene_to_file("res://scenes/" + scene_to_load + ".tscn")
