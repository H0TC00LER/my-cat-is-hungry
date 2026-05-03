extends Area3D

func interact(player: Player) -> void:
	if player.current_item is not Axe:
		DialogManager.show_dialog(["Хм, разве тут раньше были доски?", "Что за чёрт?", "Интересно, может у меня есть что-то, чем их можно разломать?"])
	else:
		await  get_tree().process_frame
		player.current_item.queue_free()
		player.current_item = null
		queue_free()
