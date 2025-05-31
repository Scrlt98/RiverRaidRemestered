extends Node2D

class_name disparar

const proyectil_escena = preload("res://Escenas/disparo.tscn")
@onready var proyectil_punto_de_spawm: Marker2D = $Misislspawn
@onready var audio: AudioStreamPlayer = $AudioStreamPlayer

var disparo_disponible = true

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("disparo") and disparo_disponible:
		var proyectil = proyectil_escena.instantiate()
		proyectil.global_position = proyectil_punto_de_spawm.global_position
		get_tree().root.add_child(proyectil)
		proyectil.tree_exited.connect(proyectil_destruido)
		disparo_disponible = false
		audio.play()
	#elif Input.is_action_pressed("disparo") and  disparo_disponible:
		#var proyectil = proyectil_escena.instantiate()
		#proyectil.global_position = proyectil_punto_de_spawm.global_position
		#get_tree().root.add_child(proyectil)
		#proyectil.tree_exited.connect(proyectil_destruido)
		#disparo_disponible = false

func proyectil_destruido():
	disparo_disponible = true
