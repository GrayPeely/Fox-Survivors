extends Area2D
var value = 1
var truthNuke = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if not truthNuke:
		clampTS()
		truthNuke = true
	pass

func clampTS():
	position.x = clampf(position.x, -3150, 3150)
	position.y = clampf(position.y, -3150, 3150)
	set_process(false)

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player" :
		$CollisionShape2D.set_deferred("disabled", true)
		Global.money += value
		get_tree().root.get_node("Main/HUD").update_score(Global.money)
		queue_free()
	pass # Replace with function body.
