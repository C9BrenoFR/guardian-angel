extends Control

func _on_play_pressed() -> void:
	print("Play Pressed")
	# get_tree().change_scene_to_file("res://cenas/game.tscn")


func _on_credit_pressed() -> void:
	var scene := preload("res://scenes/credits.tscn")
	var inst = scene.instantiate()
	get_tree().get_root().add_child(inst)


func _on_exit_pressed() -> void:
	get_tree().quit()
