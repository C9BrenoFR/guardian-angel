extends Area2D

var velocity: Vector2
var duration := 3.0
var target: StringName = ""

func _physics_process(delta: float) -> void:
	position += velocity * delta
	duration -= delta
	if duration <= 0 :
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(target):
		queue_free()
		if target == "player" :
			PlayerStats.take_damage(5)
		elif target == "enemys" :
			body.queue_free()
	elif body.is_in_group("wall"):
		queue_free()
