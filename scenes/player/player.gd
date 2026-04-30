class_name Player
extends CharacterBody3D

@onready var head: Head = $Head
@onready var interaction_raycast: RayCast3D = $Head/RayCast3D
@onready var hand: Node3D = $Head/Hand

var current_state = State.Walk
var current_item: Item = null

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var GRAVITY = ProjectSettings.get_setting("physics/3d/default_gravity")
const MOUSE_SENS: float = 0.25

enum State {
	Walk,
	Crouch,
	Disabled
}

func add_item(item: Item) -> void:
	item.reparent(hand)
	item.disable()
	item.global_position = hand.global_position
	
	print(item.global_position)
	print(hand.global_position)
	current_item = item

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func walk(delta: float) -> void:
	var direction := get_direction()
	
	velocity.y -= GRAVITY * delta
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
func crouch(delta: float) -> void:
	pass
	
func disabled(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	match current_state:
		State.Walk:
			walk(delta)
		State.Crouch:
			crouch(delta)
		State.Disabled:
			disabled(delta)
	
	head.handle_camera(get_raw_direction(), delta, current_state, velocity)
	
	move_and_slide()
	
func get_direction() -> Vector3:
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	return (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
func get_raw_direction() -> Vector2:
	return Input.get_vector("left", "right", "forward", "back")
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_camera(event)
	
func rotate_camera(event: InputEventMouseMotion) -> void:
	rotate_y(deg_to_rad(-event.relative.x * MOUSE_SENS))
	head.rotate_x(deg_to_rad(-event.relative.y * MOUSE_SENS))
	head.rotation.x = clamp(head.rotation.x, deg_to_rad(-89), deg_to_rad(89))
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_fullscreen"):  # Создайте действие в Project Settings
		toggle_fullscreen()
		
	if event.is_action_pressed("interact"):
		check_interaction()
		
	if event.is_action_pressed("drop"):
		drop_item()
	
func toggle_fullscreen() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		print("Переключено в оконный режим")
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		print("Переключено в полноэкранный режим")
		
func check_interaction():
	if not interaction_raycast.is_colliding():
		return
		
	var collider = interaction_raycast.get_collider()
	if collider and collider.has_method("interact"):
		collider.interact(self)
		
func drop_item():
	print(current_item)
	if current_item != null:
		print("дропни папочке")
		var item_instance = current_item.item_scene.instantiate()
		get_tree().root.add_child(item_instance)
		item_instance.global_position = hand.global_position
		current_item.queue_free()
		current_item = null
		
