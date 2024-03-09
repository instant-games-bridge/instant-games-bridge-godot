extends DetailedSceneBase


@onready var is_authorization_supported_label: Label = $MarginContainer2/VBoxContainer/IsAuthSupported
@onready var is_authorized_label: Label = $MarginContainer2/VBoxContainer/IsAuthorized
@onready var player_id_label: Label = $MarginContainer2/VBoxContainer/PlayerID
@onready var player_name_label: Label = $MarginContainer2/VBoxContainer/PlayerName
@onready var player_photo_rect: TextureRect = $MarginContainer2/VBoxContainer/PlayerPhoto
@onready var authorization_state_label: Label = $MarginContainer2/VBoxContainer/HBoxContainer2/AuthorizationState


func _ready() -> void:
	is_authorization_supported_label.text = "Is Auth Supported: " + str(Bridge.player.is_authorization_supported)
	_update_player_info()


func _on_authorize_button_pressed() -> void:
	authorization_state_label.text = "Loading.."
	Bridge.player.authorize(_on_player_authorize_completed)


func _on_player_authorize_completed(success: bool) -> void:
	authorization_state_label.text = "Authorization completed, success: " + str(success)
	
	if success:
		_update_player_info()


func _update_player_info() -> void:
	is_authorized_label.text = "Is Authorized: " + str(Bridge.player.is_authorized)
	player_id_label.text = "Player ID: " + str(Bridge.player.id)
	player_name_label.text = "Player name: " + str(Bridge.player.name)
	
	if Bridge.player.photos.size() > 0:
		_load_player_photo(Bridge.player.photos[0])


func _load_player_photo(url: String) -> void:
	var http_request: HTTPRequest = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", _on_load_player_photo_completed)
	var error: int = http_request.request(url)

	if error != OK:
		push_error("An error occurred in the HTTP request")


func _on_load_player_photo_completed(result, response_code, headers, body: PackedByteArray) -> void:
	var image: Image = Image.new()
	var error: int = image.load_png_from_buffer(body)
	if error != OK:
		push_error("Couldn't load the image")

	var texture: ImageTexture = ImageTexture.new()
	texture.create_from_image(image)
	player_photo_rect.texture = texture
