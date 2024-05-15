extends Node

signal on_game_over(score : int, time : String, user_id: int)
signal on_upgrade_chosen(item)
signal leveled_up
signal on_enemy_death(exp: int, points: int)
signal on_player_death
signal spawnEnemy(enemy: PackedScene)
signal send_collected_items(items: Array)

var user_id = 12

func _ready():
	user_id = JavaScriptBridge.eval("JSON.parse(sessionStorage.getItem('auth-user')).user_id", true)

func emit_on_game_over(score : int, time : String, level: int):
	on_game_over.emit(score, time, user_id, level)

func emit_on_upgrade_chosen(item):
	on_upgrade_chosen.emit(item)
	
func emit_leveled_up():
	leveled_up.emit()

func emit_enemy_death(points):
	on_enemy_death.emit(points)

func emit_player_death():
	on_player_death.emit()

func emit_spawn_enemy(enemy: PackedScene):
	spawnEnemy.emit(enemy)

func emit_send_collected_items(items: Array):
	send_collected_items.emit(items)
