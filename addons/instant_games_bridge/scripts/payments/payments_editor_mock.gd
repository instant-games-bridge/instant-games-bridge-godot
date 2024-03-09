var is_supported : get = _is_supported_getter


func _is_supported_getter():
	return false


func purchase(purchase_id, callback: Callable = Callable()):
	if not callback.is_null():
		callback.call(false)


func consume_purchase(purchase_token, callback: Callable = Callable()):
	if not callback.is_null():
		callback.call(false)


func get_catalog(callback: Callable = Callable()):
	if not callback.is_null():
		callback.call(false, [])


func get_purchases(callback: Callable = Callable()):
	if not callback.is_null():
		callback.call(false, [])
