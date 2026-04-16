extends Node
var gameState = 0
var playerHealth = 5
var round = 0
var money = 0
var level = 0
var damage = 1
var attackSpeed = 1
var targeted = []
var mob_amount = 0
var maxWeapons
var weaponList

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
	"Icon" : preload("res://Art/Swords/sword-1.png (3).png")}
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
