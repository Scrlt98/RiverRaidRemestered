extends Resource

class_name npc_configuracion

@export var npc_colision: RectangleShape2D
@export_enum("barco", "avion", "helicoptero") var npc_tipo: String = "barco"
@export var explosion_color: Color
@export var velocidad: float = 50
@export var puntos: int = 75
