signal banner_state_changed
signal interstitial_state_changed
signal rewarded_state_changed

var minimum_delay_between_interstitial : get = _minimum_delay_between_interstitial_getter
var is_banner_supported : get = _is_banner_supported_getter
var banner_state : get = _banner_state_getter
var interstitial_state : get = _interstitial_state_getter
var rewarded_state : get = _rewarded_state_getter


func _minimum_delay_between_interstitial_getter():
	return _js_advertisement.minimumDelayBetweenInterstitial

func _is_banner_supported_getter():
	return _js_advertisement.isBannerSupported
	
func _banner_state_getter():
	return _js_advertisement.bannerState

func _interstitial_state_getter():
	return _js_advertisement.interstitialState

func _rewarded_state_getter():
	return _js_advertisement.rewardedState

var _js_advertisement = null
var _js_on_banner_state_changed = JavaScriptBridge.create_callback(_on_banner_state_changed)
var _js_on_interstitial_state_changed = JavaScriptBridge.create_callback(_on_interstitial_state_changed)
var _js_on_rewarded_state_changed = JavaScriptBridge.create_callback(_on_rewarded_state_changed)


func set_minimum_delay_between_interstitial(value):
	_js_advertisement.setMinimumDelayBetweenInterstitial(value)


func show_banner(options = null):
	var js_options = JavaScriptBridge.create_object("Object")
	js_options.containerId = "banner-container"
	
	if options is Bridge.ShowBannerOptions:
		js_options.containerId = options.container_id

	_js_advertisement.showBanner(js_options)


func hide_banner():
	_js_advertisement.hideBanner()


func show_interstitial(ignore_delay: bool = false):
	_js_advertisement.showInterstitial(ignore_delay)


func show_rewarded():
	_js_advertisement.showRewarded()


func _init(js_advertisement):
	_js_advertisement = js_advertisement
	_js_advertisement.on('banner_state_changed', _js_on_banner_state_changed)
	_js_advertisement.on('interstitial_state_changed', _js_on_interstitial_state_changed)
	_js_advertisement.on('rewarded_state_changed', _js_on_rewarded_state_changed)


func _on_banner_state_changed(args):
	emit_signal("banner_state_changed", args[0])


func _on_interstitial_state_changed(args):
	emit_signal("interstitial_state_changed", args[0])


func _on_rewarded_state_changed(args):
	emit_signal("rewarded_state_changed", args[0])
