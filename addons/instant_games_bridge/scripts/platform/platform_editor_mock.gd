var id : get = _id_getter
var payload : get = _payload_getter
var language : get = _language_getter
var tld : get = _tld_getter


func _id_getter():
	return Bridge.PlatformId.MOCK


func _payload_getter():
	return null


func _language_getter():
	return "en"


func _tld_getter():
	return null


func send_message(message):
	print("Send message: \"", message, "\"")
