extends Node

signal health_changed(new_health, max_health)

var player: CharacterBody2D

var max_health: int = 100
var current_health: int = 100

func _ready():
	current_health = max_health

func take_damage(amount: int) -> void:
	current_health = max(0, current_health - amount)
	health_changed.emit(current_health, max_health)
	
	if current_health <= 0:
		end_game()

func heal(amount: int) -> void:
	current_health = min(max_health, current_health + amount)
	health_changed.emit(current_health, max_health)

func reset_health() -> void:
	current_health = max_health
	health_changed.emit(current_health, max_health)

func set_max_health(new_max: int) -> void:
	max_health = new_max
	current_health = min(current_health, max_health)
	health_changed.emit(current_health, max_health)

func get_health_percentage() -> float:
	if max_health <= 0:
		return 0.0
	return float(current_health) / float(max_health)

func end_game():
	for child in get_tree().root.get_children():
		if child is AudioStreamPlayer or child is AudioStreamPlayer2D:
			child.stop()
			child.queue_free()
			
	await handle_player_died(player.get_node("DeathSound"))
	change_to_game_over()

func handle_player_died(death_sound: AudioStreamPlayer2D) -> void:
	get_tree().paused = true
	
	process_mode = Node.PROCESS_MODE_ALWAYS
	death_sound.process_mode = Node.PROCESS_MODE_ALWAYS
	
	if death_sound.stream:
		death_sound.play()
		await death_sound.finished
	else:
		await get_tree().create_timer(1.5, true).timeout

func change_to_game_over() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/fim_Jogo.tscn")
