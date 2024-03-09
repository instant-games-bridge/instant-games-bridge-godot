extends Node
class_name DetailedSceneBase


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://examples/scenes/main_menu.tscn")
