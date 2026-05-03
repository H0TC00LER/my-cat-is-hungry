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
	}
	]

func _ready() -> void:
	await get_tree().process_frame
	var ending_number = EventManager.ending
	var text = endings[ending_number]["text"]
	var picture = endings[ending_number]["image"]
	DialogManager.show_dialog(text)
	texture_rect.texture = picture
	
