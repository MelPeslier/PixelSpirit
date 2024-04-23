@tool
class_name SpiritCard
extends Node3D


@export_file("*.tres") var mat: String : set = _set_mat
@export var the_name: String : set = _set_the_name
@export var major_arcana: String : set = _set_major_arcana

@onready var front: MeshInstance3D = $card/Front
@onready var major_arcana_number: Label3D = $MajorArcanaNumber
@onready var card_name: Label3D = $CardName


func _ready() -> void:
	# Call to init the card
	the_name = the_name
	major_arcana = major_arcana
	mat = mat


#region Setters
func _set_mat(_mat: String) -> void:
	if _mat.is_empty(): return
	var new_mat: ShaderMaterial = load(mat)
	front.material_override = new_mat

func _set_the_name(_the_name: String) -> void:
	the_name = _the_name
	card_name.text = _the_name

func _set_major_arcana(_major_arcana: String) -> void:
	major_arcana = _major_arcana
	if _major_arcana.is_empty():
		major_arcana_number.text = ""
		return

	major_arcana_number.text = "- " + _major_arcana + " -"
#endregion
