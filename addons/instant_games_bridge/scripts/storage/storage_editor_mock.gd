var default_type : get =_default_type_getter

const _FILE_EXTENSION = ".save"


func _default_type_getter():
	return Bridge.StorageType.LOCAL_STORAGE


func is_supported(storage_type):
	match storage_type:
		Bridge.StorageType.LOCAL_STORAGE:
			return true
		_:
			return false


func is_available(storage_type):
	match storage_type:
		Bridge.StorageType.LOCAL_STORAGE:
			return true
		_:
			return false


func get(key, callback: Callable = Callable(), storage_type = null):
	if callback.is_null():
		return
	
	if storage_type != null and not is_supported(storage_type):
		callback.call(false, null)
		return
	
	var key_type = typeof(key)
	var success = false
	var data = null
	
	match key_type:
		TYPE_STRING:
			data = _get(key)
			success = true
		
		TYPE_ARRAY:
			data = []
			for k in key:
				data.append(_get(k))
			success = true
		
		_:
			success = false
	
	callback.call(success, data)


func set(key, value, callback: Callable = Callable(), storage_type = null):
	# TODO: Check of callback.is_null() skipped?
	if storage_type != null and not is_supported(storage_type):
		callback.call(false)
		return
	
	var key_type = typeof(key)
	var success = false
	
	match key_type:
		TYPE_STRING:
			_set(key, value)
			success = true
		TYPE_ARRAY:
			for i in key.size():
				_set(key[i], value[i])
			success = true
		_:
			success = false
	
	if not callback.is_null():
		callback.call(success)


func delete(key, callback: Callable = Callable(), storage_type = null):
	if storage_type != null and not is_supported(storage_type):
		callback.call(false)
		return
	
	var key_type = typeof(key)
	var success = false
	
	match key_type:
		TYPE_STRING:
			_delete(key)
			success = true
		TYPE_ARRAY:
			for k in key:
				_delete(k)
			success = true
		_:
			success = false
	
	if not callback.is_null():
		callback.call(success)


func _get_file_path(key: String) -> String:
	return "user://" + key + _FILE_EXTENSION


func _get(key):
	var path: String = _get_file_path(key)
	
	if not FileAccess.file_exists(path):
		return null
	
	var file: FileAccess = FileAccess.open(path, FileAccess.READ)
	var data: String = file.get_as_text()
	file.close()
	
	if data.is_empty():
		return null
	else:
		return data


func _set(key, value):
	var path = _get_file_path(key)
	
	var file = FileAccess.open(path, FileAccess.WRITE)
	
	# Convert boolean value to a 1/0 number to then easily usse bool(data[...])
	# The problem is that a boolean is stored as 'true' / 'false' thus returning a String, 
	# which cannot be used with bool(...). Actual JavaScript implementation of storage
	# on the other hand returns read boolean vlaues as boolen-type objects.

	if (typeof(value) == TYPE_BOOL):
		value = 1 if value else 0
	
	if (typeof(value) != TYPE_STRING):
		value = str(value)
	
	file.store_string(value)
	file.close()


func _delete(key):
	var path = _get_file_path(key)
	
	if not FileAccess.file_exists(path):
		return
	
	DirAccess.remove_absolute(path)
