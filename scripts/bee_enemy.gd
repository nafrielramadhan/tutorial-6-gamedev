#extends Node2D
#@export var sceneName = "LoseScreen"

#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body.get_name() == "Player": 
		#get_tree().change_scene_to_file("res://scenes/" + sceneName + ".tscn")  # Ganti scene setelah suara selesai

extends Node2D

@export var sceneName: String

func _on_area_2d_body_entered(body: Node2D) -> void:
	var current_scene = get_tree().get_current_scene().get_name()
	
	if body.get_name() == "Player":
		
		if current_scene == sceneName:
			global.decrease_lives() 

		if global.lives <= 0:
			call_deferred("game_over")  
		else:
			call_deferred("restart_level") 

func game_over():
	get_tree().change_scene_to_file("res://scenes/LoseScreen.tscn")

func restart_level():
	get_tree().change_scene_to_file("res://scenes/" + sceneName + ".tscn")
