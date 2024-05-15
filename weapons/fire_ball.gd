extends Area2D

var level = 1
var hp = 1
var speed : float = 200
var damage : float = 10
var alive = true

var target = Vector2.ZERO
var angle = Vector2.ZERO

@onready var player = get_tree().get_first_node_in_group("player")
@onready var hit_detector = $HitDetector
@onready var explosion = $Explosion

func _ready():
	$AnimatedSprite2D.visible = false
	$Sprite2D.visible = true
	angle = global_position.direction_to(target)
	rotation = angle.angle()
	match level:
		1:
			hp = 1
			speed = 200
			damage = 10
			
		2:
			hp = 1
			speed = 200
			damage = 10
		3:
			hp = 1
			speed = 200
			damage = 20
		4:
			hp = 1
			speed = 200
			damage = 20

func _physics_process(delta):
	if alive:
		position += angle * speed * delta

func enemy_hit(charge = 1):
	hp -= charge
	if hp <= 0:
		
		alive = false
		$Sprite2D.visible = false
		$AnimatedSprite2D.visible = true
		hit_detector.set_deferred("disabled", true)
		explosion.set_deferred("disabled", false)
		
		$AnimatedSprite2D.play("explosion")
		



func _on_animated_sprite_2d_animation_finished():
	queue_free()
