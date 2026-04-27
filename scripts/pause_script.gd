extends CanvasLayer

@export var invItem: PackedScene
var itemNum 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	$Quit.hide()
	pass
	
func _input(event) -> void:
	if event.is_action_pressed("pause_game") :
		if Global.gameState == 1 :
			
			var is_paused = !get_tree().paused
			Global.pause = is_paused
			get_tree().paused = is_paused
			visible = is_paused
			inventoryUpdate()



func _on_button_pressed() -> void:
	var is_paused = !get_tree().paused
	get_tree().paused = is_paused
	visible = is_paused
	


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_end_run_pressed() -> void:
	_on_button_pressed()
	Global.playerHealth = 0
	get_tree().root.get_node("Main").playerHit()
	pass # Replace with function body.
	
func inventoryUpdate():
	for i in $ScrollContainer/GridContainer.get_children():
		i.queue_free()
		
	get_tree().call_group("inventory", "queue_free")
	
	for i in Global.itemsList.size():
		var box
		box = invItem.instantiate()
		$ScrollContainer/GridContainer.add_child(box)
		if Global.itemsList.size() == 0:
			return
		var imagev = Global.itemsList[i]["Icon"]
		box.create(imagev, "Item", Global.itemsList[i])
	
	for i in Global.weaponList.size():
		#print(str(i) + "weaponlist" + str(Global.weaponList.size()))
		var box
		box = invItem.instantiate()
		$ScrollContainer/GridContainer.add_child(box)
		#print()
		if Global.weaponList.size() == 0:
			return
		var weaponType = Global.weaponList[i].get_type()
		var imagev = weaponType["Icon"]
		box.create(imagev, "Weapon", weaponType)
		#print(Global.weaponList)
		pass
	
	
