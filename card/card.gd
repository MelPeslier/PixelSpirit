@tool
class_name SpiritCard
extends Node3D


@export_file("*.tres") var mat: String
@export var the_name: String
@export var major_arcana: String

@onready var front: MeshInstance3D = $card/Front
@onready var major_arcana_number: Label3D = $MajorArcanaNumber
@onready var card_name: Label3D = $CardName


func _ready() -> void:
	card_name.text = the_name
	if not major_arcana.is_empty():
		major_arcana_number.text = "- " + major_arcana + " -"
	var new_mat = load(mat)
	front.material_override = new_mat

func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		card_name.text = the_name
		if not major_arcana.is_empty():
			major_arcana_number.text = "- " + major_arcana + " -"
		
		if mat:
			var new_mat = load(mat)
			front.material_override = new_mat
