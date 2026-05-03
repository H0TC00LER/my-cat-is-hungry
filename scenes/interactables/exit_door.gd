extends Area3D

func interact(player: Player) -> void:
	if EventManager.current_day == 4:
		FadeScreen.fade_out()
		FadeScreen.fade_finished.connect(EventManager.start_ending, CONNECT_ONE_SHOT)
	else:
		DialogManager.show_dialog(["Не сегодня. Но может быть в другой раз."])
