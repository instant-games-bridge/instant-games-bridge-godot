var is_supported : get = _is_supported_getter
var is_native_popup_supported : get = _is_native_popup_supported_getter
var is_multiple_boards_supported : get = _is_multiple_boards_supported_getter
var is_set_score_supported : get = _is_set_score_supported_getter
var is_get_score_supported : get = _is_get_score_supported_getter
var is_get_entries_supported : get = _is_get_entries_supported_getter


func _is_supported_getter():
	return false


func _is_native_popup_supported_getter():
	return false


func _is_multiple_boards_supported_getter():
	return false


func _is_set_score_supported_getter():
	return false


func _is_get_score_supported_getter():
	return false


func _is_get_entries_supported_getter():
	return false


func set_score(options, callback: Callable = Callable()):
	if not callback.is_null():
		callback.call(false)


func get_score(options, callback: Callable = Callable()):
	if not callback.is_null():
		callback.call(false, 0)


func get_entries(options, callback: Callable = Callable()):
	if not callback.is_null():
		callback.call(false, [])


func show_native_popup(options, callback: Callable = Callable()):
	if not callback.is_null():
		callback.call(false)
