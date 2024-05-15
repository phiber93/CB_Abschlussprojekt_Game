extends Node2D

func _ready():
	SignalBus.spawnEnemy.connect(spawn_enemy)

func spawn_enemy(enemy: PackedScene):
	var new_enemy = enemy.instantiate()
	%PathFollow2D.progress_ratio = randf()
	var path_position = %PathFollow2D.global_position
	if path_position.y < 1600 and path_position.y > -1584 and path_position.x < 2050 and path_position.x > -2034:
		new_enemy.global_position = path_position
		add_child(new_enemy)
	elif new_enemy.is_in_group("death"):
		new_enemy.global_position = path_position
		add_child(new_enemy)
