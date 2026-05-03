class_name Cat
extends StaticBody3D

var radioactivity: int = 0
var holiness: int = 0
var esotericity: int = 0

func interact(player: Player) -> void:
	if player.current_item is Food:
		var food: Food = player.current_item
		radioactivity += food.delta_radioactivity
		holiness += food.delta_holiness
		esotericity += food.delta_esotericity
		food.queue_free()
		player.current_item = null
		EventManager.complete_event("feed_the_cat_quest")
	else:
		DialogManager.show_dialog(["Хорошая кошка...", "Муся: Мурррррррр"])
