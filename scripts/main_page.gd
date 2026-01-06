extends Control

func _on_play_pressed() -> void:
	var target := "res://scenes/level01.tscn"
	if get_tree().has_method("change_scene_to_file"):
		get_tree().change_scene_to_file(target)
	else:
		get_tree().change_scene(target)


func _on_credit_pressed() -> void:
	var scene := preload("res://scenes/credits.tscn")
	var inst = scene.instantiate()
	get_tree().get_root().add_child(inst)


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_how_to_play_pressed() -> void:
	var scene := preload("res://scenes/how_to_play.tscn")
	var inst = scene.instantiate()
	get_tree().get_root().add_child(inst)
