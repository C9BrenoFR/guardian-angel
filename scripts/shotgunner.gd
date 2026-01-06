extends Enemy

const BULLET_SCENE = preload("res://scenes/bullet.tscn")

@export var move_speed := 90.0
@export var attack_range := 150.0
@export var bullet_speed := 300.0
@export var shots := 10
@export var shoot_cooldown := 1.2

var player: CharacterBody2D
var shoot_timer := 0.0


func _ready():
	player = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if not player:
		return

	var distance = global_position.distance_to(player.global_position)

	shoot_timer -= delta

	if distance > attack_range:
		chase_player()
	else:
		velocity = Vector2.ZERO
		if shoot_timer <= 0:
			shoot_cone()
			shoot_timer = shoot_cooldown

	move_and_slide()
	animate()

func chase_player():
	var dir = (player.global_position - global_position).normalized()
	velocity = dir * move_speed

func shoot_cone():
	var base_dir = (player.global_position - global_position).normalized()
	
	var cone_angle = deg_to_rad(30)
	var angle_step = cone_angle / (shots - 1)
	var start_angle = -cone_angle / 2

	for i in shots:
		var bullet = BULLET_SCENE.instantiate()
		bullet.global_position = global_position

		var angle_offset = start_angle + angle_step * i
		var dir = base_dir.rotated(angle_offset)

		bullet.velocity = dir * bullet_speed
		bullet.duration = 1.2
		bullet.target = "player"

		get_parent().add_child(bullet)


func animate():
	if velocity.length() > 1:
		if abs(velocity.x) > abs(velocity.y):
			$AnimatedSprite2D.play("walk_left-right")
			$AnimatedSprite2D.flip_h = velocity.x < 0
		elif velocity.y > 0:
			$AnimatedSprite2D.play("walk_down")
		else:
			$AnimatedSprite2D.play("walk_up")
	else:
		var dir = player.global_position - global_position
		if abs(dir.x) > abs(dir.y):
			$AnimatedSprite2D.play("shoot_left-right")
			$AnimatedSprite2D.flip_h = dir.x < 0
		elif dir.y > 0:
			$AnimatedSprite2D.play("shoot_down")
		else:
			$AnimatedSprite2D.play("shoot_up")
