extends RigidBody2D

@export var sceneName: String = "Level2"

func _on_FallArea_body_entered(body):
	var current_scene = get_tree().get_current_scene().get_name()
	
	if body.get_name() == "Player":
		if current_scene == sceneName:
			global.decrease_lives()  

		if global.lives <= 0:
			call_deferred("game_over")  
		else:
			call_deferred("restart_level")  
	
	else:
		await get_tree().create_timer(3.2).timeout 
		body.call_deferred("queue_free")  

func game_over():
	get_tree().change_scene_to_file("res://scenes/LoseScreen.tscn")

func restart_level():
	get_tree().change_scene_to_file("res://scenes/" + sceneName + ".tscn")
