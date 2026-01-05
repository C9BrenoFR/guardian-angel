extends CharacterBody2D

const DASH_COOLDOWN : float = 2

@export var speed : float = 300.0
@export var focus_speed : float = 150.0
@export var dash_speed : float = 20

var last_dash : float = DASH_COOLDOWN 


func _physics_process(delta):
	var direction := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	var current_speed = speed
	if Input.is_action_pressed("focus"):
		current_speed = focus_speed
	
	velocity = direction * current_speed

	if can_dash() and Input.is_action_just_pressed("dash") :
		velocity = velocity * dash_speed
		last_dash = 0
	else :
		last_dash += delta
	move_and_slide()

func can_dash() -> bool :
	if last_dash < DASH_COOLDOWN :
		return false
	return true
