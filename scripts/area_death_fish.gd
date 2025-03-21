extends Area2D

@export var sceneName = "LoseScreen"

func _on_FallArea_body_entered(body):
	if body.get_name() == "Player":
		get_tree().change_scene_to_file(str("res://scenes/" + sceneName + ".tscn"))
	else:
		body.queue_free()
