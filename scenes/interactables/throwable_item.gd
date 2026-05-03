extends Item

func _ready() -> void:
	collision_layer = 7
	collision_mask = 1
	
	axis_lock_linear_x = false
	axis_lock_linear_y = false
	axis_lock_linear_z = false
	axis_lock_angular_x = false
	axis_lock_angular_y = false
	axis_lock_angular_z = false 
