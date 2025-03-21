extends CharacterBody2D

@export var speed: int = 400
@export var sprint_speed: int = 720  
@export var gravity: int = 1200
@export var jump_speed: int = -500
@export var double_jump_speed: int = -500  
@export var sprint_time: float = 0.3 

var can_double_jump = false
var last_input_time = 0
var last_direction = 0
var is_sprinting = false
var is_double_jumping = false
var is_crouching = false

func get_input():
	velocity.x = 0

	if is_on_floor() and Input.is_action_pressed("ui_down"):
		is_crouching = true
	else:
		is_crouching = false

	if is_on_floor():
		can_double_jump = true 
		if is_double_jumping:
			is_double_jumping = false
		if Input.is_action_just_pressed("jump") and not is_crouching:
			velocity.y = jump_speed
	elif can_double_jump and Input.is_action_just_pressed("jump"):
		velocity.y = double_jump_speed
		can_double_jump = false  
		is_double_jumping = true

	var current_time = Time.get_ticks_msec() / 1000.0  

	if Input.is_action_just_pressed("right") or Input.is_action_just_pressed("left"):
		var direction = 1 if Input.is_action_just_pressed("right") else -1
		if direction == last_direction and (current_time - last_input_time) <= sprint_time:
			is_sprinting = true
		else:
			is_sprinting = false

		last_direction = direction
		last_input_time = current_time

	var current_speed = sprint_speed if is_sprinting else speed
	if not is_crouching:
		if Input.is_action_pressed("right"):
			velocity.x += current_speed
		if Input.is_action_pressed("left"):
			velocity.x -= current_speed


func _physics_process(delta):
	velocity.y += delta * gravity
	get_input()
	move_and_slide()


func _process(_delta):
	var animated_sprite = $AnimatedSprite2D

	if is_crouching:
		animated_sprite.play("crouch")
	elif is_double_jumping and velocity.y > 0:
		animated_sprite.play("fall")
		is_double_jumping = false
	elif is_double_jumping:
		animated_sprite.play("double_jump")
	elif velocity.y > 0 and not is_on_floor():
		animated_sprite.play("fall")
	elif not is_on_floor():
		animated_sprite.play("jump")
	elif velocity.x != 0:
		if is_sprinting:
			animated_sprite.play("sprint") 
		else:
			animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")

	if velocity.x != 0:
		animated_sprite.flip_h = velocity.x < 0
