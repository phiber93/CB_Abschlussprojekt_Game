class_name IngameOverlay
extends Control

var time: float = 0.0
var minutes: int = 0
var seconds: int = 0
var score: int = 0
@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	SignalBus.on_enemy_death.connect(on_enemy_death)
	SignalBus.on_player_death.connect(on_player_death)

func _process(delta):
	time +=delta
	seconds = fmod(time, 60)
	minutes= fmod(time, 3600)/60
	$GameTimer/Control/Minutes.text = "%02d:" % minutes
	$GameTimer/Control/Seconds.text = "%02d" % seconds
	$Score/Control/points.text = "Score: " + str(score)
	$ExperienceBar/Control/EXPBar.value = player.experience
	$ExperienceBar/Control/EXPBar.max_value = player.calculate_experiencecap()
	$ExperienceBar/Control/EXPBar/EXPLabel.text = "Level: " + str (player.level)

func get_time_formatted() -> String:
	return "%02d:%02d" % [minutes, seconds]

func on_enemy_death(points):
	score += points

func on_player_death():
	$GameTimer.visible = false
	$Score.visible = false
	SignalBus.emit_on_game_over(score, get_time_formatted(), player.level)
