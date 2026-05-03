extends Area3D

var activated: bool = false

func interact(player: Player):
	if not activated:
		var tween = create_tween()
		var final_destination: Vector3 = global_position - Vector3(0, 0, 1.5)
		tween.tween_property(self, "global_position", final_destination, 0.5)
		activated = true
