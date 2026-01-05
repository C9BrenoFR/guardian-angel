extends CharacterBody2D

const DASH_COOLDOWN = 0.5
const OBJ_BULLET = preload("res://scenes/bullet.tscn")
const BULLET_SPEED := 500.0
const SHOOT_COOLDOWN := 0.15

const CROSSHAIR = preload("res://assets/sprites/ui/aim.png")
const FOCUSED_CROSSHAIR = preload("res://assets/sprites/ui/focused_aim.png")

@export var original_speed : float = 150.0
@export var speed : float = original_speed
@export var focus_speed : float = 75.0
@export var dash_speed : float = 600.0
@export var dash_duration : float = 0.15

var is_dashing : bool = false
var dash_time : float = 0.0
var dash_direction : Vector2 = Vector2.ZERO
var last_dash : float = DASH_COOLDOWN 
var shoot_timer := 0.0

func _ready() -> void:
	Input.set_custom_mouse_cursor(
		CROSSHAIR,
		Input.CURSOR_ARROW,
		Vector2(CROSSHAIR.get_width() / 2, CROSSHAIR.get_height() / 2)
	)

func _physics_process(delta):
	var direction := Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)
	
	if direction != Vector2.ZERO:
		direction = direction.normalized()
	
	if is_dashing:
		dash_time -= delta
		velocity = dash_direction * dash_speed
		
		if dash_time <= 0:
			is_dashing = false
	else:
		if Input.is_action_pressed("focus"):
			enter_focus()
		elif  Input.is_action_just_released("focus"):
			exit_focus()
		var current_speed = speed
		shoot_timer -= delta

		if Input.is_action_just_pressed("shoot") and shoot_timer <= 0 and !is_dashing:
			shoot()
			shoot_timer = SHOOT_COOLDOWN

		velocity = direction * current_speed
		
		if can_dash() and Input.is_action_just_pressed("dash") and direction != Vector2.ZERO:
			start_dash(direction)
	
	last_dash += delta
	move_and_slide()
	animate(velocity)

func start_dash(dir: Vector2) -> void:
	is_dashing = true
	dash_time = dash_duration
	dash_direction = dir
	last_dash = 0


func can_dash() -> bool :
	if last_dash < DASH_COOLDOWN :
		return false
	return true
	
func animate(dv: Vector2) -> void:
	if dv.x != 0 :
		$AnimatedSprite2D.play("walk_left-right")
		$AnimatedSprite2D.flip_h = dv.x < 0
	elif dv.y != 0 :
		if dv.y > 0:
			$AnimatedSprite2D.play("walk_down")
		else :
			$AnimatedSprite2D.play("walk_up")
	else:
		$AnimatedSprite2D.stop()

func shoot():
	var bullet = OBJ_BULLET.instantiate()
	bullet.global_position = global_position
	
	var mouse_dir = (get_global_mouse_position() - global_position).normalized()
	bullet.velocity = mouse_dir * BULLET_SPEED
	bullet.target = "enemys"
	get_parent().add_child(bullet)

func enter_focus():
	Input.set_custom_mouse_cursor(
		FOCUSED_CROSSHAIR,
		Input.CURSOR_ARROW,
		Vector2(FOCUSED_CROSSHAIR.get_width() / 2, FOCUSED_CROSSHAIR.get_height() / 2)
	)
	speed = focus_speed

func exit_focus():
	Input.set_custom_mouse_cursor(
		CROSSHAIR,
		Input.CURSOR_ARROW,
		Vector2(CROSSHAIR.get_width() / 2, CROSSHAIR.get_height() / 2)
	)
	speed = original_speed
