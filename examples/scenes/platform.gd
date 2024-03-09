extends DetailedSceneBase


@onready var id_label: Label = $MarginContainer2/VBoxContainer/PlatformID
@onready var language_label: Label = $MarginContainer2/VBoxContainer/Language
@onready var payload_label: Label = $MarginContainer2/VBoxContainer/Payload
@onready var tld_label: Label = $MarginContainer2/VBoxContainer/Tld


func _ready() -> void:
	id_label.text = "Platform ID: " + Bridge.platform.id
	language_label.text = "Language: " + Bridge.platform.language
	payload_label.text = "Payload: " + str(Bridge.platform.payload)
	tld_label.text = "TLD: " + str(Bridge.platform.tld)


func _on_send_game_ready_button_pressed() -> void:
	Bridge.platform.send_message(Bridge.PlatformMessage.GAME_READY)


func _on_send_in_game_loading_started_button_pressed() -> void:
	Bridge.platform.send_message(Bridge.PlatformMessage.IN_GAME_LOADING_STARTED)


func _on_send_in_game_loading_stopped_button_pressed() -> void:
	Bridge.platform.send_message(Bridge.PlatformMessage.IN_GAME_LOADING_STOPPED)


func _on_send_gameplay_started_button_pressed() -> void:
	Bridge.platform.send_message(Bridge.PlatformMessage.GAMEPLAY_STARTED)


func _on_send_gameplay_stopped_button_pressed() -> void:
	Bridge.platform.send_message(Bridge.PlatformMessage.GAMEPLAY_STOPPED)


func _on_send_player_got_achievement_button_pressed() -> void:
	Bridge.platform.send_message(Bridge.PlatformMessage.PLAYER_GOT_ACHIEVEMENT)
