extends CanvasLayer

var safe: Safe = null
var entered: Array[int] = []

@onready var label: Label = $Label

func _ready() -> void:
	visible = false

func open(target: Safe) -> void:
	safe = target
	entered = []
	label.text = ""
	visible = true

func _on_number_pressed(n: int) -> void:
	if entered.size() >= safe.correct_code.size():
		return
	entered.append(n)
	label.text = " ".join(entered.map(func(x): return str(x)))

func _on_confirm_pressed() -> void:
	if safe.try_code(entered):
		visible = false
		safe.open_door()
	else:
		label.text = "Неверно"
		await get_tree().create_timer(1.0).timeout
		entered = []
		label.text = ""

func _on_clear_pressed() -> void:
	if entered.size() > 0:
		entered.remove_at(entered.size() - 1)
		label.text = " ".join(entered.map(func(x): return str(x)))
