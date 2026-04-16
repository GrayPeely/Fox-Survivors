extends Node2D
var dmg = Global.damage 
var attackS = Global.attackSpeed
var wait = 1
var swordNum = 1
var weaponType = Global.weaponPool[0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D/Sprite2D.frame = swordNum-1
	$AttackTime.wait_time = 2 / attackS
	update()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

func update():
	attackS = Global.attackSpeed
	dmg = Global.damage * weaponType["Damage"]
	
	$AttackTime.wait_time = 2 / attackS

func _on_area_2d_body_entered(body: Node2D) -> void:
	update()
	if body.is_in_group("mobs"):
		#print("yo")
		if body.has_method("damage"):
			body.damage(dmg) 

func get_enemy():
	var enemies = get_tree().get_nodes_in_group("mobs")
	var closest_enemy
	var shortest_dist = 1000000067
	
	for i in enemies:
		var dist = global_position.distance_to(i.global_position)
		if dist < shortest_dist and not Global.targeted.has(i):
			shortest_dist = dist
			closest_enemy = i
	return closest_enemy
	
func attackNorm():
	var target_enemy = get_enemy()
	if target_enemy:
		Global.targeted.append(target_enemy)
		look_at(target_enemy.global_position)
		var tween = create_tween()
		var original_pos = position
		var target_pos = original_pos + Vector2.RIGHT.rotated(rotation) * 60
		tween.tween_property(self, "position", target_pos, 0.1)
		tween.tween_property(self, "position", original_pos, 0.15)
		await tween.finished
		Global.targeted.erase(target_enemy)
