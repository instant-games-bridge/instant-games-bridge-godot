@tool
extends EditorPlugin

const SINGLETON_NAME = "Bridge"
const SINGLETON_PATH = "res://addons/instant_games_bridge/bridge.gd"
const POSTPROCESSOR_PLUGIN_PATH = "res://addons/instant_games_bridge/postprocessor.gd"
const SETTINGS_PATH = "addons/instant_games_bridge/general/"
const SETTINGS_GAME_DISTRIBUTION_GAME_ID_KEY = "game_distribution_game_id"
const SETTINGS_VK_PLAY_GAME_ID_KEY = "vk_play_game_id"


func _enter_tree():
	_add_project_settings(SETTINGS_PATH + SETTINGS_GAME_DISTRIBUTION_GAME_ID_KEY, TYPE_STRING, "")
	_add_project_settings(SETTINGS_PATH + SETTINGS_VK_PLAY_GAME_ID_KEY, TYPE_STRING, "")
	add_autoload_singleton(SINGLETON_NAME, SINGLETON_PATH)
	add_export_plugin(load(POSTPROCESSOR_PLUGIN_PATH).new())


func _exit_tree():
	remove_autoload_singleton(SINGLETON_NAME)


func _add_project_settings(name, type, default_value, hint = PROPERTY_HINT_NONE, hint_string = ""):
	if ProjectSettings.has_setting(name): 
		return
	
	ProjectSettings.set_setting(name, default_value)
	ProjectSettings.add_property_info({
		"name": name,
		"type": type,
		"hint": hint,
		"hint_string": hint_string
	})
