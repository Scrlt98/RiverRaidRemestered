extends Node

class_name sistemapoder

var maxpoder = 30
var minpoder = 0
var currentpoder

@onready var ui: sistemaUI = $"/root/main/SistemaUI"

@onready var reduccion: Timer = $ReduccionTimer
@onready var crecimiento: Timer = $CrecimientoTimer

func _ready() -> void:
	currentpoder = maxpoder
	ui.setuppower(maxpoder)


func _on_reduccion_timer_timeout() -> void:
	currentpoder -= 1
	print(currentpoder)
	ui.cambio_indicador(Vector2.LEFT, reduccion.wait_time)
	
	if currentpoder == 0:
		(get_parent() as Player).explode()

func _on_crecimiento_timer_timeout() -> void:
	if currentpoder < maxpoder:
		currentpoder += 1
		ui.cambio_indicador(Vector2.RIGHT, crecimiento.wait_time)
		
		
		

func incrementofuel():
	crecimiento.start()
	reduccion.stop()
	
func reduccionfuel():
	reduccion.start()
	crecimiento.stop()
	
func detenertiempo():
	reduccion.stop()
	crecimiento.stop()
