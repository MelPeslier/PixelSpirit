@tool
class_name FrontFace2D
extends Control

signal done

const RATIO := 1.6205
#@export var RATIO := 1.6205
const LABEL_RATIO := 0.13
const TEXT_RATIO := 0.12

@export_subgroup("Variables")
@export var resolution: float = 200

@export_subgroup("Nodes")
@export var squarred_uv: ColorRect
@export var sub_viewport: SubViewport
@export var transform_text: TextureRect
@export var arcane_number: Label


func _process(_delta: float) -> void:
	if Engine.is_editor_hint:
		if resolution > 2:
			update_sizes(resolution)


func init_card(mat: ShaderMaterial, arcana_text: String) -> void:
	# Update text
	var text: String = ""
	if not arcana_text.is_empty():
		text = "- " + arcana_text + " -"
	arcane_number.text = text

	update_sizes(resolution)

	# Update material
	squarred_uv.material = mat

	await RenderingServer.frame_post_draw
	var viewport_texture = sub_viewport.get_texture()
	transform_text.texture = viewport_texture

	done.emit()


func update_sizes(new_resolution: float) -> void:
	var new_size = Vector2(new_resolution, new_resolution * RATIO)
	size = new_size
	anchors_preset = PRESET_CENTER

	var new_squared_size = Vector2(new_resolution * RATIO, new_resolution * RATIO)
	squarred_uv.size = new_squared_size
	squarred_uv.anchors_preset = PRESET_CENTER

	var new_font_size: int = int(new_resolution * TEXT_RATIO)
	new_font_size = max(new_font_size, 16)
	arcane_number.add_theme_font_size_override("font_size", new_font_size)
	arcane_number.anchors_preset = PRESET_CENTER_TOP
	arcane_number.size = Vector2.ZERO

	sub_viewport.size = arcane_number.size
	transform_text.size = arcane_number.size
	transform_text.anchors_preset = PRESET_CENTER_TOP



