extends Area3D

func interact(player: Player) -> void:
	if EventManager.get_current_event() == "go_to_sleep_quest": 
		player.disable()
		FadeScreen.fade_out()
		FadeScreen.fade_finished.connect(_on_fade_out, CONNECT_ONE_SHOT)
	else:
		DialogManager.show_dialog(["Не сейчас."])
		
func _on_fade_out() -> void:
	FadeScreen.fade_in()
	FadeScreen.fade_finished.connect(_on_fade_in, CONNECT_ONE_SHOT)
	
func _on_fade_in() -> void:
	EventManager.complete_event("go_to_sleep_quest")
