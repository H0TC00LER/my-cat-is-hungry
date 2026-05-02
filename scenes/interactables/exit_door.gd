extends Area3D

func interact(player: Player) -> void:
	FadeScreen.fade_out()
	FadeScreen.fade_finished.connect(EventManager.start_ending, CONNECT_ONE_SHOT)
