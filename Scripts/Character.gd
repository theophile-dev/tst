extends KinematicBody2D

var is_local
var local_character_controller_node = preload("res://Scenes/LocalCharacterController.tscn")
var server_character_controller_node = preload("res://Scenes/ServerCharacterController.tscn")

var velocity = Vector2()
var player_id
var controller
var name_label
var animation_player

func SetIsLocal(local):
	is_local = local
	

func _ready():
	if !is_in_group("server"):
		controller = local_character_controller_node.instance()
		add_child(controller)
		#$Sprite.modulate = Color(0, 1, 1)
	else:
		controller = server_character_controller_node.instance()
		add_child(controller)
	name_label = get_node("Name")
	name_label.text = str(player_id)
	animation_player = get_node("AnimationPlayer")
	
		
func _physics_process(delta):
	if velocity == Vector2.ZERO:
		animation_player.stop(false)
	elif !animation_player.is_playing() :
		animation_player.play()
	move_and_collide(velocity * delta)

func ReceiveData(world_map):
	controller.ReceiveData(world_map)
