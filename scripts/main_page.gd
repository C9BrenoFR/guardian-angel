extends Control

func _on_play_pressed() -> void:
	print("Play Pressed")
	# get_tree().change_scene_to_file("res://cenas/game.tscn")


func _on_credit_pressed() -> void:
	# get_tree().change_scene_to_file("res://cenas/credit.tscn")
	print("Credit Pressed")


func _on_exit_pressed() -> void:
	get_tree().quit()
