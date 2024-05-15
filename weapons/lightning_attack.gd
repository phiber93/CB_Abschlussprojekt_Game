extends Area2D

var level = 1
var hp = 1
var speed : float = 200
var damage : float = 5
var attack_size = 1.0

func _ready():
	$AnimatedSprite2D.play("default")
	match level:
		1:
			hp = 1
			speed = 200
			damage = 10
			attack_size = 1.0
		2:
			hp = 1
			speed = 200
			damage = 10
			attack_size = 1.0
		3:
			hp = 1
			speed = 200
			damage = 20
			attack_size = 1.0
		4:
			hp = 1
			speed = 200
			damage = 40
			attack_size = 1.0



func _on_animated_sprite_2d_animation_finished():
	$CollisionShape2D.disabled = false
	await get_tree().create_timer(0.05).timeout
	$CollisionShape2D.disabled = true
	await get_tree().create_timer(0.3).timeout
	queue_free()
