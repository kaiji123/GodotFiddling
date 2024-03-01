extends Node2D
var player
var host
var join
var send
var username
var message
var user: String
var textbox

var _paused:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	player =  $CharacterBody2D
	# Assuming these nodes are children of this Node2D
	host = $CanvasLayer/PanelContainer/MarginContainer/GridContainer/host
	join = $CanvasLayer/PanelContainer/MarginContainer/GridContainer/join
	send = $CanvasLayer/PanelContainer/MarginContainer/GridContainer/send
	username = $CanvasLayer/username
	message = $CanvasLayer/message
	textbox = $CanvasLayer/Messages
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		_paused = not _paused
		get_tree().paused = _paused
		
		###
		
func _pause(value:bool):
	_paused = value
	#_pause_screen.visible = _paused
	# you would need to unpause using pause screen
	get_tree().paused = _paused


func _on_host_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(1257)
	get_tree().set_multiplayer(SceneMultiplayer.new(), get_path())
	multiplayer.multiplayer_peer= peer
	joined()

func _on_join_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_client('localhost', 1257);
	get_tree().set_multiplayer(SceneMultiplayer.new(), get_path())
	multiplayer.multiplayer_peer= peer
	joined()
	pass # Replace with function body.

func joined():
	host.hide()
	join.hide()
	username.hide()
	user = username.text


func _on_send_pressed():
	rpc('send_msg',user, message.text)
	message.text = ""
	
@rpc("any_peer",'call_local')
func send_msg(user, data):
	textbox.text += str(user , ":", data, '\n' )
	textbox.scroll_vertical = INF
	



func _on_load_pressed():
	var file = FileAccess.open('user://savegame.data', FileAccess.READ)
	var savedata=  file.get_var()
	player.global_position = savedata["player_pos"]  
	player.health = savedata['health'] 
	


	file.close()



func _on_save_pressed():
	var file = FileAccess.open('user://savegame.data', FileAccess.WRITE)
	var savedata= {}
	savedata["player_pos"] =  player.global_position
	savedata['health'] = player.health
	print(player.health)
	file.store_var(savedata)
	file.close()


func _on_unpause_pressed():
	get_tree().paused = false

