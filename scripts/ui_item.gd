extends Control
var desc

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Descript.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func create(img, typeA, item):
	$TextureRect.texture = img
	#print(str(typeA) + " " + str(item))
	if(typeA == "Item"):
		$Descript/Label.text = item["Name"] + " : " + item["Description"]
	if(typeA == "Weapon"):
		$Descript/Label.text = item["Name"] + " - DMG : " + str(item["Damage"])
	
	


func _on_mouse_entered() -> void:
	$Descript.show()
	pass # Replace with function body.



func _on_mouse_exited() -> void:
	$Descript.hide()
	pass # Replace with function body.
