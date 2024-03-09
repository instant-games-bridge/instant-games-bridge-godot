var is_supported : get = _is_supported_getter


func _is_supported_getter():
	return false


var _js_remote_config = null
var _is_getting: bool = false
var _get_callback: Callable = Callable()
var _js_get_then = JavaScriptBridge.create_callback(_on_js_get_then)
var _js_get_catch = JavaScriptBridge.create_callback(_on_js_get_catch)


func get(options = null, callback: Callable = Callable()):
	if _is_getting:
		return
	
	if callback.is_null():
		return
	
	var js_options = JavaScriptBridge.create_object("Object")
	js_options.clientFeatures = JavaScriptBridge.create_object("Array")
	
	if options is Bridge.RemoteConfigGetYandexOptions:
		var client_features_type = typeof(options.client_features)
		match client_features_type:
			TYPE_DICTIONARY:
				for name in options.client_features:
					var js_feature = JavaScriptBridge.create_object("Object")
					js_feature.name = name
					js_feature.value = options.client_features[name]
					js_options.clientFeatures.push(js_feature)
	
	_is_getting = true
	_get_callback = callback
	
	_js_remote_config.get(js_options) \
		.then(_js_get_then) \
		.catch(_js_get_catch)


func _init(js_remote_config):
	_js_remote_config = js_remote_config


func _on_js_get_then(args):
	_is_getting = false
	if _get_callback.is_null():
		return
	
	var data = args[0]
	var data_type = typeof(data)
	match data_type:
		TYPE_OBJECT:
			var values = {}
			var keys = JavaScriptBridge.get_interface("Object").keys(data)
			for i in range(keys.length):
				values[keys[i]] = data[keys[i]]
			_get_callback.call(true, values)
		_:
			_get_callback.call(true, data)


func _on_js_get_catch(args):
	_is_getting = false
	if not _get_callback.is_null():
		_get_callback.call(false, null)
