@tool
class_name Card
extends Node3D

@export_file("*.tres") var mat: String
@export var the_name: String
@export var major_arcana: String

@onready var front: MeshInstance3D = $card/Front
@onready var major_arcana_number: Label3D = $MajorArcanaNumber
@onready var card_name: Label3D = $CardName

func _process(delta: float) -> void:
	if the_name != card_name.text :
		card_name.text = the_name
	if not major_arcana.is_empty():
		if major_arcana_number.text != "- " + major_arcana + " -":
			major_arcana_number.text = "- " + major_arcana + " -"
	
	if mat.is_empty() : return
	
	var new_mat = load(mat)
	
	if front.material_override == new_mat : return
	
	front.material_override = new_mat
