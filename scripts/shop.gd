extends CanvasLayer
var pool = Global.weaponPool
var weapon1 = pool[0]
var weapon2 = pool[1]
var weapon3 = pool[2]

signal exited
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func update():
	$"HBoxContainer/1/Sprite2D".texture = weapon1["Icon"]
	$"HBoxContainer/1/Op1".text = weapon1["Name"] +  "\nDamage: " + str(weapon1["Damage"]) + "\n$"+ str(weapon1["Cost"])
	
	$"HBoxContainer/2/Sprite2D".texture = weapon2["Icon"]
	$"HBoxContainer/2/Op2".text = weapon2["Name"] + "\nDamage: " + str(weapon2["Damage"]) + "\n$" + str(weapon2["Cost"])
	
	$"HBoxContainer/3/Sprite2D".texture = weapon3["Icon"]
	$"HBoxContainer/3/Op3".text = weapon3["Name"]+ "\nDamage: " + str(weapon3["Damage"]) + "\n$" + str(weapon3["Cost"])
	

func shopStart():
	pool.shuffle()
	weapon1 = pool[0]
	weapon2 = pool[1]
	weapon3 = pool[2]
	update()
	pass

func _on_exit_shop_pressed() -> void:
	exited.emit()
	pass # Replace with function body.

func _on_op_1_pressed() -> void:
	buy_weapon(weapon1)
	pass # Replace with function body.

func _on_op_2_pressed() -> void:
	buy_weapon(weapon2)
	pass # Replace with function body.

func _on_op_3_pressed() -> void:
	buy_weapon(weapon3)
	pass # Replace with function body

func buy_weapon(weaponSold):
	if(Global.money >= weaponSold["Cost"]):
		Global.money -= weaponSold["Cost"]
		get_parent().get_node("Player").newWeapon(weaponSold)
		get_parent().get_node("HUD").update_score(Global.money)
	pass
	


func _on_heal_button_pressed() -> void:
	if(Global.money >= 10):
		Global.money -= 10
		Global.playerHealth += 1
	pass # Replace with function body.
