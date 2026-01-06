extends Node2D

@export var main_scene_path: String = "res://scenes/main_page.tscn"
@export var credits_scene_path: String = "res://scenes/credits.tscn"
@onready var lose_screen = $"lose-screen" as AudioStreamPlayer
@onready var win_screen = $"win-screen" as AudioStreamPlayer

var is_victory = false

func _ready() -> void:
	if Global.enemies_killed == Global.TOTAL_ENEMIES and PlayerStats.current_health > 0 :
		is_victory = true
	
	_update_result_visibility()


func _update_result_visibility() -> void:
	if has_node("Victory"):
		$Victory.visible = is_victory
		if is_victory:
			win_screen.play()
			
	if has_node("Defeat"):
		$Defeat.visible = not is_victory
		if not is_victory:
			lose_screen.play()

func _on_voltar_pressed() -> void:
	PlayerStats.reset_health()
	Global.reset_enemies()
	
	var target := main_scene_path
	if get_tree().has_method("change_scene_to_file"):
		get_tree().change_scene_to_file(target)
	else:
		get_tree().change_scene(target)


func _on_credit_pressed() -> void:
	var scene = load(credits_scene_path)
	if scene:
		var inst = scene.instantiate()
		get_tree().get_root().add_child(inst)


func _on_exit_pressed() -> void:
	get_tree().quit()
