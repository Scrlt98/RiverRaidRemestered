extends CharacterBody2D

class_name Player

@export_group("Sonidos")
@export var acelera: AudioStream
@export var loop: AudioStream
@export var decelera: AudioStream
@export var explosionS: AudioStream
@export_group("")
#region Player movement variables
@export_group("Movement")
@export var acceleration: float = 500
@export var deceleration: float = 400
@export var max_speed: float = 200
@export var min_speed: float = 50

@export var aire_resistencia: float = 100
@export_group("")
#endregion
#region animacion
@onready var animacion2d:  AnimatedSprite2D = $AnimatedSprite2D 
@onready var animacion2dw: AnimatedSprite2D = $AnimatedSprite2D/AnimatedSprite2Dw
@onready var podersistema: sistemapoder = $PoderSistema
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer
#endregion

var start_sound = false
var end_sound = false

func _physics_process(delta: float) -> void:
	
	#region colision
	var colision = get_last_slide_collision()
	if colision != null:
		print("Pendejo")
		explode() 
		return
	#endregion
	#region Horizontal movement
	if Input.is_action_pressed("right"):
		velocity.x = min(velocity.x + acceleration * delta, max_speed)
	elif Input.is_action_pressed("left"):
		velocity.x = max(velocity.x - acceleration * delta, -max_speed)
	else:
		velocity.x = move_toward(velocity.x, 0, delta + aire_resistencia)
	#endregion
	
	#region Vertical movemet
	if Input.is_action_pressed("aceleracion"):
		velocity.y = max(velocity.y - acceleration * delta, -max_speed)
		if animacion2dw.animation != "aceleracion":
			animacion2dw.play("propulsor")
		if !start_sound:
			start_sound = true
			play_sonidos(acelera)
	elif Input.is_action_pressed("freno"):
		velocity.y = min(velocity.y + deceleration * delta, -min_speed)
		if animacion2d.animation != "freno":
			animacion2d.play("default")
		if !end_sound && end_sound:
			play_sonidos(decelera)
			end_sound = true
	elif velocity.y < 0:
		velocity.y = min(velocity.y + aire_resistencia * delta, -min_speed)
	#endregions
	move_and_slide()
	
func explode():
	animacion2d.play("explosion nave")
	animacion2d.modulate = Color.BLACK
	set_physics_process(false)
	velocity = Vector2.ZERO
	podersistema.detenertiempo()
	audio.stream = explosionS
	audio.play()
	
	

func _on_animated_sprite_2d_animation_finished() -> void:
	if animacion2d.animation == "explosion nave":
		queue_free() 
		

func play_sonidos(stream: AudioStream):
	if audio.playing:
		audio.stop()
		
	audio.stream = stream
	audio.play()
	
	

func _on_audio_stream_player_finished() -> void:
	if audio.stream == acelera:
		play_sonidos(loop)
		
	if audio.stream == decelera:
		start_sound = false
		end_sound = false
