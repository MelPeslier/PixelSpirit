@tool
extends ColorRect

var canvas_size : Vector2 : set = _set_canvas_size

@onready var mat : ShaderMaterial = material


func _ready() -> void:
	canvas_size = size

func _process(delta: float) -> void:
	canvas_size = size


func _set_canvas_size(_canvas_size: Vector2) -> void:
	canvas_size = _canvas_size
	var _scale = Vector2.ONE
	_scale.y = canvas_size.y / canvas_size.x
	_scale.x = canvas_size.x / canvas_size.y
	mat.set_shader_parameter("scale", _scale)
