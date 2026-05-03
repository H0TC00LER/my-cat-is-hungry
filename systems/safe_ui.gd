extends CanvasLayer

var safe: Safe = null
var entered: Array[int] = []

@onready var label: Label = $Label

func _ready() -> void:
	visible = false
	
	$GridContainer/Button.pressed.connect(func(): _on_number_pressed(1))
	$GridContainer/Button2.pressed.connect(func(): _on_number_pressed(2))
	$GridContainer/Button3.pressed.connect(func(): _on_number_pressed(3))
	$GridContainer/Button4.pressed.connect(func(): _on_number_pressed(4))
	$GridContainer/Button5.pressed.connect(func(): _on_number_pressed(5))
	$GridContainer/Button6.pressed.connect(func(): _on_number_pressed(6))
	$GridContainer/Button7.pressed.connect(func(): _on_number_pressed(7))
	$GridContainer/Button8.pressed.connect(func(): _on_number_pressed(8))
	$GridContainer/Button9.pressed.connect(func(): _on_number_pressed(0))
	$GridContainer/Clear.pressed.connect(_on_clear_pressed)
	$GridContainer/Exit.pressed.connect(_on_exit_pressed)
	$GridContainer/Enter.pressed.connect(_on_confirm_pressed)


func open(target: Safe) -> void:
	EventManager.disable_player()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
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
		EventManager.enable_player()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		safe.open_door()
	else:
		label.text = "Неверно"
		await get_tree().create_timer(1.0).timeout
		entered = []
		label.text = ""
		
func _on_exit_pressed() -> void:
	visible = false
	EventManager.enable_player()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_clear_pressed() -> void:
	if entered.size() > 0:
		entered.remove_at(entered.size() - 1)
		label.text = " ".join(entered.map(func(x): return str(x)))
