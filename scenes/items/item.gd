class_name Item
extends RigidBody3D

var item_scene = preload("res://scenes/items/item.tscn")

@export var description: Array[String]

func _ready() -> void:
	collision_layer = 4
	collision_mask = 1
	
	axis_lock_linear_x = false
	axis_lock_linear_y = false
	axis_lock_linear_z = false
	axis_lock_angular_x = false
	axis_lock_angular_y = false
	axis_lock_angular_z = false  
	
	#var mesh_instance = get_child(1).get_child(0)
	#if mesh_instance and mesh_instance.mesh:
		#var shape = mesh_instance.mesh.create_convex_shape()
		#$CollisionShape3D.shape = shape


func interact(player: Player) -> void:
	if player.current_item == null:
		player.add_item(self)

	
func disable() -> void:
	$CollisionShape3D.disabled = true
	freeze = true
	
func activate() -> void:
	$CollisionShape3D.disabled = false
	freeze = false
