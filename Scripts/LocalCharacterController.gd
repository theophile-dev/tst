extends Node

var _character
var speed = 5000
var timer_network
func _ready():
	_character = get_parent()
	print("This character is controlled localy")
	timer_network = Timer.new()
	timer_network.autostart = true
	timer_network.wait_time = 0.015
	timer_network.connect("timeout", self, "SendData")
	add_child(timer_network)
	timer_network.start()

func _physics_process(delta):
	get_input()
	

func get_input():
	# Detect up/down/left/right keystate and only move when pressed
	_character.velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		_character.velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		_character.velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		_character.velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		_character.velocity.y -= 1
	_character.velocity = _character.velocity.normalized() * speed

func SendData():
	var entry = {}
	entry["time"] = OS.get_system_time_msecs()
	entry["x"] = _character.position.x
	entry["y"] = _character.position.y
	Server.SendData("character",entry)
	
