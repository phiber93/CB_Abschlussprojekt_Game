extends Area2D

var level = 1
var hp = 1
var speed : float = 200
var damage : float = 1

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	angle = global_position.direction_to(target)
	rotation = angle.angle()
	match level:
		1:
			hp = 1
			speed = 200
			damage = 5
			
		2:
			hp = 2
			speed = 200
			damage = 5
		3:
			hp = 2
			speed = 200
			damage = 10
		4:
			hp = 3
			speed = 200
			damage = 20

func _physics_process(delta):
	position += angle * speed * delta

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
