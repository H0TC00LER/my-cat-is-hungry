extends Node

var current_day: int = 0
var current_event: int = -1

#0 - выход
#1 - эзотеричность
#2 - радиоктивность
#3 - святость
#4 - нормальная
#5 - шиза
#6 - аниме
var ending: int = 0

func reset() -> void:
	current_day = 0
	current_event = -1
	ending = 0
	player = null
	is_pills_eaten = false
	is_anime_eaten = false
	cat = null


var is_pills_eaten: bool = false
var is_anime_eaten: bool = false

var player: Player
var cat: Cat

func _ready() -> void:
	if get_tree().current_scene.scene_file_path == "res://scenes/levels/main_menu.tscn":
		return
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")
	cat = get_tree().get_first_node_in_group("cat")
	next_event()
	FadeScreen.fade_in()
	_update_world()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		get_tree().quit()


var base_events_array: Array = ["wake_up",
	"wake_up_dialog",
	"wash_hands_quest",
	"feed_the_cat_quest",
	"go_to_sleep_quest",
	"sleep"]

var days: Array = [
	{
		"wake_up_dialog": ["Я сегодня снова проспал большую часть дня.", "Муся наверное проголодалась. Надо ее покормить.", "Но, надо сначала привести себя в порядок.."],
		"sleep_dialog": ["Все не могу. Опять устал. Надо, чтобы Муся впитала пищу.", "Посмотрим, что будет завтра."],
		"events": base_events_array
	},
	{
		"wake_up_dialog": ["Голова гудит. Все как будто в тумане.", "Интересно, что там с Мусей.", "Надо продолжить эксперименты."],
		"sleep_dialog": ["Силы на исходе.", "Этот чертов вирус сна погубил нас всех.", "...", "Вот бы с Мусей все вышло."],
		"events": base_events_array
	},
	{
		"wake_up_dialog": ["Снова сначала.", "Беспокойная ночь.", "Надо узнать, как отреагировала Муся на вчерашнюю кормежку.", "Надеюсь, все будет не зря."],
		"sleep_dialog": ["Кровать так и манит. С каждым днем я все меньше бодрствую.", "Утро вечера мудренее?"],
		"events": base_events_array
	},
	{
		"wake_up_dialog": ["Я все ближе и ближе к финалу.", "Еще два дня экспериментов и надеюсь, все получится."],
		"sleep_dialog": ["Голова... кружится... Надо... поспать..."],
		"events": base_events_array
	},
	{
		"wake_up_dialog": ["Последний день.", "Завтра всё решится."],
		"sleep_dialog": ["Все. Завтра. Надеюсь... получится..."],
		"events": base_events_array
	},
	{
		"wake_up_dialog": ["И так...", "Надо посмотреть, как там Муся."],
		"sleep_dialog": ["Все. Завтра. Надеюсь... получится..."],
		"events": ["wake_up",
				"wake_up_dialog",
				"check_the_cat_quest"]
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
		"go_to_sleep_quest":
			QuestUi.show_quest("-Идти спать")
		"sleep":
			player.disable()
			FadeScreen.fade_out() 
			FadeScreen.fade_finished.connect(_on_day_finished, CONNECT_ONE_SHOT)
		"check_the_cat_quest":
			QuestUi.show_quest("-Что же с Мусей...")

func _on_day_finished() -> void:
	current_day += 1
	current_event = -1
	cat.update_cat()
	_update_world()
	next_event()
	
func complete_event(event_name: String) -> void:
	if get_current_event() == event_name:
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
	calculate_ending()
	FadeScreen.fade_in()
	get_tree().change_scene_to_file("res://scenes/endings/ending.tscn")
	
func calculate_ending() -> void:
	if current_day != 5:
		ending = 0
		return
	if is_anime_eaten:
		ending = 6
		return
	if is_pills_eaten:
		ending = 5
		return
	if cat.esotericity < 25 and cat.radioactivity < 25 and cat.holiness < 25:
		ending = 4
		return
	
	var stats = [cat.esotericity, cat.radioactivity, cat.holiness]
	var max_index = stats.find(stats.max())
	
	ending = max_index + 1
	
func _update_world() -> void:
	for obj in get_tree().get_nodes_in_group("day_objects"):
		obj.visible = false
		obj.process_mode = Node.PROCESS_MODE_DISABLED
		if obj.has_node("CollisionShape3D"):
			obj.get_node("CollisionShape3D").disabled = true

	for obj in get_tree().get_nodes_in_group("day_%d" % current_day):
		obj.visible = true
		obj.process_mode = Node.PROCESS_MODE_INHERIT
		if obj.has_node("CollisionShape3D"):
			obj.get_node("CollisionShape3D").disabled = false
