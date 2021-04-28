extends Node

var _character

func _ready():
	_character = get_parent()
	print("This character is controlled by the server")

func ReceiveData(world_map):
	var character_data =  world_map["character"][_character.player_id]
	_character.position = Vector2(character_data["x"],character_data["y"])

