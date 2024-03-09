var is_share_supported : get = _is_share_supported_getter
var is_join_community_supported : get = _is_join_community_supported_getter
var is_invite_friends_supported : get = _is_invite_friends_supported_getter
var is_create_post_supported : get = _is_create_post_supported_getter
var is_add_to_favorites_supported : get = _is_add_to_favorites_supported_getter
var is_add_to_home_screen_supported : get = _is_add_to_home_screen_supported_getter
var is_external_links_allowed : get = _is_external_links_allowed_getter
var is_rate_supported : get = _is_rate_supported_getter


func _is_share_supported_getter():
	return _js_social.isShareSupported


func _is_join_community_supported_getter():
	return _js_social.isJoinCommunitySupported


func _is_invite_friends_supported_getter():
	return _js_social.isInviteFriendsSupported


func _is_create_post_supported_getter():
	return _js_social.isCreatePostSupported


func _is_add_to_favorites_supported_getter():
	return _js_social.isAddToFavoritesSupported


func _is_add_to_home_screen_supported_getter():
	return _js_social.isAddToHomeScreenSupported


func _is_external_links_allowed_getter():
	return _js_social.isExternalLinksAllowed


func _is_rate_supported_getter():
	return _js_social.isRateSupported


var _js_social = null
var _share_callback: Callable = Callable()
var _js_share_then = JavaScriptBridge.create_callback(_on_js_share_then)
var _js_share_catch = JavaScriptBridge.create_callback(_on_js_share_catch)
var _join_community_callback: Callable = Callable()
var _js_join_community_then = JavaScriptBridge.create_callback(_on_js_join_community_then)
var _js_join_community_catch = JavaScriptBridge.create_callback(_on_js_join_community_catch)
var _invite_friends_callback: Callable = Callable()
var _js_invite_friends_then = JavaScriptBridge.create_callback(_on_js_invite_friends_then)
var _js_invite_friends_catch = JavaScriptBridge.create_callback(_on_js_invite_friends_catch)
var _create_post_callback: Callable = Callable()
var _js_create_post_then = JavaScriptBridge.create_callback(_on_js_create_post_then)
var _js_create_post_catch = JavaScriptBridge.create_callback(_on_js_create_post_catch)
var _add_to_favorites_callback: Callable = Callable()
var _js_add_to_favorites_then = JavaScriptBridge.create_callback(_on_js_add_to_favorites_then)
var _js_add_to_favorites_catch = JavaScriptBridge.create_callback(_on_js_add_to_favorites_catch)
var _add_to_home_screen_callback: Callable = Callable()
var _js_add_to_home_screen_then = JavaScriptBridge.create_callback(_on_js_add_to_home_screen_then)
var _js_add_to_home_screen_catch = JavaScriptBridge.create_callback(_on_js_add_to_home_screen_catch)
var _rate_callback: Callable = Callable()
var _js_rate_then = JavaScriptBridge.create_callback(_on_js_rate_then)
var _js_rate_catch = JavaScriptBridge.create_callback(_on_js_rate_catch)


func share(options, callback: Callable = Callable()):
	if not _share_callback.is_null():
		return
	
	if not options is Bridge.ShareVkOptions:
		if not callback.is_null():
			callback.call(false)
		return
	
	_share_callback = callback
	
	var js_options = JavaScriptBridge.create_object("Object")
	js_options.vk = JavaScriptBridge.create_object("Object")
	js_options.vk.link = options.link
	
	_js_social.share(js_options) \
		.then(_js_share_then) \
		.catch(_js_share_catch)


func join_community(options, callback: Callable = Callable()):
	if not _join_community_callback.is_null():
		return
	
	if not options is Bridge.JoinCommunityVkOptions:
		if not callback.is_null():
			callback.call(false)
		return
	
	_join_community_callback = callback
	
	var js_options = JavaScriptBridge.create_object("Object")
	js_options.vk = JavaScriptBridge.create_object("Object")
	js_options.vk.groupId = options.group_id
	
	_js_social.joinCommunity(js_options) \
		.then(_js_join_community_then) \
		.catch(_js_join_community_catch)


func invite_friends(callback: Callable = Callable()):
	if not _invite_friends_callback.is_null():
		return

	_invite_friends_callback = callback
	_js_social.inviteFriends() \
		.then(_js_invite_friends_then) \
		.catch(_js_invite_friends_catch)


func create_post(options, callback: Callable = Callable()):
	if not _create_post_callback.is_null():
		return
	
	if not options is Bridge.CreatePostVkOptions:
		if not callback.is_null():
			callback.call(false)
		return
	
	_create_post_callback = callback
	
	var js_options = JavaScriptBridge.create_object("Object")
	js_options.vk = JavaScriptBridge.create_object("Object")
	js_options.vk.message = options.message
	js_options.vk.attachments = options.attachments
	
	_js_social.createPost(js_options) \
		.then(_js_create_post_then) \
		.catch(_js_create_post_catch)


func add_to_favorites(callback: Callable = Callable()):
	if not _add_to_favorites_callback.is_null():
		return

	_add_to_favorites_callback = callback
	_js_social.addToFavorites() \
		.then(_js_add_to_favorites_then) \
		.catch(_js_add_to_favorites_catch)


func add_to_home_screen(callback: Callable = Callable()):
	if not _add_to_home_screen_callback.is_null():
		return

	_add_to_home_screen_callback = callback
	_js_social.addToHomeScreen() \
		.then(_js_add_to_home_screen_then) \
		.catch(_js_add_to_home_screen_catch)


func rate(callback: Callable = Callable()):
	if not _rate_callback.is_null():
		return

	_rate_callback = callback
	_js_social.rate() \
		.then(_js_rate_then) \
		.catch(_js_rate_catch)


func _init(js_social):
	_js_social = js_social


func _on_js_share_then(args):
	if not _share_callback.is_null():
		_share_callback.call(true)
		_share_callback = Callable()


func _on_js_share_catch(args):
	if not _share_callback.is_null():
		_share_callback.call(false)
		_share_callback = Callable()


func _on_js_join_community_then(args):
	if not _join_community_callback.is_null():
		_join_community_callback.call(true)
		_join_community_callback = Callable()


func _on_js_join_community_catch(args):
	if not _join_community_callback.is_null():
		_join_community_callback.call(false)
		_join_community_callback = Callable()


func _on_js_invite_friends_then(args):
	if not _invite_friends_callback.is_null():
		_invite_friends_callback.call(true)
		_invite_friends_callback = Callable()


func _on_js_invite_friends_catch(args):
	if not _invite_friends_callback.is_null():
		_invite_friends_callback.call(false)
		_invite_friends_callback = Callable()


func _on_js_create_post_then(args):
	if not _create_post_callback.is_null():
		_create_post_callback.call(true)
		_create_post_callback = Callable()


func _on_js_create_post_catch(args):
	if not _create_post_callback.is_null():
		_create_post_callback.call(false)
		_create_post_callback = Callable()


func _on_js_add_to_favorites_then(args):
	if not _add_to_favorites_callback.is_null():
		_add_to_favorites_callback.call(true)
		_add_to_favorites_callback = Callable()


func _on_js_add_to_favorites_catch(args):
	if not _add_to_favorites_callback.is_null():
		_add_to_favorites_callback.call(false)
		_add_to_favorites_callback = Callable()


func _on_js_add_to_home_screen_then(args):
	if not _add_to_home_screen_callback.is_null():
		_add_to_home_screen_callback.call(true)
		_add_to_home_screen_callback = Callable()


func _on_js_add_to_home_screen_catch(args):
	if not _add_to_home_screen_callback.is_null():
		_add_to_home_screen_callback.call(false)
		_add_to_home_screen_callback = Callable()


func _on_js_rate_then(args):
	if not _rate_callback.is_null():
		_rate_callback.call(true)
		_rate_callback = Callable()


func _on_js_rate_catch(args):
	if not _rate_callback.is_null():
		_rate_callback.call(false)
		_rate_callback = Callable()
