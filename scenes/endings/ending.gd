extends CanvasLayer

var endings: Array = [
	{
		"text": [""],
		"image": preload("res://assets/ending pictures/0.png")
	}
	]

func _ready() -> void:
	await get_tree().process_frame
	var ending_number = EventManager.ending
	var text = endings[ending_number]["text"]
	var picture = endings[ending_number]["image"]
	DialogManager.show_dialog(["попа", "и жопа", "офрыаолфаолфраолфра"])
