extends Control

@onready var item_texture = $Background/ItemTexture
@onready var level1 = $Level1
@onready var level2 = $Level2
@onready var level3 = $Level3
@onready var level4 = $Level4

var item = null

func _ready():
	item_texture.texture = load(UpgradeDb.UPGRADE[item]["icon"])
	level1.color = Color.YELLOW
	level2.color = Color.BLACK
	level3.color = Color.BLACK
	level4.color = Color.BLACK

func update_display(level):
	if level == 2:
		level2.color = Color.YELLOW
	elif  level == 3:
		level3.color = Color.YELLOW
	else:
		level4.color = Color.YELLOW
