extends Node2D

@export var initial_spawn_delay : float
@export var spawn_cooldown: float
@export var deactivate_spawn_time: float
@export var enemy: PackedScene

func _ready():
	$InitialTimer.wait_time = initial_spawn_delay
	$InitialTimer.start()
	$EndSpawnTimer.wait_time = initial_spawn_delay + deactivate_spawn_time
	$EndSpawnTimer.start()
	$SpawnCooldown.wait_time = spawn_cooldown

func _on_initial_timer_timeout():
	$SpawnCooldown.start()


func _on_spawn_cooldown_timeout():
	SignalBus.emit_spawn_enemy(enemy)


func _on_end_spawn_timer_timeout():
	$SpawnCooldown.stop()
