

extends Control

@export var return_scene_path: String = "res://scenes/main_page.tscn"

func _on_exit_pressed() -> void:
	if get_tree().has_method("change_scene_to_file"):
		get_tree().change_scene_to_file(return_scene_path)
	else:
		get_tree().change_scene(return_scene_path)
