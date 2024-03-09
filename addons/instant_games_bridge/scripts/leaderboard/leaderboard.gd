var is_supported : get = _is_supported_getter
var is_native_popup_supported : get = _is_native_popup_supported_getter
var is_multiple_boards_supported : get = _is_multiple_boards_supported_getter
var is_set_score_supported : get = _is_set_score_supported_getter
var is_get_score_supported : get = _is_get_score_supported_getter
var is_get_entries_supported : get = _is_get_entries_supported_getter


func _is_supported_getter():
	return _js_leaderboard.isSupported


func _is_native_popup_supported_getter():
	return _js_leaderboard.isNativePopupSupported


func _is_multiple_boards_supported_getter():
	return _js_leaderboard.isMultipleBoardsSupported


func _is_set_score_supported_getter():
	return _js_leaderboard.isSetScoreSupported


func _is_get_score_supported_getter():
	return _js_leaderboard.isGetScoreSupported


func _is_get_entries_supported_getter():
	return _js_leaderboard.isGetEntriesSupported


var _js_leaderboard = null
var _set_score_callback: Callable = Callable()
var _js_set_score_then = JavaScriptBridge.create_callback(_on_js_set_score_then)
var _js_set_score_catch = JavaScriptBridge.create_callback(_on_js_set_score_catch)
var _get_score_callback: Callable = Callable()
var _js_get_score_then = JavaScriptBridge.create_callback(_on_js_get_score_then)
var _js_get_score_catch = JavaScriptBridge.create_callback(_on_js_get_score_catch)
var _get_entries_callback: Callable = Callable()
var _js_get_entries_then = JavaScriptBridge.create_callback(_on_js_get_entries_then)
var _js_get_entries_catch = JavaScriptBridge.create_callback(_on_js_get_entries_catch)
var _show_native_popup_callback: Callable = Callable()
var _js_show_native_popup_then = JavaScriptBridge.create_callback(_on_js_show_native_popup_then)
var _js_show_native_popup_catch = JavaScriptBridge.create_callback(_on_js_show_native_popup_catch)


func set_score(options, callback: Callable = Callable()):
	if not _set_score_callback.is_null():
		return
	
	if not options is Bridge.SetScoreYandexOptions:
		if not callback.is_null():
			callback.call(false)
		return
	
	_set_score_callback = callback
	
	var js_options = JavaScriptBridge.create_object("Object")
	js_options.yandex = JavaScriptBridge.create_object("Object")
	js_options.yandex.score = options.score
	js_options.yandex.leaderboardName = options.leaderboard_name
	
	_js_leaderboard.setScore(js_options) \
		.then(_js_set_score_then) \
		.catch(_js_set_score_catch)


func get_score(options, callback: Callable = Callable()):
	if not _get_score_callback.is_null():
		return
	
	if not options is Bridge.GetScoreYandexOptions:
		if not callback.is_null():
			callback.call(false)
		return
	
	_get_score_callback = callback
	
	var js_options = JavaScriptBridge.create_object("Object")
	js_options.yandex = JavaScriptBridge.create_object("Object")
	js_options.yandex.leaderboardName = options.leaderboard_name
	
	_js_leaderboard.getScore(js_options) \
		.then(_js_get_score_then) \
		.catch(_js_get_score_catch)


func get_entries(options, callback: Callable = Callable()):
	if not _get_entries_callback.is_null():
		return
	
	if not options is Bridge.GetEntriesYandexOptions:
		if not callback.is_null():
			callback.call(false)
		return
	
	_get_entries_callback = callback
	
	var js_options = JavaScriptBridge.create_object("Object")
	js_options.yandex = JavaScriptBridge.create_object("Object")
	js_options.yandex.leaderboardName = options.leaderboard_name
	js_options.yandex.includeUser = options.include_user
	js_options.yandex.quantityAround = options.quantity_around
	js_options.yandex.quantityTop = options.quantity_top
	
	_js_leaderboard.getEntries(js_options) \
		.then(_js_get_entries_then) \
		.catch(_js_get_entries_catch)


func show_native_popup(options, callback: Callable = Callable()):
	if not _show_native_popup_callback.is_null():
		return
	
	if not options is Bridge.ShowNativePopupVkOptions:
		if not callback.is_null():
			callback.call(false)
		return
	
	_show_native_popup_callback = callback
	
	var js_options = JavaScriptBridge.create_object("Object")
	js_options.vk = JavaScriptBridge.create_object("Object")
	js_options.vk.userResult = options.user_result
	js_options.vk.global = options.global
	
	_js_leaderboard.showNativePopup(js_options) \
		.then(_js_show_native_popup_then) \
		.catch(_js_show_native_popup_catch)


func _init(js_leaderboard):
	_js_leaderboard = js_leaderboard


func _on_js_set_score_then(args):
	if not _set_score_callback.is_null():
		_set_score_callback.call(true)
		_set_score_callback = Callable()


func _on_js_set_score_catch(args):
	if not _set_score_callback.is_null():
		_set_score_callback.call(false)
		_set_score_callback = Callable()


func _on_js_get_score_then(args):
	if not _get_score_callback.is_null():
		_get_score_callback.call(true, args[0])
		_get_score_callback = Callable()


func _on_js_get_score_catch(args):
	if not _get_score_callback.is_null():
		_get_score_callback.call(false, 0)
		_get_score_callback = Callable()


func _on_js_get_entries_then(args):
	if not _get_entries_callback.is_null():
		var data = args[0]
		var data_type = typeof(data)
		match data_type:
			TYPE_OBJECT:
				var array = []
				for i in range(data.length):
					var js_entry = data[i]
					var entry = {
						"id": js_entry.id,
						"score": js_entry.score,
						"rank": js_entry.rank,
						"name": js_entry.name,
						"photos": []
					}
					
					for j in range(js_entry.photos.length):
						entry.photos.append(js_entry.photos[j])
					
					array.append(entry)
				_get_entries_callback.call(true, array)
			_:
				_get_entries_callback.call(false, [])
		_get_entries_callback = Callable()


func _on_js_get_entries_catch(args):
	if not _get_entries_callback.is_null():
		_get_entries_callback.call(false, [])
		_get_entries_callback = Callable()


func _on_js_show_native_popup_then(args):
	if not _show_native_popup_callback.is_null():
		_show_native_popup_callback.call(true)
		_show_native_popup_callback = Callable()


func _on_js_show_native_popup_catch(args):
	if not _show_native_popup_callback.is_null():
		_show_native_popup_callback.call(false)
		_show_native_popup_callback = Callable()
