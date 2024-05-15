extends Button

@onready var label_name = $NameLabel
@onready var level_label = $LevelLabel
@onready var description_label = $DescriptionLabel
@onready var item_texture = $ColorRect/TextureRect

var item = null

func _ready():
	if item == null:
		item = "food"
	label_name.text = UpgradeDb.UPGRADE[item]["displayname"]
	level_label.text = UpgradeDb.UPGRADE[item]["level"]
	description_label.text = UpgradeDb.UPGRADE[item]["details"]
	item_texture.texture = load(UpgradeDb.UPGRADE[item]["icon"])


func _on_pressed():
	SignalBus.emit_on_upgrade_chosen(item)
