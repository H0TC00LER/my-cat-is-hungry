extends Area3D

@onready var audio_stream_player_3d_2: AudioStreamPlayer3D = $AudioStreamPlayer3D2

func interact(player: Player) -> void:
	if EventManager.get_current_event() == "wash_hands_quest":
		audio_stream_player_3d_2.play()
		player.disable()
		FadeScreen.fade_out()
		FadeScreen.fade_finished.connect(_on_fade_out, CONNECT_ONE_SHOT)
	else:
		DialogManager.show_dialog(["Интересно, откуда идет вода.", "Наверное о некоторых вещах лучше не знать."])

func _on_fade_out() -> void:
	#$AudioStreamPlayer3D.play()
	#await get_tree().create_timer($AudioStreamPlayer3D.stream.get_length()).timeout
	FadeScreen.fade_in()
	FadeScreen.fade_finished.connect(_on_fade_in, CONNECT_ONE_SHOT)
	
func _on_fade_in() -> void:
	EventManager.complete_event("wash_hands_quest")
