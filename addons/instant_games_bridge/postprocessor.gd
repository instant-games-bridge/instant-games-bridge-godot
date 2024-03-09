extends EditorExportPlugin

const INDEX_FILE_NAME = "index.html"
const JS_SDK_FILE_NAME = "instant-games-bridge.js"
const JS_SDK_PATH = "res://addons/instant_games_bridge/template/" + JS_SDK_FILE_NAME
const SETTINGS_PATH = "addons/instant_games_bridge/general/"
const SETTINGS_GAME_DISTRIBUTION_GAME_ID_KEY = "game_distribution_game_id"
const SETTINGS_VK_PLAY_GAME_ID_KEY = "vk_play_game_id"

var _path = null


func _export_begin(features, is_debug, path, flags):
	if features.has("web"):
		_path = path
		
		var file_from = FileAccess.open(JS_SDK_PATH, FileAccess.READ)
		
		var file_to = FileAccess.open(path.get_base_dir() + "/" + JS_SDK_FILE_NAME, FileAccess.WRITE)
		file_to.store_string(file_from.get_as_text())
		
		file_from = null
		file_to = null


func _export_end():
	if _path == null:
		return
	
	var game_distribution_game_id = ""
	var vk_play_game_id = ""
	
	if ProjectSettings.has_setting(SETTINGS_PATH + SETTINGS_GAME_DISTRIBUTION_GAME_ID_KEY):
		game_distribution_game_id = ProjectSettings.get(SETTINGS_PATH + SETTINGS_GAME_DISTRIBUTION_GAME_ID_KEY)
	
	if ProjectSettings.has_setting(SETTINGS_PATH + SETTINGS_VK_PLAY_GAME_ID_KEY):
		vk_play_game_id = ProjectSettings.get(SETTINGS_PATH + SETTINGS_VK_PLAY_GAME_ID_KEY)
	
	var index = FileAccess.open(_path.get_base_dir() + "/" + INDEX_FILE_NAME, FileAccess.READ_WRITE)
	
	var content = index.get_as_text()
	content = content.format({"game_distribution_game_id":game_distribution_game_id})
	content = content.format({"vk_play_game_id":vk_play_game_id})
	
	index.store_string(content)
	index = null
