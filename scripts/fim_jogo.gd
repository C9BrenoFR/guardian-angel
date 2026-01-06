extends Node2D

@export var main_scene_path: String = "res://scenes/main_page.tscn"
@export var credits_scene_path: String = "res://scenes/credits.tscn"

func _ready() -> void:
	
	var is_victory: bool = false
	
	if PlayerStats.current_health <= 0:
		is_victory = false 
	elif Global.enemies_remaining <= 0:
		is_victory = true 
	
	_update_result_visibility(is_victory)


func _process(delta: float) -> void:
	pass


func _update_result_visibility(is_victory: bool) -> void:
	if has_node("Victory"):
		$Victory.visible = is_victory
	if has_node("Defeat"):
		$Defeat.visible = not is_victory


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
