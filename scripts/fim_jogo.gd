extends Node2D
extends Node2D

@export var main_scene_path: String = "res://scenes/main_page.tscn"
@export var credits_scene_path: String = "res://scenes/credits.tscn"
@export var is_victory: bool = true

func _ready() -> void:
	_update_result_visibility()


func _process(delta: float) -> void:
	pass


func _update_result_visibility() -> void:
	if has_node("Victory"):
		$TextureRect2.visible = is_victory
	if has_node("Defeat"):
		$TextureRect3.visible = not is_victory


func _on_voltar_pressed() -> void:
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
