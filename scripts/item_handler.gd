extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	itemHandler()
	pass

func itemHandler():
	var speed = 1
	var dmg = 0
	var heal = 0
	var range = 60
	var attackSpeed = 1
	
	for i in Global.itemsList :
		#print(str(i))
		if i["Stat"] == "Speed" :
			speed += i["StatNum"]
		if i["Stat"] == "Heal" :
			heal += i["StatNum"]
		if i["Stat"] == "AttackSpeed" :
			attackSpeed += i["StatNum"]
		if i["Stat"] == "DMG" :
			dmg += i["StatNum"]
		if i["Stat"] == "Range" :
			range += i["StatNum"]
	#print(str(Global.roundHeal))
	Global.roundHeal = heal
	Global.speedMult = speed
	Global.damage = dmg
	Global.attackSpeed = attackSpeed
	Global.range = range
	
