extends Node2D

@export var obstacle : PackedScene

func _ready():
	repeat()

func spawn():
	var spawned = obstacle.instantiate()
	get_parent().call_deferred("add_child", spawned) 

	var spawn_pos = global_position
	spawn_pos.x = spawn_pos.x + randf_range(-1600, 2500)

	spawned.global_position = spawn_pos


func repeat():
	spawn()
	await get_tree().create_timer(1).timeout
	repeat()
