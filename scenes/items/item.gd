class_name Item
extends RigidBody3D

var item_scene = preload("res://scenes/items/item.tscn")

func _ready() -> void:
	collision_layer = 4
	collision_mask = 1
	
	axis_lock_linear_x = false
	axis_lock_linear_y = false
	axis_lock_linear_z = false
	axis_lock_angular_x = false
	axis_lock_angular_y = false
	axis_lock_angular_z = false  


func interact(player: Player) -> void:
	player.add_item(self)
	
func disable() -> void:
	$CollisionShape3D.disabled = true
	freeze = true
	
func activate() -> void:
	$CollisionShape3D.disabled = false
	freeze = false
