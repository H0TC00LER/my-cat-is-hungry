class_name Item
extends RigidBody3D

var item_scene = preload("res://scenes/items/item.tscn")

func interact(player: Player) -> void:
	player.add_item(self)
	
func disable() -> void:
	$CollisionShape3D.disabled = true
	freeze = true
