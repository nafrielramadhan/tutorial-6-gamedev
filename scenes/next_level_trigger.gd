extends Area2D

@export var sceneName: String

func _on_Area_Trigger_body_entered(body):
	var current_scene = get_tree().get_current_scene().get_name()
	if body.get_name() == "Player":
		if current_scene == sceneName:
			global.decrease_lives() 

		if global.lives <= 0:
			call_deferred("game_over") 
		else:
			call_deferred("restart_level")  
		
func game_over():
	transition.transition()
	await transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/LoseScreen.tscn")

func restart_level():
	transition.transition()
	await transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/" + sceneName + ".tscn")
