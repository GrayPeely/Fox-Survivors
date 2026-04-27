extends Node
var gameState = 0
var playerHealth = 5

var pause = false
var round = 0
var money = 0
var level = 0
var speedMult = 1
var roundHeal = 0
var damage = 1
var range = 60
var attackSpeed = 1
var targeted = []
var mob_amount = 0
var maxWeapons = []
var weaponList = []
var itemsList = []

var weaponPool = [
	{"Name" : "Basic Sword", 
	"Cost" : 10, "State" : 0, "Damage" : 2.5,
	"Icon" : preload("res://Art/Swords/sword-1.png.png")},
	
	{"Name" : "Iron Sword", 
	"Cost" : 20, "State" : 1, "Damage" : 5,
	"Icon" : preload("res://Art/Swords/sword-1.png (1).png")},
	
	{"Name" : "Lapis Sword", 
	"Cost" : 25, "State" : 2, "Damage" : 7,
	"Icon" : preload("res://Art/Swords/sword-1.png (2).png")},
	
	{"Name" : "Amber Sword", 
	"Cost" : 30, "State" : 3, "Damage" : 9,
	"Icon" : preload("res://Art/Swords/sword-1.png (3).png")},
	
	{"Name" : "Basic Axe", 
	"Cost" : 25, "State" : 0, "Damage" : 7,
	"Icon" : preload("res://Art/Axes/axe-1.png.png")},
	
	{"Name" : "Gold Axe", 
	"Cost" : 40, "State" : 1, "Damage" : 14,
	"Icon" : preload("res://Art/Axes/axe-1.png (3).png")},
	
	{"Name" : "Adorned Axe", 
	"Cost" : 65, "State" : 2, "Damage" : 21,
	"Icon" : preload("res://Art/Axes/axe-1.png (1).png")},
	
	{"Name" : "Dragonsteel Axe", 
	"Cost" : 150, "State" : 3, "Damage" : 28,
	"Icon" : preload("res://Art/Axes/axe-1.png (4).png")},
]
var basePool = weaponPool.duplicate(true)
	
var itemPool = [
	{"Name" : "Egg", 
	"Description" : "Heal 1 HP every new round", "Stat" : "Heal", "StatNum" : 1,
	"Icon" : preload("res://Art/Items/egg.png"), "Rarity" : "Common"},
	
	{"Name" : "Weights", 
	"Description" : "Adds 1 Damage", "Stat" : "DMG", "StatNum" : 1,
	"Icon" : preload("res://Art/Items/thyMuscle.png"), "Rarity" : "Common"},
	
	{"Name" : "Glasses", 
	"Description" : "Increases Range", "Stat" : "Range", "StatNum" : 15,
	"Icon" : preload("res://Art/Items/Glasses.png"), "Rarity" : "Common"},
	
	{"Name" : "Sneakers", 
	"Description" : "Increases Speed", "Stat" : "Speed", "StatNum" : 10,
	"Icon" : preload("res://Art/Items/thyShoe.png"), "Rarity" : "Common"},
	
	{"Name" : "Sugar", 
	"Description" : "Increases Attackspeed", "Stat" : "AttackSpeed", "StatNum" : 1,
	"Icon" : preload("res://Art/Player/fox sit1.png"), "Rarity" : "Common"}
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#itemsList.append(itemPool[0])
	#itemsList.append(itemPool[1])
	#for i in 4:
	#	itemsList.append(itemPool[4])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(Global.speedMult)
	pass
