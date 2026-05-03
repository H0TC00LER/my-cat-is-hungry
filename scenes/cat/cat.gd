class_name Cat
extends StaticBody3D
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D
@onready var audio_stream_player_3d_2: AudioStreamPlayer3D = $AudioStreamPlayer3D2

var radioactivity: int = 0
var holiness: int = 0
var esotericity: int = 0

func interact(player: Player) -> void:
	if player.current_item is Pills:
		EventManager.is_pills_eaten = true
	if player.current_item and player.current_item.name == "Anime":
		EventManager.is_anime_eaten = true
	if player.current_item is Food:
		if EventManager.get_current_event() == "wash_hands_quest":
			DialogManager.show_dialog(["Сначала умыться."])
			return
		elif EventManager.get_current_event() == "go_to_sleep_quest":
			DialogManager.show_dialog(["На сегодня хватит. Пора спать."])
			return
			
		audio_stream_player_3d_2.play()
		
		var food: Food = player.current_item
		radioactivity += food.delta_radioactivity
		holiness += food.delta_holiness
		esotericity += food.delta_esotericity
		food.queue_free()
		player.current_item = null
		EventManager.complete_event("feed_the_cat_quest")
	else:
		audio_stream_player_3d.play()
		DialogManager.show_dialog(["Хорошая кошка...", "Муся: Мурррррррр"])
		
func update_cat() -> void:
	for ch in $cust.get_children():
		ch.hide()
	if radioactivity >= 25:
		$cust/tent1.show()
	if radioactivity >= 50:
		$cust/tent2.show()
	if radioactivity >= 75:
		$cust/tent2.show()
		
	if holiness >= 25:
		$cust/Eyes.show()
	if holiness >= 50:
		$cust/Nimb.show()
	if holiness >= 75:
		$cust/Wings.show()
		
	if esotericity >= 25:
		$cust/claws.show()
	if esotericity >= 50:
		$cust/horns.show()
	if esotericity >= 75:
		$cust/Legs.show()
