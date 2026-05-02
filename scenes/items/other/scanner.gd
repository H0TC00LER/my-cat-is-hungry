class_name Scanner
extends Item

func scan(item: Item) -> void:
	await get_tree().process_frame
	if item is not Food:
		if item.description:
			DialogManager.show_dialog(item.description)
	else:
		item = item as Food
		var final_text: Array[String] = item.description.duplicate(true)
		var stats_text = "Параметры еды:
		- эзотеричность: %s
		- святость: %s
		- радиоктивность: %s" % [item.delta_esotericity, item.delta_holiness, item.delta_radioactivity]
		final_text.append(stats_text)
		
		DialogManager.show_dialog(final_text)
