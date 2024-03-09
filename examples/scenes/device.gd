extends DetailedSceneBase


@onready var device_type_label: Label = $MarginContainer2/VBoxContainer/DeviceType


func _ready() -> void:
	device_type_label.text = "Device Type: " + Bridge.device.type
