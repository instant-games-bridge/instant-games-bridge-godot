var is_share_supported : get = _is_share_supported_getter
var is_join_community_supported : get = _is_join_community_supported_getter
var is_invite_friends_supported : get = _is_invite_friends_supported_getter
var is_create_post_supported : get = _is_create_post_supported_getter
var is_add_to_favorites_supported : get = _is_add_to_favorites_supported_getter
var is_add_to_home_screen_supported : get = _is_add_to_home_screen_supported_getter
var is_external_links_allowed : get = _is_external_links_allowed_getter
var is_rate_supported : get = _is_rate_supported_getter


func _is_share_supported_getter():
	return false


func _is_join_community_supported_getter():
	return false


func _is_invite_friends_supported_getter():
	return false


func _is_create_post_supported_getter():
	return false


func _is_add_to_favorites_supported_getter():
	return false


func _is_add_to_home_screen_supported_getter():
	return false


func _is_external_links_allowed_getter():
	return false


func _is_rate_supported_getter():
	return false


func share(options, callback: Callable = Callable()):
	if not callback.is_null():
		callback.call(false)


func join_community(options, callback: Callable = Callable()):
	if not callback.is_null():
		callback.call(false)


func invite_friends(callback: Callable = Callable()):
	if not callback.is_null():
		callback.call(false)


func create_post(options, callback: Callable = Callable()):
	if not callback.is_null():
		callback.call(false)


func add_to_favorites(callback: Callable = Callable()):
	if not callback.is_null():
		callback.call(false)


func add_to_home_screen(callback: Callable = Callable()):
	if not callback.is_null():
		callback.call(false)


func rate(callback: Callable = Callable()):
	if not callback.is_null():
		callback.call(false)
