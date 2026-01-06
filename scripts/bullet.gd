extends Area2D

var velocity: Vector2
var duration := 3.0
var target: StringName = ""
@onready var damage = $"damage" as AudioStreamPlayer
@onready var enemy_dies = $"enemy-dies" as AudioStreamPlayer

func _physics_process(delta: float) -> void:
	position += velocity * delta
	duration -= delta
	if duration <= 0 :
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(target):
		if target == "player" :
			damage.reparent(get_tree().root)
			damage.play()
			damage.finished.connect(damage.queue_free)
			PlayerStats.take_damage(2)
		elif target == "enemys" :
			enemy_dies.reparent(get_tree().root)
			enemy_dies.play()
			enemy_dies.finished.connect(enemy_dies.queue_free)
			body.die()
		queue_free()
	elif body.is_in_group("wall"):
		queue_free()
