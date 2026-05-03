extends Area3D

func interact(player: Player):
	if EventManager.current_day == 4:
		DialogManager.show_dialog(["Наконец-то!"])
		queue_free()
	else:
		DialogManager.show_dialog(["Не поддается", "Но может получится открыть в другой день?"])
