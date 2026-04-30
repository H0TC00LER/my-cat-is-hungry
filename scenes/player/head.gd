class_name Head
extends Node3D

@onready var camera: Camera3D = $Camera3D
#@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D

enum State {
	Walk,
	Crouch,
	Disabled
}

#tilt
var current_tilt := 0.0
const tilt_amount: float = 5
var target_tilt = 0.0
const tilt_speed := 8.0 
const return_speed := 4.0 

#walk
const walk_speed = 5.0
const walk_intensity = 4.0

#run
const run_speed = 10.0
const run_intensity = 8.0

var camera_bob_time: float = 0.0
	
var direction: Vector2
var delta: float
var current_state: State
var velocity: Vector3
	
func handle_camera(direction: Vector2, delta: float, current_state: State, velocity: Vector3) -> void:
	self.direction = direction
	self.delta = delta
	self.current_state = current_state
	self.velocity = velocity
	
	apply_camera_bob()
	tilt()
	
func tilt() -> void:
	if direction.x > 0.1:  # Движение вправо
		target_tilt = -tilt_amount
	elif direction.x < -0.1:  # Движение влево
		target_tilt = tilt_amount
	else:
		target_tilt = 0.0
	
	# Плавный интерполяция текущего наклона к целевому
	current_tilt = lerp(current_tilt, target_tilt, delta * (tilt_speed if target_tilt != 0 else return_speed))
	
	# Применяем наклон к камере (по оси Z)
	camera.rotation_degrees.z = current_tilt
	
func apply_camera_bob():
	if direction != Vector2.ZERO:
		bob(walk_speed, walk_intensity, delta)
	else:
		camera.transform.origin = camera.transform.origin.lerp(Vector3.ZERO, delta * 10)

func bob(speed: float, intensity: float, delta: float) -> void:
	camera_bob_time += delta * speed
	
	#if abs(sin(camera_bob_time)) > 0.997:
		#audio_stream_player_3d.play()
	
	var bob_offset = Vector3(
		sin(camera_bob_time) * 0.02 * intensity,
		sin(camera_bob_time * 2) * 0.01 * intensity,
		0
	)
	camera.transform.origin = camera.transform.origin.lerp(bob_offset, delta * 10)
	#camera.transform.origin = bob_offset
	
func apply_landing_shake() -> void:
	pass
