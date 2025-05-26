extends CanvasLayer

class_name sistemaUI

@export var min_indicador_x_posi: float
@export var max_indicador_x_posi: float
@export var factor_decresiente: float = 1

@onready var indicador: TextureRect = $"Panel de control/Indicador"
@onready var puntos: Label = $"Panel de control/Puntos"
@onready var vidas: Label = $"Panel de control/Vidas"
@onready var gameover: CenterContainer = $GameOver

var puntos_totales = 0
var indicador_x_posi: float

func  _ready() -> void:
	indicador_x_posi = max_indicador_x_posi
	puntos.text = "Points %d" % puntos_totales
	
func setuppower(maxpower: float):
	factor_decresiente = (max_indicador_x_posi - min_indicador_x_posi) / maxpower
	

func cambio_indicador(direccion: Vector2, ent_tiempo: float):
	var ent = create_tween()
	ent.tween_property(indicador, "position", direccion * factor_decresiente, ent_tiempo).from_current().as_relative()
	

func gameover_():
	gameover.show()
