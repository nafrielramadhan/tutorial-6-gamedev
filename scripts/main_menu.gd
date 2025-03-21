export(String) var scene_to_load

func _on_New_Game_pressed():
	get_tree().change_scene(str("res://scenes/" + scene_to_load + ".tscn"))


func _on_new_game_button_pressed() -> void:
	pass # Replace with function body.
