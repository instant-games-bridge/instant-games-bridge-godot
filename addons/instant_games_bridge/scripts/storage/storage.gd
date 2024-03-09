var default_type : get = _default_type_getter


func _default_type_getter():
	return _js_storage.defaultType


var _js_storage = null
var _is_getting: bool = false
var _get_callback: Callable = Callable()
var _js_get_then = JavaScriptBridge.create_callback(_on_js_get_then)
var _js_get_catch = JavaScriptBridge.create_callback(_on_js_get_catch)

var _is_setting: bool = false
var _set_callback: Callable = Callable()
var _js_set_then = JavaScriptBridge.create_callback(_on_js_set_then)
var _js_set_catch = JavaScriptBridge.create_callback(_on_js_set_catch)

var _is_deleting: bool = false
var _delete_callback: Callable = Callable()
var _js_delete_then = JavaScriptBridge.create_callback(_on_js_delete_then)
var _js_delete_catch = JavaScriptBridge.create_callback(_on_js_delete_catch)


func is_supported(storage_type):
	return _js_storage.isSupported(storage_type)


func is_available(storage_type):
	return _js_storage.isAvailable(storage_type)


func get(key, callback: Callable = Callable(), storage_type = null):
	if _is_getting:
		return
	
	if callback.is_null():
		return
	
	var js_key
	var key_type = typeof(key)
	match key_type:
		TYPE_STRING:
			js_key = key
		TYPE_ARRAY:
			js_key = JavaScriptBridge.create_object("Array")
			for k in key:
				js_key.push(k)
		_:
			return
	
	_is_getting = true
	_get_callback = callback
	
	_js_storage.get(js_key, storage_type) \
		.then(_js_get_then) \
		.catch(_js_get_catch)


func set(key, value, callback: Callable = Callable(), storage_type = null):
	if _is_setting:
		return
	
	var js_key
	var js_value
	var key_type = typeof(key)
	match key_type:
		TYPE_STRING:
			js_key = key
			js_value = value
		TYPE_ARRAY:
			js_key = JavaScriptBridge.create_object("Array")
			js_value = JavaScriptBridge.create_object("Array")
			for k in key:
				js_key.push(k)
			for v in value:
				js_value.push(v)
		_:
			return
	
	_is_setting = true
	_set_callback = callback
	_js_storage.set(js_key, js_value, storage_type) \
		.then(_js_set_then) \
		.catch(_js_set_catch)


func delete(key, callback: Callable = Callable(), storage_type = null):
	if _is_deleting:
		return
	
	var js_key
	var key_type = typeof(key)
	match key_type:
		TYPE_STRING:
			js_key = key
		TYPE_ARRAY:
			js_key = JavaScriptBridge.create_object("Array")
			for k in key:
				js_key.push(k)
		_:
			return
	
	_is_deleting = true
	_delete_callback = callback
	_js_storage.delete(js_key, storage_type) \
		.then(_js_delete_then) \
		.catch(_js_delete_catch)


func _init(js_storage):
	_js_storage = js_storage


func _on_js_get_then(args):
	_is_getting = false
	if _get_callback.is_null():
		return
	
	var data = args[0]
	var data_type = typeof(data)
	match data_type:
		TYPE_OBJECT:
			var array = []
			for i in range(data.length):
				array.append(data[i])
			_get_callback.call(true, array)
		_:
			_get_callback.call(true, data)


func _on_js_get_catch(args):
	_is_getting = false
	if not _get_callback.is_null():
		_get_callback.call(false, null)


func _on_js_set_then(args):
	_is_setting = false
	if not _set_callback.is_null():
		_set_callback.call(true)


func _on_js_set_catch(args):
	_is_setting = false
	if not _set_callback.is_null():
		_set_callback.call(false)


func _on_js_delete_then(args):
	_is_deleting = false
	if not _delete_callback.is_null():
		_delete_callback.call(true)


func _on_js_delete_catch(args):
	_is_deleting = false
	if not _delete_callback.is_null():
		_delete_callback.call(false)
