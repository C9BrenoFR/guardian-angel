extends Control

func _on_button_pressed() -> void:
	# Descomentar linha a baixo quando existir um jogo.
	# get_tree().change_scene_to_file("res://cenas/game.tscn")
	get_tree().quit()
	
