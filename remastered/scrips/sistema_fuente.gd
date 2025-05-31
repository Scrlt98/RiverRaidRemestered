extends Node

class_name Principal

@export var vidas_jugador = 3
const escena_del_jugador = preload("res://Escenas/player.tscn")

@onready var jugador: Player = $Player
@onready var puentes: Node = $Puente_checkpoint
@onready var UI: sistemaUI = $SistemaUI
@onready var camara: PhantomCamera2D = $PhantomCamera2D
var respawn = Vector2(0, 0)



func _ready() -> void:
	var nodos_puente = puentes.get_children() as Array[Puente]
	for puente in nodos_puente:
		puente.punto_spaw.connect(on_punto_spawn)
		
	
	UI.aplicacion_vidas(vidas_jugador)
	jugador.connect("tree_exited", on_jugador_tree)
			
func on_punto_spawn(punto_respawn):
	respawn = punto_respawn
	
	
func on_jugador_tree():
	vidas_jugador -= 1
	if vidas_jugador == 0:
		UI.gameover.show()
	else:  
		respawn_del_jugador()
		UI.aplicacion_vidas(vidas_jugador)
		
	
		
	
		
func respawn_del_jugador():
	jugador = escena_del_jugador.instantiate()
	get_tree().root.get_node("main").add_child(jugador)
	jugador.global_position = respawn
	camara.follow_target = jugador
	jugador.connect("tree_exited", on_jugador_tree)
	

	
	
	
func _on_w_1n_body_entered(body: Node2D) -> void:
	if body is Player:
		UI.youwin.show()
		##get_tree().paused  = true
