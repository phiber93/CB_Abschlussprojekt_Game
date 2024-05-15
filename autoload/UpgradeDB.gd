extends Node

const IMAGE_PATH = "res://art/upgrades/"

const UPGRADE = {
	"arrow1" : {
		"icon" : IMAGE_PATH + "arrow.png",
		"displayname" : "Bow and Arrow",
		"details" : "Shoot an arrow where your mouse is pointing",
		"level" : "Level: 1",
		"prerequisite": [],
		"type" : "weapon"
	},
	"arrow2" : {
		"icon" : IMAGE_PATH + "arrow.png",
		"displayname" : "Bow and Arrow",
		"details" : "Your arrows pass through an additional enemy",
		"level" : "Level: 2",
		"prerequisite": ["arrow1"],
		"type" : "weapon"
	},
	"arrow3" : {
		"icon" : IMAGE_PATH + "arrow.png",
		"displayname" : "Bow and Arrow",
		"details" : "Your arrows deal more damage",
		"level" : "Level: 3",
		"prerequisite": ["arrow2"],
		"type" : "weapon"
	},
	"arrow4" : {
		"icon" : IMAGE_PATH + "arrow.png",
		"displayname" : "Bow and Arrow",
		"details" : "Your arrows deal more damage and fire faster",
		"level" : "Level: 4",
		"prerequisite": ["arrow3"],
		"type" : "weapon"
	},
	"lightning1" : {
		"icon" : IMAGE_PATH + "lightning.png",
		"displayname" : "Lightning Spell",
		"details" : "Strike a random enemy with lightning",
		"level" : "Level: 1",
		"prerequisite": [],
		"type" : "weapon"
	},
	"lightning2" : {
		"icon" : IMAGE_PATH + "lightning.png",
		"displayname" : "Lightning Spell",
		"details" : "Strike an additional enemy",
		"level" : "Level: 2",
		"prerequisite": ["lightning1"],
		"type" : "weapon"
	},
	"lightning3" : {
		"icon" : IMAGE_PATH + "lightning.png",
		"displayname" : "Lightning Spell",
		"details" : "Strike an additional enemy and deal more damage",
		"level" : "Level: 3",
		"prerequisite": ["lightning2"],
		"type" : "weapon"
	},
	"lightning4" : {
		"icon" : IMAGE_PATH + "lightning.png",
		"displayname" : "Lightning Spell",
		"details" : "Your lightnings deal more damage",
		"level" : "Level: 4",
		"prerequisite": ["lightning3"],
		"type" : "weapon"
	},
	"knifes1" : {
		"icon" : IMAGE_PATH + "knifes.png",
		"displayname" : "Magic Knife",
		"details" : "A magic knife circles around you, damaging enemies",
		"level" : "Level: 1",
		"prerequisite": [],
		"type" : "weapon"
	},
	"knifes2" : {
		"icon" : IMAGE_PATH + "knifes.png",
		"displayname" : "Magic Knife",
		"details" : "Your knife deals more damage",
		"level" : "Level: 2",
		"prerequisite": ["knifes1"],
		"type" : "weapon"
	},
	"knifes3" : {
		"icon" : IMAGE_PATH + "knifes.png",
		"displayname" : "Magic Knife",
		"details" : "Gain an additional knife",
		"level" : "Level: 3",
		"prerequisite": ["knifes2"],
		"type" : "weapon"
	},
	"knifes4" : {
		"icon" : IMAGE_PATH + "knifes.png",
		"displayname" : "Magic Knife",
		"details" : "Your knifes rotate faster and deal more damage",
		"level" : "Level: 4",
		"prerequisite": ["knifes3"],
		"type" : "weapon"
	},
	"fireball1" : {
		"icon" : IMAGE_PATH + "fire_rod.png",
		"displayname" : "Fire Rod",
		"details" : "Automatically shoots an exploding fireball",
		"level" : "Level: 1",
		"prerequisite": [],
		"type" : "weapon"
	},
	"fireball2" : {
		"icon" : IMAGE_PATH + "fire_rod.png",
		"displayname" : "Fire Rod",
		"details" : "Shoots an additional fireball",
		"level" : "Level: 2",
		"prerequisite": ["fireball1"],
		"type" : "weapon"
	},
	"fireball3" : {
		"icon" : IMAGE_PATH + "fire_rod.png",
		"displayname" : "Fire Rod",
		"details" : "Shots deal additional damage",
		"level" : "Level: 3",
		"prerequisite": ["fireball2"],
		"type" : "weapon"
	},
	"fireball4" : {
		"icon" : IMAGE_PATH + "fire_rod.png",
		"displayname" : "Fire Rod",
		"details" : "Shoots an additional fireball",
		"level" : "Level: 4",
		"prerequisite": ["fireball3"],
		"type" : "weapon"
	},
	"aura1" : {
		"icon" : IMAGE_PATH + "forbidden_magic.png",
		"displayname" : "Forbidden Magic",
		"details" : "Cast a magic aura around you, that hurts enemies",
		"level" : "Level: 1",
		"prerequisite": [],
		"type" : "weapon"
	},
	"aura2" : {
		"icon" : IMAGE_PATH + "forbidden_magic.png",
		"displayname" : "Forbidden Magic",
		"details" : "Your aura deals more damage",
		"level" : "Level: 2",
		"prerequisite": ["aura1"],
		"type" : "weapon"
	},
	"aura3" : {
		"icon" : IMAGE_PATH + "forbidden_magic.png",
		"displayname" : "Forbidden Magic",
		"details" : "Your aura grows bigger",
		"level" : "Level: 3",
		"prerequisite": ["aura2"],
		"type" : "weapon"
	},
	"aura4" : {
		"icon" : IMAGE_PATH + "forbidden_magic.png",
		"displayname" : "Forbidden Magic",
		"details" : "Your aura grows bigger and deals more damage",
		"level" : "Level: 4",
		"prerequisite": ["aura3"],
		"type" : "weapon"
	},
	"attackspeed1" : {
		"icon" : IMAGE_PATH + "attack_speed.png",
		"displayname" : "Gloves of Speed",
		"details" : "You attack 10% faster",
		"level" : "Level: 1",
		"prerequisite": [],
		"type" : "upgrade"
	},
	"attackspeed2" : {
		"icon" : IMAGE_PATH + "attack_speed.png",
		"displayname" : "Gloves of Speed",
		"details" : "You attack 10% faster",
		"level" : "Level: 2",
		"prerequisite": ["attackspeed1"],
		"type" : "upgrade"
	},
	"attackspeed3" : {
		"icon" : IMAGE_PATH + "attack_speed.png",
		"displayname" : "Gloves of Speed",
		"details" : "You attack 10% faster",
		"level" : "Level: 3",
		"prerequisite": ["attackspeed2"],
		"type" : "upgrade"
	},
	"attackspeed4" : {
		"icon" : IMAGE_PATH + "attack_speed.png",
		"displayname" : "Gloves of Speed",
		"details" : "You attack 10% faster",
		"level" : "Level: 4",
		"prerequisite": ["attackspeed3"],
		"type" : "upgrade"
	},
	"movementspeed1" : {
		"icon" : IMAGE_PATH + "speed.png",
		"displayname" : "Boots of Swiftness",
		"details" : "You move 10% faster",
		"level" : "Level: 1",
		"prerequisite": [],
		"type" : "upgrade"
	},
	"movementspeed2" : {
		"icon" : IMAGE_PATH + "speed.png",
		"displayname" : "Boots of Swiftness",
		"details" : "You move 10% faster",
		"level" : "Level: 2",
		"prerequisite": ["movementspeed1"],
		"type" : "upgrade"
	},
	"movementspeed3" : {
		"icon" : IMAGE_PATH + "speed.png",
		"displayname" : "Boots of Swiftness",
		"details" : "You move 10% faster",
		"level" : "Level: 3",
		"prerequisite": ["movementspeed2"],
		"type" : "upgrade"
	},
	"movementspeed4" : {
		"icon" : IMAGE_PATH + "speed.png",
		"displayname" : "Boots of Swiftness",
		"details" : "You move 10% faster",
		"level" : "Level: 4",
		"prerequisite": ["movementspeed3"],
		"type" : "upgrade"
	},
	"bonusdamage1" : {
		"icon" : IMAGE_PATH + "bonus_damage.png",
		"displayname" : "Rage",
		"details" : "You deal 10% more damage",
		"level" : "Level: 1",
		"prerequisite": [],
		"type" : "upgrade"
	},
	"bonusdamage2" : {
		"icon" : IMAGE_PATH + "bonus_damage.png",
		"displayname" : "Rage",
		"details" : "You deal 10% more damage",
		"level" : "Level: 2",
		"prerequisite": ["bonusdamage1"],
		"type" : "upgrade"
	},
	"bonusdamage3" : {
		"icon" : IMAGE_PATH + "bonus_damage.png",
		"displayname" : "Rage",
		"details" : "You deal 10% more damage",
		"level" : "Level: 3",
		"prerequisite": ["bonusdamage2"],
		"type" : "upgrade"
	},
	"bonusdamage4" : {
		"icon" : IMAGE_PATH + "bonus_damage.png",
		"displayname" : "Rage",
		"details" : "You deal 10% more damage",
		"level" : "Level: 4",
		"prerequisite": ["bonusdamage3"],
		"type" : "upgrade"
	},
	"maxhealth1" :{
		"icon" : IMAGE_PATH + "max_health.png",
		"displayname" : "Potion of health",
		"details" : "Increase your maximum health by 10",
		"level" : "Level: 1",
		"prerequisite": [],
		"type" : "upgrade"
	},
	"maxhealth2" :{
		"icon" : IMAGE_PATH + "max_health.png",
		"displayname" : "Potion of health",
		"details" : "Increase your maximum health by 10",
		"level" : "Level: 2",
		"prerequisite": ["maxhealth1"],
		"type" : "upgrade"
	},
	"maxhealth3" :{
		"icon" : IMAGE_PATH + "max_health.png",
		"displayname" : "Potion of health",
		"details" : "Increase your maximum health by 10",
		"level" : "Level: 3",
		"prerequisite": ["maxhealth2"],
		"type" : "upgrade"
	},
	"maxhealth4" :{
		"icon" : IMAGE_PATH + "max_health.png",
		"displayname" : "Potion of health",
		"details" : "Increase your maximum health by 10",
		"level" : "Level: 4",
		"prerequisite": ["maxhealth3"],
		"type" : "upgrade"
	},
	"armor1" :{
		"icon" : IMAGE_PATH + "armor.png",
		"displayname" : "Iron Armor",
		"details" : "Take 10% less damage from enemies",
		"level" : "Level: 1",
		"prerequisite": [],
		"type" : "upgrade"
	},
	"armor2" :{
		"icon" : IMAGE_PATH + "armor.png",
		"displayname" : "Iron Armor",
		"details" : "Take 10% less damage from enemies",
		"level" : "Level: 2",
		"prerequisite": ["armor1"],
		"type" : "upgrade"
	},
	"armor3" :{
		"icon" : IMAGE_PATH + "armor.png",
		"displayname" : "Iron Armor",
		"details" : "Take 10% less damage from enemies",
		"level" : "Level: 3",
		"prerequisite": ["armor2"],
		"type" : "upgrade"
	},
	"armor4" :{
		"icon" : IMAGE_PATH + "armor.png",
		"displayname" : "Iron Armor",
		"details" : "Take 10% less damage from enemies",
		"level" : "Level: 4",
		"prerequisite": ["armor3"],
		"type" : "upgrade"
	},
	"regeneration1" :{
		"icon" : IMAGE_PATH + "regeneration.png",
		"displayname" : "Healing Pendant",
		"details" : "Slowly heal damage over time",
		"level" : "Level: 1",
		"prerequisite": [],
		"type" : "upgrade"
	},
	"regeneration2" :{
		"icon" : IMAGE_PATH + "regeneration.png",
		"displayname" : "Healing Pendant",
		"details" : "Increased healing",
		"level" : "Level: 2",
		"prerequisite": ["regeneration1"],
		"type" : "upgrade"
	},
	"regeneration3" :{
		"icon" : IMAGE_PATH + "regeneration.png",
		"displayname" : "Healing Pendant",
		"details" : "Increased healing",
		"level" : "Level: 3",
		"prerequisite": ["regeneration2"],
		"type" : "upgrade"
	},
	"regeneration4" :{
		"icon" : IMAGE_PATH + "regeneration.png",
		"displayname" : "Healing Pendant",
		"details" : "Increased healing",
		"level" : "Level: 4",
		"prerequisite": ["regeneration3"],
		"type" : "upgrade"
	},
	"food" : {
		"icon" : IMAGE_PATH + "bread.png",
		"displayname" : "Food",
		"details" : "Heals 5 damage",
		"level" : "N/A",
		"prerequisite": [],
		"type" : "item"
	},
}
