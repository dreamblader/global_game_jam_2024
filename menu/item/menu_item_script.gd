extends Node2D

@export var select_color: Color 
@export var normal_color: Color 
@export var text:String = "..."

@onready var label:Label = $Label
@onready var animation:AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	label.add_theme_color_override("font_color", normal_color)
	label.text = text


func select() -> void:
	label.add_theme_color_override("font_color", select_color)
	animation.play("select")


func unselect() -> void:
	label.add_theme_color_override("font_color", normal_color)
	animation.play("RESET")
