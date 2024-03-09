var type : get = _type_getter

var _js_device = null


func _type_getter():
	return _js_device.type


func _init(js_device):
	_js_device = js_device
