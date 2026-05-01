class_name Cat
extends StaticBody3D

var radioactivity: int = 0
var holiness: int = 0
var esotericity: int = 0
@onready var label_3d: Label3D = $Label3D

func interact(player: Player) -> void:
	if player.current_item is Food:
		var food: Food = player.current_item
		radioactivity += food.delta_radioactivity
		holiness += food.delta_holiness
		esotericity += food.delta_esotericity
		update_label()
		food.queue_free()
		player.current_item = null
		
func update_label() -> void:
	label_3d.text = "
		radioactivity: %s
		holiness: %s
		esotericity: %s
		" % [radioactivity, holiness, esotericity]
