extends DetailedSceneBase


@onready var current_visibility_state_label: Label = $MarginContainer2/VBoxContainer/CurrentVisibilityState
@onready var last_visibility_states_label: Label = $MarginContainer2/VBoxContainer/LastVisibilityStates
var last_visibility_states: Array[String] = []


func _ready() -> void:
	current_visibility_state_label.text = "Current Visibility State: " + Bridge.game.visibility_state
	_on_visibility_state_changed(Bridge.game.visibility_state)
	Bridge.game.visibility_state_changed.connect(_on_visibility_state_changed)


func _on_visibility_state_changed(state: String) -> void:
	last_visibility_states.append(state)
	
	if last_visibility_states.size() > 5:
		last_visibility_states.remove_at(0)
	
	_update_last_states()


func _update_last_states() -> void:
	var text = "Last Visibility States: "
	
	for state in last_visibility_states:
		text += state + " -> "
	
	last_visibility_states_label.text = text
