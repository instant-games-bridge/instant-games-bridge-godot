extends Node


func _on_platform_button_pressed() -> void:
	get_tree().change_scene_to_file("res://examples/scenes/platform.tscn")


func _on_device_button_pressed() -> void:
	get_tree().change_scene_to_file("res://examples/scenes/device.tscn")


func _on_player_button_pressed() -> void:
	get_tree().change_scene_to_file("res://examples/scenes/player.tscn")


func _on_game_button_pressed() -> void:
	get_tree().change_scene_to_file("res://examples/scenes/game.tscn")


func _on_storage_button_pressed() -> void:
	get_tree().change_scene_to_file("res://examples/scenes/storage.tscn")


func _on_advertisement_button_pressed() -> void:
	get_tree().change_scene_to_file("res://examples/scenes/advertisement.tscn")
