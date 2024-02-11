extends Control

@export var game_scenes: Array[PackedScene]

var current_scene_index: int = 0
var current_screen:Screen

signal call_transition

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_next()
	apply()


func start() -> void:
	current_screen.start()


func get_next() -> void:
	current_screen = game_scenes[current_scene_index].instantiate()
	current_screen.connect("go_to", navigate)


func navigate(to_index:int) -> void:
	current_scene_index = to_index
	get_next()
	emit_signal("call_transition")


func apply() -> void:
	if get_child_count() > 0:
		remove_child(get_child(0))
	add_child(current_screen)
