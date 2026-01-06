extends CharacterBody2D
class_name Enemy

signal died

func die():
	died.emit()
	queue_free()
	Global.enemies_killed += 1
