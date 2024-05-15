class_name GameOverMenu
extends Control

var finalUserId
var finalScore
var finalTimeSurvived
var finalLevel
@onready var httpRequest = $SendScores as SendScores
@onready var item_box = $CanvasLayer/ColorRect/HFlowContainer

func _ready():
	SignalBus.on_game_over.connect(on_game_over)
	SignalBus.send_collected_items.connect(show_collected_items)

func _on_main_menu_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/menu.tscn")

func _on_retry_button_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	

func show_collected_items(collected_items:Array):
	var counter = 0
	for item in collected_items:
		item.reparent(item_box, counter)
		counter +=1

func on_game_over(score, time, user_id, level):
	finalScore = score
	finalTimeSurvived = time
	finalUserId = user_id
	finalLevel = level
	$CanvasLayer/ColorRect/ScoreLabel.text = "Score: " + str(finalScore) 
	$CanvasLayer/ColorRect/TimeLabel.text = "Time: " + finalTimeSurvived
	get_tree().paused = true
	$CanvasLayer.visible = true

func _on_submit_button_pressed():
	httpRequest.send_request(finalScore, finalTimeSurvived, finalUserId, finalLevel)
