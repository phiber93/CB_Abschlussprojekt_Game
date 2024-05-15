class_name Player 
extends CharacterBody2D

var experience = 0
var level = 1
var collected_experience = 0
var damage_modifier :float = 1
var attack_speed_modifier :float = 1
var damage_reduction : float = 1

var player_state
var speed : float = 80
var max_health : float = 100
var current_health : float = 100
var regeneration_level = 0
var regeneration_factor : float = 0

#Attacks
var arrow = preload("res://weapons/arrow.tscn")
var lightning = preload("res://weapons/lightning_attack.tscn")
var knife = preload("res://weapons/knife_circle.tscn")
var fireball = preload("res://weapons/fire_ball.tscn")
var aura = preload("res://weapons/aura_attack.tscn")

#AttackNodes
@onready var attacks = $Attacks
@onready var arrow_timer = $Attacks/ArrowTimer
@onready var arrow_attack_timer = $Attacks/ArrowTimer/ArrowAttackTimer
@onready var lightning_timer = $Attacks/LightningTimer
@onready var lightning_attack_timer = $Attacks/LightningTimer/LightningAttackTimer
@onready var knife_circle = $Attacks/Knifes
@onready var fireball_timer = $Attacks/FireBallTimer
@onready var fireball_attack_timer = $Attacks/FireBallTimer/FireBallAttackTimer
var aura_instance = aura.instantiate()

#Upgrade
var collected_upgrades = ["arrow1"]

func _ready():
	$ProgressBar.max_value = max_health
	$ProgressBar.value = current_health
	SignalBus.on_upgrade_chosen.connect(upgrade_player)
	SignalBus.on_enemy_death.connect(on_enemy_death)
	attack()

func _physics_process(delta):
	var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
		movement(direction)
	
	if regeneration_level > 0:
		current_health += regeneration_factor * delta
		current_health = clamp(current_health, 0, max_health)
	play_anim(direction)
	
	$ProgressBar.value = current_health
	
func movement(direction):
	velocity = direction.normalized()*speed
	move_and_slide()

func play_anim(dir):
	if player_state == "idle":
		$AnimatedSprite2D.play("idle")
	
	if player_state == "walking":
		if dir.y == -1:
			$AnimatedSprite2D.play("walk-n")
		if dir.x == 1:
			$AnimatedSprite2D.play("walk-e")
		if dir.y == 1:
			$AnimatedSprite2D.play("walk-s")
		if dir.x == -1:
			$AnimatedSprite2D.play("walk-w")
		

func take_damage(damage):
	current_health -= damage * damage_reduction
	if current_health <= 0:
		end_game()

func end_game():
	SignalBus.emit_player_death()

#region Experience and level up

func on_enemy_death(points):
	var exp_required = calculate_experiencecap()
	collected_experience += points
	if experience + collected_experience >= exp_required:
		collected_experience -= exp_required - experience
		level += 1
		experience = 0
		exp_required = calculate_experiencecap()
		SignalBus.emit_leveled_up()
	else :
		experience += collected_experience
		collected_experience = 0

func calculate_experiencecap():
	var exp_cap = level
	if level < 20:
		exp_cap = level * 7
	elif level < 40:
		exp_cap = 95 * (level - 19) * 8
	else:
		exp_cap = 255 + (level - 39) * 12
	return exp_cap
#endregion

#region Arrow Attack
var arrow_ammo = 0
var arrow_baseammo = 1
var arrow_attackspeed : float = 1.5
var arrow_level = 1

func _on_arrow_timer_timeout():
	arrow_ammo += arrow_baseammo
	arrow_attack_timer.start()

func _on_arrow_attack_timer_timeout():
	if arrow_ammo > 0:
		var arrow_attack = arrow.instantiate()
		arrow_attack.position = position
		arrow_attack.target = get_global_mouse_position()
		arrow_attack.level = arrow_level
		add_child(arrow_attack)
		arrow_ammo -= 1
		if arrow_ammo > 0:
			arrow_attack_timer.start()
		else:
			arrow_attack_timer.stop()
#endregion

#region Lightning Attack
var lightning_ammo = 0
var lightning_baseammo = 1
var lightning_attackspeed : float = 5.0
var lightning_level = 0

func _on_lightning_timer_timeout():
	lightning_ammo += lightning_baseammo
	lightning_attack_timer.start()

func _on_lightning_attack_timer_timeout():
	if lightning_ammo > 0:
		if enemies_in_range.size() > 0:
			var lightning_attack = lightning.instantiate()
			lightning_attack.global_position = enemies_in_range.pick_random().global_position
			lightning_attack.level = lightning_level
			add_child(lightning_attack)
			lightning_ammo -= 1
			if lightning_ammo > 1:
				lightning_attack_timer.start()
			else:
				lightning_attack_timer.stop()
		else :
			lightning_ammo -= 1
#endregion

#region enemy detection system

var enemies_in_range = []

func _on_enemy_detection_area_body_entered(body):
	if body.is_in_group("enemy"):
		if not enemies_in_range.has(body):
			enemies_in_range.append(body)

func _on_enemy_detection_area_body_exited(body):
	if enemies_in_range.has(body):
		enemies_in_range.erase(body)
#endregion

#region magic knife attack

var knife_level = 0

func spawn_knifes():
	var current_knifes = knife_circle.get_children()
	for i in current_knifes:
		i.queue_free()
	if knife_level == 1 or knife_level == 2:
		var knife1 = knife.instantiate()
		knife1.level = knife_level
		knife_circle.add_child(knife1)
	if knife_level == 3 or knife_level == 4:
		var knife1 = knife.instantiate()
		knife1.level = knife_level
		knife_circle.add_child(knife1)
		var knife2 = knife.instantiate()
		knife2.level = knife_level
		knife2.set_position2()
		knife_circle.add_child(knife2)
#endregion

#region fireball attack

var fireball_ammo = 0
var fireball_baseammo = 1
var fireball_attackspeed : float = 10.0
var fireball_level = 0

func _on_fire_ball_timer_timeout():
	fireball_ammo += fireball_baseammo
	fireball_attack_timer.start()

func _on_fire_ball_attack_timer_timeout():
	if fireball_ammo > 0:
		if enemies_in_range.size() > 0:
			var fireball_attack = fireball.instantiate()
			fireball_attack.position = position
			fireball_attack.target = enemies_in_range.pick_random().global_position
			fireball_attack.level = arrow_level
			add_child(fireball_attack)
		fireball_ammo -= 1
		if fireball_ammo > 0:
			fireball_attack_timer.start()
		else:
			fireball_attack_timer.stop()
#endregion

#region Aura Attack

var aura_level = 0
var aura_base_damage = 1
var aura_damage = 1
var aura_size = 0.75
var aura_size_modifier = 1
#endregion

#region Start Attacks

func attack():
	if arrow_level > 0:
		arrow_timer.wait_time = arrow_attackspeed * attack_speed_modifier
		if arrow_timer.is_stopped():
			arrow_timer.start()
	
	if lightning_level > 0:
		lightning_timer.wait_time = lightning_attackspeed * attack_speed_modifier
		if lightning_timer.is_stopped():
			lightning_timer.start()
	
	if knife_level > 0:
		spawn_knifes()
	
	if fireball_level > 0:
		fireball_timer.wait_time = fireball_attackspeed * attack_speed_modifier
		if fireball_timer.is_stopped():
			fireball_timer.start()
	
	if aura_level > 0:
		aura_instance.scale.x = aura_size * aura_size_modifier
		aura_instance.scale.y = aura_size * aura_size_modifier
		aura_damage = aura_base_damage * damage_modifier
#endregion

#region Update player inventory

func upgrade_player(item):
	on_enemy_death(0)
	collected_upgrades.append(item)
	
	match item:
		"arrow1":
			arrow_level = 1
		"arrow2":
			arrow_level = 2
		"arrow3":
			arrow_level = 3
		"arrow4":
			arrow_level = 4
			arrow_attackspeed = 1.0
		"lightning1":
			lightning_level = 1
			lightning_baseammo = 1
		"lightning2":
			lightning_level = 2
			lightning_baseammo = 2
		"lightning3":
			lightning_level = 3
			lightning_baseammo = 3
		"lightning4":
			lightning_level = 4
			lightning_baseammo = 3
		"knifes1":
			knife_level = 1
		"knifes2":
			knife_level = 2
		"knifes3":
			knife_level = 3
		"knifes4":
			knife_level = 4
		"fireball1":
			fireball_level = 1
			fireball_baseammo = 1
		"fireball2":
			fireball_level = 2
			fireball_baseammo = 2
		"fireball3":
			fireball_level = 3
			fireball_baseammo = 2
		"fireball4":
			fireball_level = 4
			fireball_baseammo = 3
		"aura1":
			aura_level = 1
			attacks.add_child(aura_instance)
		"aura2":
			aura_level = 2
			aura_base_damage = 1.5
		"aura3":
			aura_level = 3
			aura_size_modifier = 1.2
		"aura4":
			aura_level = 4
			aura_base_damage = 2
			aura_size_modifier = 1.4
		"attackspeed1", "attackspeed2", "attackspeed3", "attackspeed4":
			attack_speed_modifier = attack_speed_modifier * 0.9
		"movementspeed1", "movementspeed2", "movementspeed3", "movementspeed4":
			speed = speed + 1.1
		"bonusdamage1", "bonusdamage2", "bonusdamage3", "bonusdamage4":
			damage_modifier = damage_modifier * 1.1
		"maxhealth1", "maxhealth2", "maxhealth3", "maxhealth4":
			max_health += 10
			$ProgressBar.max_value = max_health
			$ProgressBar.value = current_health
		"armor1", "armor2", "armor3", "armor4":
			damage_reduction = damage_reduction * 0.9
		"regeneration1":
			regeneration_level = 1
			regeneration_factor = 1
		"regeneration2":
			regeneration_level = 2
			regeneration_factor = 1.25
		"regeneration3":
			regeneration_level = 3
			regeneration_factor = 1.5
		"regeneration4":
			regeneration_level = 4
			regeneration_factor = 1.75
		"food":
			current_health += 5
			current_health = clamp(current_health, 0, max_health)
	attack()
#endregion
