var is_supported : get = _is_supported_getter


func _is_supported_getter():
	return false


func get(options = null, callback: Callable = Callable()):
	if not callback.is_null():
		callback.call(false, null)
