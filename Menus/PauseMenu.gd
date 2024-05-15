extends Control

@onready var item_box = $CanvasLayer/ColorRect/HBoxContainer
@onready var item_display = preload("res://Menus/item_display.tscn")
@onready var player = get_tree().get_first_node_in_group("player")

var items

func _ready():
	SignalBus.on_upgrade_chosen.connect(update_item_display)
	SignalBus.on_player_death.connect(send_collected_items)
	for item in player.collected_upgrades:
		update_item_display(item)

func _unhandled_input(event):
	if get_tree().paused == false:
		if event.is_action_pressed("pause"):
			$CanvasLayer.visible = true
			get_tree().paused = true
	elif $CanvasLayer.visible == true:
		if event.is_action_pressed("pause"):
			_on_button_pressed()

func _on_button_pressed():
	$CanvasLayer.visible = false
	get_tree().paused = false

func _on_button_2_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Menus/menu.tscn")

func update_item_display(item):
	match UpgradeDb.UPGRADE[item]["level"]:
		"Level: 1":
			var displayed_item = item_display.instantiate()
			displayed_item.item = item
			item_box.add_child(displayed_item)
		"Level: 2":
			items = item_box.get_children()
			for i in items:
				if i.item == UpgradeDb.UPGRADE[item]["prerequisite"][0]:
					i.item = item
					i.update_display(2)
		"Level: 3":
			items = item_box.get_children()
			for i in items:
				if i.item == UpgradeDb.UPGRADE[item]["prerequisite"][0]:
					i.item = item
					i.update_display(3)
		"Level: 4":
			items = item_box.get_children()
			for i in items:
				if i.item == UpgradeDb.UPGRADE[item]["prerequisite"][0]:
					i.item = item
					i.update_display(4)

func send_collected_items():
	var collceted_items = item_box.get_children()
	SignalBus.emit_send_collected_items(collceted_items)
