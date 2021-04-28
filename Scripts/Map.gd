extends Node2D

var characters

var character_node = preload("res://Scenes/Character.tscn")

func _ready():
	pass
	
func InstantiateMissingNodes(world_data):
	var node_own_by_server = get_tree().get_nodes_in_group("server")
	for player_id in world_data["character"]:
		if player_id == Server.network_id:
			break
		var new_node = true
		for n in node_own_by_server:
			if n.name == str(player_id):
				new_node = false
				break
		if new_node:
			SpawnCharacter(world_data["character"][player_id],player_id);

func ProcessWorldData(world_data):
	get_tree().call_group("server", "ReceiveData",world_data)
	

func SpawnCharacter(character_data, player_id):
	var character_node_instance = character_node.instance()
	if Server.network_id != player_id:
		character_node_instance.add_to_group("server")
	character_node_instance.set_position(Vector2(character_data["x"],character_data["y"]))
	character_node_instance.set_name(str(player_id))
	character_node_instance.player_id = player_id
	add_child(character_node_instance)

func DespawnCharacter(player_id):
	print("remove " + str(player_id))
	get_node(str(player_id)).queue_free()
