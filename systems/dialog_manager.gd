extends CanvasLayer

var label: Label

var current_line: int = 0
var is_typing: bool = false
var lines: Array

var tween: Tween

signal dialog_finished

func _ready() -> void:
	label = $ColorRect/MarginContainer/Label
	visible = false
	
	#show_dialog(["дэмн!!!!?",
	 #"шла Саша по шоссе и сосала амогус!!!",
	 #"це кинец и т.д.",
	 #"внимаение сотрудники гражданской обороны.
	#Идите нахуй
	#Конец связи"])

func show_dialog(new_lines: Array) -> void:
	lines = new_lines
	current_line = 0
	visible = true
	EventManager.disable_player()
	
	_type_line()

func _type_line() -> void:
	if tween:
		tween.kill()
		
	label.text = ""
	is_typing = true
	var full_text = lines[current_line]
	tween = create_tween()
	label.text = full_text
	label.visible_characters = 0
	tween.tween_property(label, "visible_characters", len(full_text), len(full_text) * 0.05)
	tween.finished.connect(func(): is_typing = false)
	
	
func _input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("interact") and is_typing:
		if tween:
			tween.kill()
		label.visible_characters = -1
		is_typing = false
	elif event.is_action_pressed("interact") and not is_typing:
		next_line()

func next_line() -> void:
	current_line += 1
	if current_line >= lines.size():
		visible = false
		EventManager.enable_player()
		dialog_finished.emit()
	else:
		_type_line()
		
		

	
