extends Node2D

const ENEMYS = [
	preload("res://scenes/shotgunner.tscn"),
	preload("res://scenes/gunner.tscn")
]

const WAVES = [10, 12, 14, 18, 20]
const TIME_BETWEEN_SPAWNS := 0.3

@onready var camera = $Camera2D
@onready var game_map: TileMapLayer = $chao

var current_wave := 0
var enemies_alive := 0

func _ready():
	update_label("Alguem esta vindo")
	PlayerStats.player = $Player
	start_wave()

func start_wave():
	if current_wave >= WAVES.size():
		update_label("TODAS AS HORDAS FINALIZADAS!")
		return win_level()

	var amount = WAVES[current_wave]

	spawn_wave(amount)


func spawn_wave(amount: int) -> void:
	for i in amount:
		spawn_enemy()
		await get_tree().create_timer(TIME_BETWEEN_SPAWNS).timeout

func spawn_enemy():
	var enemy_scene = ENEMYS.pick_random()
	var enemy = enemy_scene.instantiate()

	enemy.global_position = get_random_position_on_floor()
	add_child(enemy)

	enemies_alive += 1
	enemy.add_to_group("enemies")

	enemy.died.connect(_on_enemy_died)

func get_random_position_on_floor() -> Vector2:
	var used_cells = game_map.get_used_cells()
	var cell = used_cells.pick_random()

	return game_map.map_to_local(cell)

func _on_enemy_died():
	enemies_alive -= 1
	
	if enemies_alive <= 0:
	
		current_wave += 1
		update_label("Horda %d completa!" % current_wave)
		await get_tree().create_timer(2.0).timeout
		start_wave()
	update_label("Horda %d/%d | %d inimigos restantes" % [current_wave + 1, WAVES.size(), enemies_alive])

func win_level():
	get_tree().change_scene_to_file("res://scenes/fim_Jogo.tscn")

func update_label(new_text: String):
	var label = $CanvasLayer/Label
	label.text = new_text
