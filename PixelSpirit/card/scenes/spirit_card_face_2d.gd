class_name SpiritCardFace2D
extends Node3D

@export_file("*.tres") var mat: String
@export var the_name: String
@export var major_arcana: String

@onready var front_face_2d = preload("res://2D/card/front_face_2d.tscn")

@onready var front: MeshInstance3D = $card_face_2d_uv/Front
@onready var card_name: Label3D = $CardName
@onready var sub_viewport: SubViewport = $SubViewport

func _ready() -> void:
	var new_front_face = front_face_2d.instantiate() as FrontFace2D

	var _mat = load(mat)

	new_front_face.init_card(_mat, major_arcana)

	await new_front_face.done

	sub_viewport.add_child(new_front_face)

	var viewport_texture = sub_viewport.get_texture()
	var new_mat = front.material_override as ShaderMaterial
	new_mat.set_shader_parameter("texture_albedo", viewport_texture)
	front.material_override = new_mat

	card_name.text = the_name

