signal visibility_state_changed
var visibility_state : get = _visibility_state_getter

var _js_game = null
var _js_on_visibility_state_changed = JavaScriptBridge.create_callback(_on_visibility_state_changed)

func _visibility_state_getter():
	return _js_game.visibilityState


func _init(js_game):
	_js_game = js_game
	_js_game.on('visibility_state_changed', _js_on_visibility_state_changed)


func _on_visibility_state_changed(args):
	emit_signal("visibility_state_changed", args[0])
