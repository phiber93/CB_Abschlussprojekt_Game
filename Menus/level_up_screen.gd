extends Control

@onready var player = get_tree().get_first_node_in_group("player")
@onready var upgrades = $LevelUpScreen/ColorRect/UpgradeOptions
@onready var upgrade_template = preload("res://Menus/upgrade_option.tscn")
var upgrade_options = []

func _ready():
	SignalBus.leveled_up.connect(on_level_up)
	SignalBus.on_upgrade_chosen.connect(continue_game)

func on_level_up():
	await get_tree().create_timer(0.05).timeout
	get_tree().paused = true
	var counter = 0
	var upgrade_option_count = 3
	while counter < upgrade_option_count:
		var item = get_random_item()
		var new_upgrade = upgrade_template.instantiate()
		new_upgrade.item = item
		upgrade_options.append(item)
		upgrades.add_child(new_upgrade)
		counter += 1
	$LevelUpScreen.visible = true

	
func get_random_item():
	var collected_upgrades = player.collected_upgrades
	var dblist = []
	for i in UpgradeDb.UPGRADE:
		if i in collected_upgrades:
			pass
		elif i in upgrade_options:
			pass
		elif UpgradeDb.UPGRADE[i]["type"] == "item":
			pass
		elif UpgradeDb.UPGRADE[i]["prerequisite"].size() > 0:
			for n in UpgradeDb.UPGRADE[i]["prerequisite"]:
				if not n in collected_upgrades:
					pass
				else:
					dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0 :
		var randomitem = dblist.pick_random()
		return randomitem
	else:
		return null

func continue_game(_item):
	upgrade_options.clear()
	var upgrades_loaded = upgrades.get_children()
	for i in upgrades_loaded:
		i.queue_free()
	$LevelUpScreen.visible = false
	get_tree().paused = false
