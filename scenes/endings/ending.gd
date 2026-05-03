extends CanvasLayer

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect

var endings: Array = [
	{
		"text": ["Мир снаружи мертв уже много лет.",
		"Но в конце концов...",
		"От судьбы не убежать, не правда ли...",
		"Прости Муся, но я должен идти.",
		"Мне жаль, что с тобой случилось, но нам обоим будет лучше, если всё это закончится.",
		"Концовка Ноль: Прощай Муся"
		],
		"image": preload("res://assets/ending pictures/0.png")
	},
	{
		"text": ["Господи, я сам не знаю, что я породил.",
		"Оно уничтожит нас всех!",
		"Я должен бежать, я должен...",
		"О нет.",
		"Оно нашло меня.",
		"Концовка Один: Порождение Эзотерии"
		],
		"image": preload("res://assets/ending pictures/1.png")
	},
	{
		"text": ["Оказалось, Муся была не Мусей, а Мусяней Мисяновичем.",
		"И она оказалось очень интересным собеседником.",
		"Меня лишь немного смущают святящиеся щупальца...",
		"Концовка Два: Разуманая Жизнь?"
		],
		"image": preload("res://assets/ending pictures/2.png")
	},
	{
		"text": ["Наконец-то я понял.",
		"Я есть пророк, а Муся есть послание с самих небес.",
		"Она прибыла на эту землю, чтобы восстановить ее из пепла старых катастроф и сотрясений.",
		"И я...",
		"Ее избранник?",
		"Перед нами стоит непростая задача, но пока я буду ведом высшими силами, свет одолеет тьму!",
		"Концовка Три: Рай на Земле?"
		],
		"image": preload("res://assets/ending pictures/3.jpg")
	},
	{
		"text": ["О, моя любимая Муся.",
		"Никогда больше я не буду ставить над тобой эксперименты, никогда больше!",
		"Концовка Четыре: Вот и всё."
		],
		"image": preload("res://assets/ending pictures/4.png")
	},
	{
		"text": ["МУСЯЯЯЯЯЯЯЯ",
		"Не уходи!!!!",
		"Стоп, моя комната???",
		"Куда всё пропадает?",
		"Концовка Пять: Реальность и фантазия?"
		],
		"image": preload("res://assets/ending pictures/5end.png")
	},
	{
		"text": ["О, дорогая Муся, я даже не знал, что такое возможно.",
		"Всё же счастье возможно в этом проклятом мире.",
		"Концовка Шесть: Кошкожены и их последствия для общества."
		],
		"image": preload("res://assets/ending pictures/6end.png")
	},
	]

func _ready() -> void:
	await get_tree().process_frame
	var ending_number = EventManager.ending
	var text = endings[ending_number]["text"]
	var picture = endings[ending_number]["image"]
	DialogManager.dialog_finished.connect(_on_dialog_finished)
	DialogManager.show_dialog(text)
	texture_rect.texture = picture
	
func _on_dialog_finished() -> void:
	EventManager.reset()
	get_tree().change_scene_to_file("res://scenes/levels/main_menu.tscn")
	
