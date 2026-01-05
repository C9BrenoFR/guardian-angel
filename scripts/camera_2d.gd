extends Camera2D


@onready var player = $"../Player"

func _physics_process(delta: float) -> void:
	position.y = player.position.y
	position.x = player.position.x
