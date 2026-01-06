extends Enemy

const BULLET_SCENE = preload("res://scenes/bullet.tscn")

@export var move_speed := 90.0
@export var attack_range := 200.0
@export var bullet_speed := 300.0
@export var shoot_cooldown := 0.1
@onready var machine_gun = $"enemy-machinegun" as AudioStreamPlayer

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
			shoot()
			shoot_timer = shoot_cooldown

	move_and_slide()
	animate()

func chase_player():
	var dir = (player.global_position - global_position).normalized()
	velocity = dir * move_speed

func shoot():
	machine_gun.play()
	var bullet = BULLET_SCENE.instantiate()
	bullet.global_position = global_position

	var dir = (player.global_position - global_position).normalized()
	bullet.velocity = dir * bullet_speed
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
