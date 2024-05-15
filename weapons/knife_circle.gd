extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")

var level = 1
var damage : float = 2
var attack_size = 1.0
var speed : float = 7

func _ready():
	$Sprite2D.position = Vector2(75, 0)
	$CollisionShape2D.position = Vector2(75, 0)
	
	match level:
		1:
			damage = 2
			attack_size = 1.0
			speed = 5 + (1 - player.attack_speed_modifier) 
		2:
			damage = 4
			attack_size = 1.0
			speed = 5 + (1 - player.attack_speed_modifier) 
		3:
			damage = 4
			attack_size = 1.0
			speed = 5 + (1 - player.attack_speed_modifier) 
		4:
			damage = 8
			attack_size = 1.0
			speed = 7 + (1 - player.attack_speed_modifier) 
	
func _process(delta):
	rotation -= speed * delta

func set_position2():
	rotation -= 3.1
