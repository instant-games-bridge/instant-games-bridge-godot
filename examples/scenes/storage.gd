extends DetailedSceneBase


@onready var default_storage_type_label: Label = $MarginContainer2/VBoxContainer/DefaultStorageType

@onready var is_local_storage_supported_label: Label = \
	$MarginContainer2/VBoxContainer/HBoxContainer/IsLocalStorageSupported

@onready var is_local_storage_available_label: Label = \
	$MarginContainer2/VBoxContainer/HBoxContainer/IsLocalStorageAvailable

@onready var is_platform_internal_supported_label: Label = \
	$MarginContainer2/VBoxContainer/HBoxContainer4/IsPlatformInternalSupported

@onready var is_platform_internal_available_label: Label = \
	$MarginContainer2/VBoxContainer/HBoxContainer4/IsPlatformInternalAvailable

@onready var coins_input: LineEdit = $MarginContainer2/VBoxContainer/HBoxContainer2/CoinsInput
@onready var level_id_input: LineEdit = $MarginContainer2/VBoxContainer/HBoxContainer2/LevelIdInput
@onready var is_tutorial_completed_checkbox: CheckBox = $MarginContainer2/VBoxContainer/HBoxContainer2/TutorialCheckbox


func _ready():
	var local_storage_supported: bool = Bridge.storage.is_supported(Bridge.StorageType.LOCAL_STORAGE)
	var local_storage_available: bool = Bridge.storage.is_available(Bridge.StorageType.LOCAL_STORAGE)
	var platform_internal_supported: bool = Bridge.storage.is_supported(Bridge.StorageType.PLATFORM_INTERNAL)
	var platform_internal_available: bool = Bridge.storage.is_available(Bridge.StorageType.PLATFORM_INTERNAL)

	default_storage_type_label.text = "Default Storage Type: " + Bridge.storage.default_type
	is_local_storage_supported_label.text = "Is Local Storage Supported: " + str(local_storage_supported)
	is_local_storage_available_label.text = "Is Local Storage Available: " + str(local_storage_available)
	is_platform_internal_supported_label.text = "Is Platform Internal Supported: " + str(platform_internal_supported)
	is_platform_internal_available_label.text = "Is Platform Internal Available: " + str(platform_internal_available)


func _on_load_data_button_pressed():
	Bridge.storage.get(["coins_count", "level_id", "is_tutorial_completed"], _on_storage_get_completed)


func _on_save_data_button_pressed():
	Bridge.storage.set(
		["coins_count", "level_id", "is_tutorial_completed"], 
		[coins_input.text, level_id_input.text, is_tutorial_completed_checkbox.button_pressed], 
		_on_storage_set_completed
	)


func _on_delete_data_button_pressed():
	Bridge.storage.delete(["coins_count", "level_id", "is_tutorial_completed"], _on_storage_delete_completed)


func _on_storage_get_completed(success, data):
	if success:
		print(data)
		
		if data[0] != null:
			coins_input.text = str(data[0])
		else:
			coins_input.text = ""
			print("Coins is null")
		
		if data[1] != null:
			level_id_input.text = str(data[1])
		else:
			level_id_input.text = ""
			print("Level ID is null")
		
		if data[2] != null:
			is_tutorial_completed_checkbox.set_pressed_no_signal(bool(data[2]))
		else:
			is_tutorial_completed_checkbox.set_pressed_no_signal(false)
			print("Is Tutorial Completed is null")


func _on_storage_set_completed(success):
	coins_input.text = ""
	level_id_input.text = ""
	is_tutorial_completed_checkbox.set_pressed_no_signal(false)
	print("On Storage Set Completed, success: ", success)


func _on_storage_delete_completed(success):
	coins_input.text = ""
	level_id_input.text = ""
	is_tutorial_completed_checkbox.set_pressed_no_signal(false)
	print("On Storage Delete Completed, success: ", success)
