extends Node

var network = NetworkedMultiplayerENet.new()

var SERVER_IP = "192.99.55.92"
#var SERVER_IP = "127.0.0.1"
var SERVER_PORT = 29500
var network_id
var map
func _ready():
	StartClient()
	map = get_node("../Map")

func StartClient():
	network.create_client(SERVER_IP,SERVER_PORT)
	get_tree().network_peer = network
	network.connect("connection_failed",self,"_OnConnecion_failed")
	network.connect("connection_succeeded",self,"_OnConnecion_succeeded")
	
remote func ReceiveWorldData(world_data):
	map.ProcessWorldData(world_data)
	
remote func SpawnCharacter(character_data,player_id):
	map.SpawnCharacter(character_data, player_id)
	
remote func InstantiateMissingNodes(world_data):
	map.InstantiateMissingNodes(world_data)

remote func DespawnCharacter(player_id):
	map.DespawnCharacter(player_id)
	
func SendData(data_type,entry):
	rpc_unreliable_id(1,"ReceiveData",data_type,entry)
	
func _OnConnecion_failed():
	print("Connection failed")

func _OnConnecion_succeeded():
	print("Connection successful")
	network_id = get_tree().get_network_unique_id()
