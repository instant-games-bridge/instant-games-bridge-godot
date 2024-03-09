var is_supported : get = _is_supported_getter


func _is_supported_getter():
	return _js_payments.isSupported


var _js_payments = null
var _purchase_callback: Callable = Callable()
var _js_purchase_then = JavaScriptBridge.create_callback(_on_js_purchase_then)
var _js_purchase_catch = JavaScriptBridge.create_callback(_on_js_purchase_catch)
var _consume_purchase_callback: Callable = Callable()
var _js_consume_purchase_then = JavaScriptBridge.create_callback(_on_js_consume_purchase_then)
var _js_consume_purchase_catch = JavaScriptBridge.create_callback(_on_js_consume_purchase_catch)
var _get_catalog_callback: Callable = Callable()
var _js_get_catalog_then = JavaScriptBridge.create_callback(_on_js_get_catalog_then)
var _js_get_catalog_catch = JavaScriptBridge.create_callback(_on_js_get_catalog_catch)
var _get_purchases_callback: Callable = Callable()
var _js_get_purchases_then = JavaScriptBridge.create_callback(_on_js_get_purchases_then)
var _js_get_purchases_catch = JavaScriptBridge.create_callback(_on_js_get_purchases_catch)


func purchase(purchase_id, callback: Callable = Callable()):
	if not _purchase_callback.is_null():
		return
	
	_purchase_callback = callback
	
	var js_options = JavaScriptBridge.create_object("Object")
	js_options.yandex = purchase_id
	
	_js_payments.purchase(js_options) \
		.then(_js_purchase_then) \
		.catch(_js_purchase_catch)


func consume_purchase(purchase_token, callback: Callable = Callable()):
	if not _consume_purchase_callback.is_null():
		return

	_consume_purchase_callback = callback
	
	var js_options = JavaScriptBridge.create_object("Object")
	js_options.yandex = purchase_token
	
	_js_payments.consumePurchase(js_options) \
		.then(_js_consume_purchase_then) \
		.catch(_js_consume_purchase_catch)


func get_catalog(callback: Callable = Callable()):
	if not _get_catalog_callback.is_null():
		return

	_get_catalog_callback = callback

	_js_payments.getCatalog() \
		.then(_js_get_catalog_then) \
		.catch(_js_get_catalog_catch)


func get_purchases(callback: Callable = Callable()):
	if not _get_purchases_callback.is_null():
		return

	_get_purchases_callback = callback

	_js_payments.getPurchases() \
		.then(_js_get_purchases_then) \
		.catch(_js_get_purchases_catch)


func _init(js_payments):
	_js_payments = js_payments


func _on_js_purchase_then(args):
	if not _purchase_callback.is_null():
		_purchase_callback.call(true)
		_purchase_callback = Callable()


func _on_js_purchase_catch(args):
	if not _purchase_callback.is_null():
		_purchase_callback.call(false)
		_purchase_callback = Callable()


func _on_js_consume_purchase_then(args):
	if not _consume_purchase_callback.is_null():
		_consume_purchase_callback.call(true)
		_consume_purchase_callback = Callable()


func _on_js_consume_purchase_catch(args):
	if not _consume_purchase_callback.is_null():
		_consume_purchase_callback.call(false)
		_consume_purchase_callback = Callable()


func _on_js_get_catalog_then(args):
	if not _get_catalog_callback.is_null():
		var data = args[0]
		var data_type = typeof(data)
		match data_type:
			TYPE_OBJECT:
				var array = []
				for i in range(data.length):
					var js_catalog_item = data[i]
					var catalog_item = {
						"id": js_catalog_item.id,
						"title": js_catalog_item.title,
						"description": js_catalog_item.description,
						"icon": js_catalog_item.imageURI,
						"price": js_catalog_item.price,
						"price_value": js_catalog_item.priceValue,
						"price_currency_code": js_catalog_item.priceCurrencyCode
					}
					
					array.append(catalog_item)
				_get_catalog_callback.call(true, array)
			_:
				_get_catalog_callback.call(false, [])
		_get_catalog_callback = Callable()


# TODO: Refactor with static typing to remove call_func()
func _on_js_get_catalog_catch(args):
	if _js_get_catalog_catch != null:
		_js_get_catalog_catch.call_func(false, [])
		_js_get_catalog_catch = null


func _on_js_get_purchases_then(args):
	if not _get_purchases_callback.is_null():
		var data = args[0]
		var data_type = typeof(data)
		match data_type:
			TYPE_OBJECT:
				var array = []
				for i in range(data.length):
					var js_purchase_data = data[i]
					var purchase_data = {
						"id": js_purchase_data.productID,
						"token": js_purchase_data.purchaseToken
					}
					
					array.append(purchase_data)
				_get_purchases_callback.call(true, array)
			_:
				_get_purchases_callback.call(false, [])
		_get_purchases_callback = Callable()


# TODO: Refactor with static typing to remove call_func()
func _on_js_get_purchases_catch(args):
	if _js_get_catalog_catch != null:
		_js_get_catalog_catch.call_func(false, [])
		_js_get_catalog_catch = null
