extends Node

var current_day: int = 0
var current_event: int = -1

var ending: int = 0

var player: Player

func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")
	#next_event()
	FadeScreen.fade_in()
	

var base_events_array: Array = ["wake_up",
	"wake_up_dialog",
	"wash_hands_quest",
	"turn_lights_quest",
	"feed_the_cat_quest",
	"go_to_sleep_quest",
	"sleep"]

var days: Array = [
	{
		"wake_up_dialog": ["Доброе утро!", "День первый. Покорми кота."],
		"sleep_dialog": [""],
		"events": base_events_array
	},
	{
		"wake_up_dialog": ["Снова утро...", "Кот опять голодный."],
		"sleep_dialog": [""],
		"events": base_events_array
	},
	{
		"wake_up_dialog": ["День третий.", "Интересно, что сегодня хочет кот."],
		"sleep_dialog": [""],
		"events": base_events_array
	},
	{
		"wake_up_dialog": ["Уже четвёртый день.", "Рутина..."],
		"sleep_dialog": [""],
		"events": base_events_array
	},
	{
		"wake_up_dialog": ["Последний день.", "Сегодня всё решится."],
		"sleep_dialog": [""],
		"events": base_events_array
	},
	]

func next_event() -> void:
	current_event += 1
	player.enable()
	var event = get_current_event()
	match event:
		"wake_up":
			print("wake  up")
			player.disable()
			FadeScreen.fade_in()
			FadeScreen.fade_finished.connect(next_event, CONNECT_ONE_SHOT)
		"wake_up_dialog":
			print("wake  up dialog")
			player.disable()
			DialogManager.show_dialog(days[current_day]["wake_up_dialog"])
			DialogManager.dialog_finished.connect(next_event, CONNECT_ONE_SHOT)
		"wash_hands_quest":
			print("wash_hands_quest")
			QuestUi.show_quest("- Помыть руки")
		"feed_the_cat_quest":
			QuestUi.show_quest("- Покормить кота")
		"sleep":
			player.disable()
			FadeScreen.fade_out() 
			FadeScreen.fade_finished.connect(_on_day_finished, CONNECT_ONE_SHOT)


func _on_day_finished() -> void:
	current_day += 1
	current_event = -1
	next_event()
	
func get_current_event() -> String:
	return days[current_day]["events"][current_event]
	
func disable_player() -> void:
	if player:
		player.disable()
	
func enable_player() -> void:
	if player:
		player.enable()

func start_ending() -> void:
	FadeScreen.fade_in()
	get_tree().change_scene_to_file("res://scenes/endings/ending.tscn")
	
