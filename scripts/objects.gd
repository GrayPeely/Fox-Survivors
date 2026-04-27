extends Area2D
var type = "Tree"
var PlayerClose = false
var cost = 5
var bought = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show()
	PlayerClose = false
	$PriceLabel.hide()
	$KeyLabel.hide()
	#print("yo its obj")
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	$PriceLabel.show()
	$KeyLabel.show()
	PlayerClose = true

func _on_area_exited(area: Area2D) -> void:
	$PriceLabel.hide()
	$KeyLabel.hide()
	PlayerClose = false
	
	
func chest_open() :
		if Global.money >= cost :
			bought = true
			var random = Global.itemPool.pick_random()
			Global.itemsList.append(random)
			Global.money -= cost
			$AnimatedSprite2D.hide()
			$Sprite2D.texture = random["Icon"]
			$Sprite2D.show()
			$KeyLabel.hide()
			$PriceLabel.hide()
			var timer = get_tree().create_timer(1.5)
			timer.timeout.connect(func(): queue_free())
		else:
			return
		pass
