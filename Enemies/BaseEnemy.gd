class_name BaseEnemy
extends CharacterBody2D

@onready var player_node = get_tree().get_first_node_in_group("player")
@onready var damage_flash_timer = $DamageOverTimeFlash
@export var speed : float = 30.0
@export var health : float = 5.0
@export var DAMAGE_RATE : float = 0.1
@export var points: int = 1

var player_in_range = false
var damage_over_time = false
var damage_over_time_damage

func _ready():
	$AnimatedSprite2D.play("default")

func _physics_process(delta):
	var direction = global_position.direction_to(player_node.global_position)
	velocity = direction * speed
	move_and_slide()
	
	if player_in_range:
		player_node.take_damage(DAMAGE_RATE)
	
	if global_position.x < player_node.global_position.x:
		$AnimatedSprite2D.flip_h = true
	else :
		$AnimatedSprite2D.flip_h = false
	
	if damage_over_time:
		health -= damage_over_time_damage * delta
		if health <= 0:
				death()

		
func death():
	SignalBus.emit_enemy_death(points)
	queue_free()

func _on_damage_area_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true


func _on_damage_area_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false


func _on_hurtbox_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("damage") == 0:
			health -= area.damage * player_node.damage_modifier
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)
			if health <= 0:
				death()
			$AnimatedSprite2D.modulate = Color.RED
			await get_tree().create_timer(0.1).timeout
			$AnimatedSprite2D.modulate = Color.WHITE
	elif area.is_in_group("aura"):
		damage_over_time = true
		damage_over_time_damage = player_node.aura_damage
		damage_flash_timer.start()


func _on_hurtbox_area_exited(area):
	if area.is_in_group("aura"):
		damage_over_time = false
		damage_flash_timer.stop()


func _on_damage_over_time_flash_timeout():
	$AnimatedSprite2D.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	$AnimatedSprite2D.modulate = Color.WHITE
