extends Node

var current_day: int = 0
var current_event: int = -1

var ending: int = 0

var player: Player

func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")
	next_event()
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
		"wake_up_dialog": ["Я сегодня снова проспал большую часть дня.", "Муся наверное проголодалась. Надо ее покормить.", "Но, надо сначала привести себя в порядок.
."],
		"sleep_dialog": ["Все не могу. Опять устал. Надо, чтобы Муся впитала пищу.", "Посмотрим, что будет завтра
."],
		"events": base_events_array
	},
	{
		"wake_up_dialog": ["Голова гудит. Все как будто в тумане.", "Интересно, что там с Мусей.", "Надо продолжить эксперименты
."],
		"sleep_dialog": ["Силы на исходе.", "Этот чертов вирус сна погубил нас всех.", "...", "Вот бы с Мусей все вышло."],
		"events": base_events_array
	},
	{
		"wake_up_dialog": ["Снова сначала.", "Беспокойная ночь.", "Надо узнать, как отреагировала Муся на вчерашнюю кормежку.", "Надеюсь, все будет не зря.
"],
		"sleep_dialog": ["Кровать так и манит. С каждым днем я все меньше бодрствую.", "Утро вечера мудренее
?"],
		"events": base_events_array
	},
	{
		"wake_up_dialog": ["Я все ближе и ближе к финалу.", "Еще два дня экспериментов и надеюсь, все получится
."],
		"sleep_dialog": ["Голова... кружится... Надо... поспать..."],
		"events": base_events_array
	},
	{
		"wake_up_dialog": ["Последний день.", "Завтра всё решится."],
		"sleep_dialog": ["Все. Завтра. Надеюсь... получится..."],
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
			QuestUi.show_quest("-Помыть руки")
		"feed_the_cat_quest":
			QuestUi.show_quest("-Покормить кота")
		"sleep":
			player.disable()
			FadeScreen.fade_out() 
			FadeScreen.fade_finished.connect(_on_day_finished, CONNECT_ONE_SHOT)


func _on_day_finished() -> void:
	current_day += 1
	current_event = -1
	next_event()
	
func complete_event(event_name: String) -> void:
	if get_current_event() == event_name:
		current_event += 1
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
	
